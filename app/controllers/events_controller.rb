class EventsController < ApplicationController
  def search
    if params[:for] == 'training'
      @events = Event.for_topics(for_topics)
    else
      @events = Event.for_topics(for_topics)
                   .for_topics(time_topics)
                   .for_topics(education_topics)
    end
    pp @events.to_sql
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def for_topics
    Topic.where(name: params[:for])
  end

  def education_topics
    names = [:no_diploma]
    if params[:education] == 'in_hs'
      names << :in_highschool
    end
    if params[:education] == 'hs_graduate'
      names << :diploma
    end
    Topic.where(name: names)
  end

  def time_topics
    time = params[:time]
    times = []
    if ['part_time', 'both'].include? time
      times << :part_time
    end
    if ['full_time', 'both'].include? time
      times << :full_time
    end
    Topic.where(name: times)
  end
end
