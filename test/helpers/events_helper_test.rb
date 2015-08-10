require 'test_helper'

class EventsHelperTest < ActionView::TestCase

  include EventsHelper

  def test_by_paragraphs
    assert_equal ["  foo\nbar", "moo\nzot", "sesquipedalian\n  bear\n"],
     by_paragraphs("  foo\nbar\n\nmoo\nzot\n  \t  \nsesquipedalian\n  bear\n")
  end
  
  def test_event_map_link
    ev = Event.new address: "44 Main St."
    assert_match /44\+Main\+St\./, event_map_link(ev)
  end

end
