require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:michael).id,
    followed_id: users(:archer).id)
  end

  test "should be valid with valid follower and followed ids" do
    assert @relationship.valid?
  end

  test "should be invalid without a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should be invalid without a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
