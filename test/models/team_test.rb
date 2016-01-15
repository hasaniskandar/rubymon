require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  setup do
    @user = users(:user_3)
    @valid_attributes = {
      user_id: @user.id,
      name:    'Team One'
    }
  end

  test "should save team with valid attributes" do
    assert Team.new(@valid_attributes).save
  end

  test "should not save team without user" do
    assert_not Team.new(@valid_attributes.except(:user_id)).save
  end

  test "should not save team without name" do
    assert_not Team.new(@valid_attributes.except(:name)).save
  end

  test "should not save team due to the limit per user" do
    assert_not users(:user_2).teams.new(@valid_attributes.except(:user_id)).save
  end
end
