require 'test_helper'

class WelcomepageFlowTest < ActionDispatch::IntegrationTest

  test "page flow test" do
    get root_path
    assert_template 'welcome/index'
    assert_select "a[href=?]",signup_path
  end

end
