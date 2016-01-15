class Monster < ActiveRecord::Base
  ELEMENTS = %w[fire water earth electric wind]
  LIMIT_PER_TEAM = 3
  LIMIT_PER_USER = 20

  belongs_to :user, required: true
  belongs_to :team

  enum element: ELEMENTS.inject({}) { |h, n| h[n.to_sym] = n; h }

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id, if: :name? }
  validates :element, inclusion: ELEMENTS
  validate :must_not_exceeds_limit_per_team!, on: [:create, :update], if: -> { team_id_changed? && team_id }
  validate :must_not_exceeds_limit_per_user!, on: :create

  def weakness
    ELEMENTS[(ELEMENTS.index(element) + 1) % ELEMENTS.size]
  end

  private

    def must_not_exceeds_limit_per_team!
      errors.add :base, "Only #{LIMIT_PER_TEAM} monsters maximum allowed per team" if team && team.monsters.size >= LIMIT_PER_TEAM
    end

    def must_not_exceeds_limit_per_user!
      errors.add :base, "Cannot create more than #{LIMIT_PER_USER} teams per user" if user && user.monsters.size >= LIMIT_PER_USER
    end

end
