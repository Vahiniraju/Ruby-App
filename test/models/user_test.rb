require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "Jane", last_name: 'Doe', email: "user2@example.com", username: "janedoe1", password: "Password#1", password_confirmation: "Password#1")
  end

  test "should be valid" do
    assert @user.valid?
  end

  [:first_name, :last_name].each do |attr|

    test "#{attr.to_s} should not be blank" do
      @user[attr] = " "
      refute @user.valid?
    end

    test "#{attr.to_s} should not start with space" do
      @user[attr] = " Jane"
      refute @user.valid?
    end

  end

  test "email should be present" do
    @user.email = ""
    refute @user.valid?
  end

  test "email should not contain space" do
    @user.email = "user1@ example.com"
    refute @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 255 + "@gmail.com"
    refute @user.valid?
  end

  test "email should be unique for users" do
    duplicate_user = @user.dup
    @user.save
    refute duplicate_user.valid?
  end

  test "email should be case sensitive" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    duplicate_user.username = @user.username.upcase
    @user.save
    refute duplicate_user.valid?
  end
  
  test "username should not be blank" do
    @user.username = ""
    refute @user.valid?
  end

  test "username should not be more than 30 characters in length" do
    @user.username = 'a' * 31
    refute @user.valid?
  end

  test "username should not contain space" do
    @user.username = " Jane"
    refute @user.valid?
    @user.username = "Jane doe"
    refute @user.valid?
  end

  test "username must be unique" do
    @dup_user = @user.dup
    @dup_user.email = "xyz@gmail.com"
    @user.save
    refute @dup_user.valid?
  end

  test "username should be not case-sensitive" do
    @another_user = @user.dup
    @another_user.email = "xyz@gmail.com"
    @another_user.username = @another_user.username.upcase
    @user.save
    refute @another_user.valid?
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = "   "
    @user.save
    refute @user.valid?
  end

  test "password should contain minimum of 7 characters" do
    @user.password = @user.password_confirmation = "xyz"
    refute @user.valid?
  end

  test "password should not contain space" do
    @user.password = @user.password_confirmation = " x ydsfdff$@"
    refute @user.valid?

  end

end
