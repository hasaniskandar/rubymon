class User < ActiveRecord::Base
  before_save :ensure_authentication_token

  devise :database_authenticatable, :registerable, :omniauthable, omniauth_providers: [:facebook]

  has_many :teams, dependent: :destroy
  has_many :monsters, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email    = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name     = auth.info.name  # assuming the user model has a name
      # user.image    = auth.info.image # assuming the user model has an image
    end
  end

  def ensure_authentication_token
    self.authentication_token = generate_authentication_token unless authentication_token?
  end

  private

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.exists?(authentication_token: token)
      end
    end

end
