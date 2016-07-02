require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    @invalid_user = { name: "", email: "invalid@user..com", password: "foo",
              password_confirmation: "bar" }
    @valid_user = { name:  "Example User", email: "user@example.com",
                    password: "password", password_confirmation: "password" }
  end

  test "invalid signup information" do
    get signup_path # It's intirely necessary, but double-check that the signup renders without errors
    assert_no_difference 'User.count' do
      post users_path, params: { user: @invalid_user }
    end
    assert_template 'users/new'
    assert_select 'form[action="/signup"]'
  end

  test "should show error messages" do
    post users_path, params: { user: @invalid_user }
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: @valid_user }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
