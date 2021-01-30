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

  test "有効なemailの場合" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address}は無効です"
    end
  end
end
