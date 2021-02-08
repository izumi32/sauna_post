require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest

  test "非ログイン時createにリクエスト" do
    assert_no_difference 'Relationship.count' do
      post relationships_path
    end
    assert_redirected_to login_url
  end

  test "非ログイン時destroyにリクエスト" do
    assert_no_difference 'Relationship.count' do
      delete relationship_path(relationships(:one))
    end
    assert_redirected_to login_url
  end
end
