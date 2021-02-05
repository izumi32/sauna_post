require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "micropostのUI" do
    log_in @user
    get root_path
    # 無効な送信
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { name: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { name: "かるまる",
                                                   address: "東京都豊島区",
                                                   price: 3000,
                                                   sauna: 1,
                                                   evaluate: 4 } }
    end
    assert_redirected_to root_url
    follow_redirect!
    # 投稿を削除する
    assert_select 'a', text: '削除'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # 違うユーザーのプロフィールにアクセス（削除リンクがないことを確認）
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
