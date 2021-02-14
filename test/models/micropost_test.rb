require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(name: "極楽湯",
                               address: "埼玉県和光市",
                               price: 730,
                               sauna: :presence,
                               evaluate: 4,
                               user_id: @user.id)
  end

  test "有効なmicropost" do
    assert @micropost.valid?
  end

  test "user_idがない場合" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "順序付け" do
    assert_equal microposts(:gokuraku), Micropost.first
  end
end
