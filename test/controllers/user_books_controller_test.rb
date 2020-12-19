require 'test_helper'

class UserBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_books_create_url
    assert_response :success
  end

  test "should get update" do
    get user_books_update_url
    assert_response :success
  end

  test "should get destroy" do
    get user_books_destroy_url
    assert_response :success
  end

end
