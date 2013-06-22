class UsersController < ApplicationController
  before_filter :is_logged?

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(current_user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def destroy
    user = User.find(current_user.id)
    if user.destroy
      self.current_user = nil
      redirect_to root_path, flash: {success: 'Your account has been successfully deleted. You still can create a new account ;)'}
    else
      redirect_to root_path, flash: {error: 'Impossible to delete your account, please contact us for further information.'}
    end
  end
end