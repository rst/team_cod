class SearchesController < ApplicationController

  before_action :authenticate_user!

  include TopicListHelper

  def show
    if current_user.topics.empty?
      set_up_topics
      render action: 'edit'
    else
      @events = 
        current_user.events_of_interest
                    .includes(:topics)
                    .where(["events.created_at > ?", 7.days.ago])
                    .distinct
                    .order("created_at DESC")
      @events_by_date = @events.group_by { |ev| ev.created_at.beginning_of_day }
      @events_by_date_and_topic = {}
      @events_by_date.each do |date, events|
        topics = events.inject([]){ |a, ev| a + ev.topics }
        evs_grouped = {}
        topics.sort_by(&:name).each do |topic|
          evs_grouped[topic] = events.select { |ev| ev.topics.include?(topic) }
        end
        @events_by_date_and_topic[date] = evs_grouped
      end
    end
  end

  def edit
    set_up_topics
  end

  def update
    current_user.topics = topic_list_from_checkboxes
    redirect_to search_path
  end

  private

  def set_up_topics
    topic_groups_hash = Topic.all.group_by &:topic_group
    @topic_groups = topic_groups_hash.to_a.sort{ |a,b| b.first <=> a.first }
    @selected_topics = current_user.topics
  end

end
