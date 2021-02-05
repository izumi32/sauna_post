require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @micropost = microposts(:gokuraku)
  end

  test "非ログイン時newにリクエスト" do
    get newpost_path
    assert_redirected_to login_url
  end

  test "非ログイン時createにリクエスト" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { microposts: { name: "久松湯",
                                                    address: "東京都練馬区",
                                                    price: 500,
                                                    sauna: 1,
                                                    evaluate: 3 } }
    end
    assert_redirected_to login_url
  end

  test "非ログイン時destroyにリクエスト" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "別のユーザーでdestroyにリクエスト" do
    log_in users(:michael)
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to root_url
  end
end
