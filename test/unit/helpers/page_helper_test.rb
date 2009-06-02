require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class PageHelperTest < ActionView::TestCase

  context '#link_to_static' do
    should 'build a valid link with default text' do
      assert_dom_equal '<a href="/site/about">about</a>', link_to_static(:about)
    end

    should 'build a valid link with custom text' do
      assert_dom_equal '<a href="/site/about">about builders</a>', link_to_static(:about, 'about builders')
    end
  end
end
