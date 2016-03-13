class AdminsController < ApplicationController

  before_filter :authenticate_admin!

  def show
    @users = User.order(:email)
  end

  def update
    user = User.find_by(id: params[:user_id].to_i)
    user.update_attributes! admin: params[:admin]
    redirect_to admin_path
  end

end
