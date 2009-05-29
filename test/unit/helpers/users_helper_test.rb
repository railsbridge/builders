require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class UsersHelperTest < ActionView::TestCase
  context '#safe_textilize' do
    should 'remove unauthorized html tags' do
      assert_dom_equal '<p>Hello World</p>', safe_textilize('Hello <bad_tag>World</bad_tag>')
    end

    should 'leave authorized html tags' do
      assert_dom_equal '<p>Hello <em>World</em></p>', safe_textilize('Hello <em>World</em>')
    end

    should 'handle textile' do
      assert_dom_equal '<p>Hello <strong>World</strong>', safe_textilize('Hello *World*')
    end
  end
end
