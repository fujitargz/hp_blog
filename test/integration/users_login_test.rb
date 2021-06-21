require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "login with valid name/invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {name: " ", password: @user.password } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get login_path
    assert flash.empty?
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '1')
    delete logout_path
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
