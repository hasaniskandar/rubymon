require 'test_helper'

class MonsterTest < ActiveSupport::TestCase
  setup do
    @user = users(:user_3)
    @valid_attributes = {
      user_id: @user.id,
      name:    'Monster One',
      element: 'fire'
    }
  end

  test "should save monster with valid attributes" do
    assert Monster.new(@valid_attributes).save
  end

  test "should not save monster without user" do
    assert_not Monster.new(@valid_attributes.except(:user_id)).save
  end

  test "should not save monster without name" do
    assert_not Monster.new(@valid_attributes.except(:name)).save
  end

  test "should not save monster without element" do
    assert_not Monster.new(@valid_attributes.except(:element)).save
  end

  test "should not save monster due to the limit per user" do
    assert_not users(:user_1).monsters.new(@valid_attributes.except(:user_id)).save
  end

  test "should not save monster due to the limit per team" do
    assert_not monsters(:monster_2_4).update(team_id: teams(:team_2_1).id)
  end
end
