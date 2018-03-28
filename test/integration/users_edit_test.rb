require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jane)
    @user1 = users(:john)
  end
  test "invalid user edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  " "}}
    assert_template 'users/edit'
  end

  test "valid user edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "example"
    email = "example3@bar.com"
    patch user_path(@user), params: { user: { first_name:  name,
                                              email: email }}
    refute flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal  @user.first_name, name
    assert_equal email, @user.email
  end

  test "invalid edit" do
    log_in_as(@user)
    get edit_user_path(@user1)
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'welcome/index'
    log_in_as(@user)
  end

  test "edit without logging in" do
    get edit_user_path(@user)
   assert_redirected_to login_path
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    follow_redirect!
    assert_template 'users/edit'
    name  = "example"
    email = "example3@bar.com"
    patch user_path(@user), params: { user: { first_name:  name,
                                              email: email }}
    refute flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal  @user.first_name, name
    assert_equal email, @user.email
  end
end
