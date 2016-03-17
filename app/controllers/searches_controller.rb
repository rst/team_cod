class SearchesController < ApplicationController

  before_action :authenticate_user!

  include TopicListHelper

  def show
    if current_user.topics.empty?
      set_up_topics
      render action: 'edit'
    else
      @events = current_user.events_of_interest.order("created_at DESC")
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
