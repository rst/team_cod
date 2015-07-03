require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  include TopicListHelper
  include Devise::TestHelpers

  setup do
    sign_in users(:lucy)
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'index'
    assert_equal Event.where_current.to_a, assigns(:events).to_a
    assert_select "h1#current_header"
  end

  def test_expired
    get :expired
    assert_response :success
    assert_template 'index'
    assert_equal Event.where_expired.to_a, assigns(:events).to_a
    assert_select "h1#expired_header"
  end

  def test_show
    get :show, id: events(:cyber_jamboree).id.to_s
    assert_response :success
    assert_template 'show'
    assert_equal events(:cyber_jamboree), assigns(:event)
    assert_select 'div.edit_navigation_links'
  end

  def test_show_signed_out
    sign_out users(:lucy)       # When user is signed out...
    get :show, id: events(:cyber_jamboree).id.to_s
    assert_response :success
    assert_template 'show'
    assert_select 'div.edit_navigation_links', false # ... these don't show up.
  end

  def test_show_url_display
    ev = events(:cyber_jamboree)

    get :show, id: ev.id.to_s
    assert_response :success
    assert_select '.apply-btn', false
    assert_select '.info-btn', false

    ev.update_attributes! url: 'http://cyber-jamboree.org'
    get :show, id: ev.id.to_s
    assert_response :success
    assert_select '.apply-btn', false
    assert_select '.info-btn', true

    ev.topics << Topic.create!(name: 'job')
    get :show, id: ev.id.to_s
    assert_response :success
    assert_select '.apply-btn', true
    assert_select '.info-btn', false
  end

  def test_new
    get :new
    assert_response :success
    assert_template 'new'
    assert_equal [], assigns(:selected_topics)
  end

  def test_edit

    ev = events(:cyber_jamboree)
    ev.topics << topics(:programming)

    get :edit, id: ev.id.to_s
    assert_response :success
    assert_template 'edit'
    assert_equal ev, assigns(:event)
    assert_equal [topics(:programming)], assigns(:selected_topics)

  end

  def test_event_create_good

    ev_params = {
      name: 'Blue Room', 
      address: 'One Kendall Sq., Cambridge',
      description: 'Waitstaff'}

    post :create, event: ev_params, topic_param_name(topics(:retail)) => '1'

    ev = Event.where(name: 'Blue Room').first
    assert_not_nil ev
    assert_redirected_to event_path(ev)
    
    ev = Event.where(name: 'Blue Room').first
    assert_equal ev_params[:address], ev.address
    assert_equal ev_params[:description], ev.description
    assert_equal [topics(:retail)], ev.topics

  end

  def test_event_create_bad

    pre_count = Event.count

    ev_params = {
      name: '',                 # blank, invalid
      address: 'One Kendall Square, Cambridge',
      description: 'Waitstaff'}

    post :create, event: ev_params, topic_param_name(topics(:retail)) => '1'

    assert_response :success
    assert_template 'new'
    assert_equal pre_count, Event.count
    assert_equal 'Waitstaff', assigns(:event).description
    assert_equal [topics(:retail)], assigns(:selected_topics)

  end


  def test_event_update_good

    new_desc = 'Code in Cambridddddgggge!'

    post :update, id: events(:cyber_jamboree).id.to_s,
         event: {description: new_desc}, 
         topic_param_name(topics(:programming)) => '1'

    assert_redirected_to event_path(events(:cyber_jamboree))
    assert_equal new_desc, events(:cyber_jamboree).reload.description
    assert_equal [topics(:programming)], events(:cyber_jamboree).topics.to_a

  end

  def test_event_update_bad

    new_desc = 'Code in Cambridddddgggge!'

    post :update, id: events(:cyber_jamboree).id.to_s,
         event: {name: '', description: new_desc}, 
         topic_param_name(topics(:programming)) => '1'

    assert_response :success
    assert_template 'edit'
    assert_equal new_desc, assigns(:event).description
    assert_equal [topics(:programming)], assigns(:selected_topics)

  end

end
