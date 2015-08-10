require 'test_helper'

class TopicListHelperTest < ActionView::TestCase

  def test_topic_list_item_name_escapes
    it = topic_list_item_with_checkbox(Topic.new(name: "stop&shop"), false)
    assert_match /stop&amp;shop/, it
  end

  def test_unchecked_topic_list_item
    it = topic_list_item_with_checkbox(topics(:retail), false)
    assert_match /Retail/, it
    assert_match /topic-#{topics(:retail).id}/, it
    assert_no_match /checked/, it
  end

  def test_checked_topic_list_item
    it = topic_list_item_with_checkbox(topics(:programming), true)
    assert_match /Programming/, it
    assert_match /topic-#{topics(:programming).id}/, it
    assert_match /checked/, it
  end

  def test_topic_list_from_checkboxes
    params = {}
    assert_equal [], topic_list_from_checkboxes(params)

    params["topic-#{topics(:retail).id}"] = '1'
    assert_equal [topics(:retail)], topic_list_from_checkboxes(params)

    params["topic-#{topics(:programming).id}"] = '1'
    assert_equal [topics(:retail), topics(:programming)],
                 topic_list_from_checkboxes(params)

  end

end
