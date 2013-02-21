class ApplicationController < ActionController::Base
  protect_from_forgery

  def home
    @current_user = session[:user_token] if !session[:user_token].nil?
    ##### Todo: #####
    #
    # * Check if new user (@current_user.nil?) : token.exists?
    #
    # If new -> page to make a choice :
    #   * Get personnal information from Github
    #   * Create random profile with random information
    #
    # If not new -> @current_user = User.where :token = token
  end

end
