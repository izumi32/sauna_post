require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                 password: "foobar", password_confirmation: "foobar")
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

  test "emailが重複している場合" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "passwordが空の場合" do
    @user.password = @user.password_confirmation = " "
    assert_not @user.valid?
  end

  test "passwordが5文字以下の場合" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "remember_digestがnilの状態でauthenticated?を実行した場合" do
    assert_not @user.authenticated?("foobar")
  end

  test "micropostと紐づいているuserを削除した場合" do
    @user.save
    @user.microposts.create(name: "極楽湯",
                            address: "埼玉県和光市",
                            price: 730,
                            sauna: 1,
                            evaluate: 4)
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "フォロー/アンフォローする" do
    michael = users(:michael)
    archer = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end
end
