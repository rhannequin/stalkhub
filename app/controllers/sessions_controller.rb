class SessionsController < ApplicationController

  def new
    redirect_to '/auth/github'
  end

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.authenticate auth_hash
    self.current_user = user
    redirect_to root_path, flash: { success: "Welcome #{current_user.username}!" }
  end

  def failure
    # TODO: fix callback error on deny
    render :text => "Sorry, but you didn't allow access to our app!"
  end

  def logout
    self.current_user = nil
    redirect_to root_path, flash: { warning: 'You are not logged anymore, please login to use the application.' }
  end
end