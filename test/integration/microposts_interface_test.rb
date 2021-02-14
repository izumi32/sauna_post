require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @micropost = microposts(:sakae)
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
                                                   sauna: :presence,
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

  test "micropostの検索" do
    log_in @user
    get root_url
    # 有効な検索
    get root_path, params: { search: { name: @micropost.name } }
    assert_select "span", "名前：#{@micropost.name}"
    get root_path, params: { search: { address: @micropost.address } }
    assert_select "span", "住所：#{@micropost.address}"
    get root_path, params: { search: { price_from: @micropost.price - 100,
                                       price_to: @micropost.price + 100} }
    assert_select "span", "料金：#{@micropost.price}円"
    get root_path, params: { search: { sauna: @micropost.sauna } }
    assert_select "span", "サウナ：#{Micropost.human_attribute_name "sauna.#{@micropost.sauna}"}"
    get root_path, params: { search: { evaluate: @micropost.evaluate } }
    assert_select "span", "評価：#{@micropost.evaluate}"
    # 空で検索
    get root_path, params: { search: { name: "",
                                       address: "",
                                       price_from: "",
                                       price_to: "",
                                       sauna: "",
                                       evaluate: "" } }
    @user.feed.each do |micropost|
      assert_match micropost.name, response.body
      assert_match micropost.address, response.body
      assert_match micropost.price.to_s, response.body
      assert_match Micropost.human_attribute_name("sauna.#{micropost.sauna}"), response.body
      assert_match micropost.evaluate.to_s, response.body
    end
  end
end
