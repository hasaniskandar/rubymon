class Team < ActiveRecord::Base
  LIMIT_PER_USER = 3


  belongs_to :user, required: true
  has_many :monsters, dependent: :nullify

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id, if: :name? }
  validate :must_not_exceeds_limit_per_user!, on: :create

  private

    def must_not_exceeds_limit_per_user!
      errors.add :base, "Cannot create more than #{LIMIT_PER_USER} teams per user" if user && user.teams.size >= LIMIT_PER_USER
    end

end
