require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	include ApplicationHelper

	test "full title helper" do
		assert_equal full_title, "開発村通信"
		assert_equal full_title("Hoge"), "Hoge | 開発村通信"
	end
end