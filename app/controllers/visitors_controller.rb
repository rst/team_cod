class VisitorsController < ApplicationController
  def index
    page = current_page
    if page.nil?
      return redirect_to search_events_url(params)
    end
    @title, elements = page
    @elements = elements.map { |e| url_for(e) }
    render
  end

  private

  def url_for(element)
    new_params = {}
    new_params[element[:key]] = element[:value]
    new_params.merge! params
    {
      url: root_url(new_params),
      text: element[:text]
    }
  end

  def current_page
    if params[:for] == "training"
      nil
    elsif params[:for].nil?
      ["This app can help you find jobs and events to help with your search.
        <br/><br/>Are you looking...",
       [for_job, for_training]]
    elsif params[:education].nil?
      ["Are you...", [hs_graduate, in_hs, no_diploma]]
    elsif params[:time].nil?
      ["What is your availability?", [part_time, full_time, both_times]]
    else
      nil # need to search
    end
  end

  def for_job
    {
      key: :for,
      value: :job,
      text: '...for a job?'
    }
  end

  def for_training
    {
      key: :for,
      value: :training,
      text: '...to build your skills?'
    }
  end

  def hs_graduate
    {
      key: :education,
      value: :hs_graduate,
      text: 'A High School Graduate / GED'
    }
  end

  def in_hs
    {
      key: :education,
      value: :in_hs,
      text: 'In High School'
    }
  end

  def no_diploma
    {
      key: :education,
      value: :no_diploma,
      text: 'No Diploma'
    }
  end

  def part_time
    {
      key: :time,
      value: :part_time,
      text: "Part-time"
    }
  end

  def full_time
    {
      key: :time,
      value: :full_time,
      text: "Full-time"
    }
  end

  def both_times
    {
      key: :time,
      value: :both,
      text: "Both"
    }
  end
end
