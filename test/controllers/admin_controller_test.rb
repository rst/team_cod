require 'test_helper'

class AdminsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    sign_in users(:lucy)
    @admin = users(:lucy)
    @dude = User.create! email: 'somedude@dude.com', password: 'somedude!'
  end

  def test_show
    get :show
    assert_response :success
    assert_equal User.order(:email).to_a, assigns(:users).to_a

    promote_url = admin_path(user_id: @dude.id, admin: true)
    assert_select "a[href=?]", promote_url

    demote_url = admin_path(user_id: @admin.id, admin: false)
    assert_select "a[href=?]", demote_url
  end

  def test_update
    post :update, user_id: @dude.id, admin: 'true'
    assert_redirected_to admin_path
    assert @dude.reload.admin

    post :update, user_id: @dude.id, admin: 'false'
    assert_redirected_to admin_path
    assert !@dude.reload.admin
  end

  def test_non_admin_access
    sign_in(@dude)
    get :show
    assert_redirected_to root_path
  end

end
