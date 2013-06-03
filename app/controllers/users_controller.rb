class UsersController < ApplicationController
  before_filter :is_logged?, :only => :show

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(current_user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

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
    @user.encrypt_password
    if @user.valid? and @user.save
      self.current_user = @user
      session[:github_user] = nil # session value not necessary anymore
      redirect_to root_path, flash: {success: 'Welcome ' + current_user.login}
    else
      render action: :new
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if !params[:user][:password].empty? # We want to update password
      if params[:user][:password] == params[:password][:confirm]
        @user.password = params[:user][:password]
        @user.encrypt_password
        @user.save
      else
        return redirect_to settings_path, flash: { error: 'The passwords are not the same.' }
      end
    end

    @user.login = params[:user][:login] unless params[:user][:login].nil?
    respond_to do |format|
      if @user.save
        format.html { redirect_to settings_path, flash: { success: 'User was successfully updated.' } }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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