module TopicListHelper

  def topic_param_name(topic)
    "topic-#{topic.id.to_i}"
  end

  def topic_list_item_with_checkbox(topic, checked)
    content_tag 'div', class: 'checkbox' do
      check_box_tag("topic-#{topic.id.to_i}", "1", checked) + topic.name
    end
  end

  def topic_list_from_checkboxes(params = self.params)
    topic_param_keys = params.keys.grep /\Atopic-[0-9]+/
    topic_id_strings = topic_param_keys.map{|x| x.gsub(/^topic-/,'')}
    topic_id_strings.collect{ |str| Topic.find(str.to_i) }
  end

end
