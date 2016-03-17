require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    sign_in users(:lucy)
    @admin = users(:lucy)
    @dude = User.create! email: 'somedude@dude.com', password: 'somedude!'
  end

  def test_show_no_profile
    get :show
    assert_response :success
    assert_template 'edit'
  end

  def test_show_with_profile
    users(:lucy).topics = [topics(:programming)]
    events(:cyber_jamboree).topics = [topics(:programming)]
    get :show
    assert_response :success
    assert_template 'show'
    assert assigns(:events).include?(events(:cyber_jamboree))
  end

  def test_edit
    get :edit
    assert_response :success
    assert_template 'edit'
  end

  def test_update
    post :update, "topic-#{topics(:retail).id}" => 1
    assert_redirected_to search_path
    users(:lucy).topics(:reload)
    assert_equal [topics(:retail)], users(:lucy).topics.to_a

    post :update, "topic-#{topics(:retail).id}" => 1,
                  "topic-#{topics(:programming).id}" => 1
    assert_redirected_to search_path
    users(:lucy).topics(:reload)
    assert_equal [topics(:programming), topics(:retail)], 
                 users(:lucy).topics.to_a.sort_by(&:name)
  end

end
