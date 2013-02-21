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


####### TODO: #######
#
# * 2 buttons :
#    * Login : email + passwd
#       * When logged, check if access_token is the same
#       * If same, ok, if not -> update User
#    * Sigin :
#       * Accept application
#       * Get access_token
#       * Get name + email from Github server-side, store them in session
#       * Check if the user doesn't exist yet
#           * If exists :
#               * Get User, FlashMessage 'you already exist' and log him
#           * If doesn't exist :
#               * Show a from : this is your name, your email, give me a passwd and I'll create your User
#               * Create User with name, email, passwd and access_token and log him