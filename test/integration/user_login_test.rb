require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jane)
  end

  test "check login flow with invalid inuputs" do
    get login_path
    assert_template 'sessions/new'
    post login_path , params: {session:{ email: "", password:""}}
    refute is_logged_in?
    assert_template 'sessions/new'
    refute flash.empty?
    get root_path
    assert flash.empty?
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", logout_path, count: 0

  end

  test "check login flow with valid inputs" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session:{email: @user.email, password: "Password#1"}}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    assert_select "a[href=?]", login_path , count: 0
    assert_select "a[href=?]", user_path
    assert_select "a[href=?]", logout_path
    delete logout_path
    refute is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    delete logout_path
    follow_redirect!
    assert_template root_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end


  test "check the flow with remember me" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "check the flow with out remember me" do
    log_in_as(@user, remember_me: '1')
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end




end
