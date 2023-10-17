require "test_helper"

class LinksTest < ActionDispatch::IntegrationTest
  test "links index" do
    get links_path
    assert_response :ok
  end

  test "links index pagination" do
    get links_path(page: 2)
    assert_response :redirect
  end

  test "link show" do
    get link_path(links(:guest))
    assert_response :ok
  end

  test "creating link requires url" do
    post links_path, params: { link: { url: "" } }
    assert_response :unprocessable_entity
  end

  test "creating link as guest" do
    assert_difference "Link.count" do
      post links_path(format: :turbo_stream), params: { link: { url: "https://charity-finder.ca" } }
      assert_response :ok
      assert_nil Link.last.user_id
    end
  end

  test "creating link as user" do
    user = users(:one)
    sign_in user
    assert_difference "Link.count" do
      post links_path(format: :turbo_stream), params: { link: { url: "https://charity-finder.ca" } }
      assert_response :ok
      assert_equal user.id, Link.last.user_id
    end
  end

  test "guest cannot edit a user's link" do
    get edit_link_path(links(:two))
    assert_response :redirect
  end

  test "guest cannot edit any link" do
    get edit_link_path(links(:guest))
    assert_response :redirect
  end

  test "users can edit their own link" do
    sign_in users(:one)
    get edit_link_path(links(:one))
    assert_response :ok
  end

  test "user cannot edit another user's link" do
    sign_in users(:one)
    get edit_link_path(links(:two))
    assert_response :redirect
  end

  test "user cannot edit a guest's link" do
    sign_in users(:one)
    get edit_link_path(links(:guest))
    assert_response :redirect
  end
end
