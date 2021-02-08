require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(follower_id: users(:michael).id,
                                     followed_id: users(:archer).id)
  end

  test "relationshipの有効性" do
    assert @relationship.valid?
  end

  test "follower_idがnilの場合" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "followed_idがnilの場合" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
