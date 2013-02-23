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
      User.current_user = @user
      redirect_to root_path, flash: {success: 'Welcome ' + current_user.login}
    else
      render action: :new
    end
  end
end