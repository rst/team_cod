class EventsController < ApplicationController
  def search
    topic_params = params.keys.grep /\Atopic-[0-9]+\z/
    topic_id_strings = topic_params.collect{ |s| s.gsub(/^topic-/, '') }

    @topics = topic_id_strings.collect{|s| Topic.find s.to_i }
    @events = Event.for_topics(@topics)
  end
end
