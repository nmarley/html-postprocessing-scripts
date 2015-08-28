require 'minitest/autorun'
require './sebastian'

class TestSebastian < Minitest::Test

  def setup
    @archive_html = File.read('data/128.html')
    @post_html = File.read('data/me-im-a-strategist.html')
  end

  def test_parse_archive_page
    results = Sebastian.parse_archive_page(@archive_html)

    assert_equal results.class, Array
    assert_equal results.size, 10

    assert_equal results.map(&:class).uniq, [Hash]

    results.each do |res|
      assert res.has_key?(:slug)
      assert res.has_key?(:posted_at)
      assert res.has_key?(:post_uid)

      assert res[:posted_at].respond_to?(:strftime)
    end
  end

end

