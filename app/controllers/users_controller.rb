class UsersController < ApplicationController
  def new
    if User.find_by_login(session[:github_user][:login]).nil?
      @user = User.new session[:github_user]
    else
      redirect_to root_path, flash: {warning: 'You have already an account, please login'}
    end
  end

  def create
    @user = User.new session[:github_user]
    @user.password = params[:user][:password]
    if @user.valid? and @user.save
      self.current_user = @user
      session[:github_user] = nil # session value not necessary anymore
      redirect_to root_path, flash: {success: 'Welcome ' + current_user.login}
    else
      render action: :new
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

  def destroy_confirm
  end
end