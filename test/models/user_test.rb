require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "userの存在性" do
    assert @user.valid?
  end

  test "nameが空の場合" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "emailが空の場合" do
    @user.email = " "
    assert_not @user.valid?
  end
end
