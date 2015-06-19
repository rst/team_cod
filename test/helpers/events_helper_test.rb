require 'test_helper'

class EventsHelperTest < ActionView::TestCase

  include EventsHelper

  def test_by_paragraphs
    assert_equal ["  foo\nbar", "moo\nzot", "sesquipedalian\n  bear\n"],
     by_paragraphs("  foo\nbar\n\nmoo\nzot\n  \t  \nsesquipedalian\n  bear\n")
  end
  
end
