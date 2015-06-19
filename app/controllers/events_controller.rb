class EventsController < ApplicationController

  before_action :authenticate_user!, except: [:search, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  include TopicListHelper

  def search
    if params[:for] == 'training'
      @events = Event.for_topics(for_topics)
    else
      @events = Event.for_topics(for_topics)
                   .for_topics(time_topics)
                   .for_topics(education_topics)
    end
  end

  # GET /events
  # GET /events.json
  def index
    @events = Event.order("created_at desc")
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @selected_topics = []
  end

  # GET /events/1/edit
  def edit
    @selected_topics = @event.topics.to_a
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @selected_topics = topic_list_from_checkboxes

    respond_to do |format|
      if @event.save
        @event.topics = @selected_topics
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @selected_topics = topic_list_from_checkboxes

    respond_to do |format|
      if @event.update(event_params)
        @event.topics = @selected_topics
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.includes(:topics).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params[:event].permit(:name, :address, :description, :url)
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
