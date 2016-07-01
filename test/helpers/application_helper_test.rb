require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    title = "Ruby on Rails Tutorial Sample App"
    assert_equal full_title, title
    ["Help", "Contact", "About", "Sign up"].each { |label| assert_equal full_title(label),
                                        "#{label} | #{title}"}
    end
end
