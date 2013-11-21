class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user
  before_filter :require_js

  def home
    @require_js[:script] = 'views/MainView'
  end

  def about
  end

  protected

    def define_current_user_by_user(usr)
      session[:user_id] = usr.id
      @current_user = usr
    end

    def define_current_user_by_id(user_id)
      session[:user_id] = user_id
      @current_user = User.find_by_id user_id
    end

    def current_user
      return @current_user if @current_user
      unless session[:user_id].nil?
        define_current_user_by_id session[:user_id]
        init_github_client
        return @current_user
      end
      destroy_current_user
    end
    helper_method :current_user

    def destroy_current_user
      @current_user = session[:user_id] = nil
    end

    def is_logged?
      redirect_to root_path, flash: { error: 'You must be logged to enjoy this application.' } if current_user.nil?
    end

    def require_js
      @require_js = { :script => {}, :params => { :user => current_user } }
    end

    def init_github_client
      # Add Octokit to current_user
      @current_user.gh = Octokit::Client.new access_token: @current_user.token
    end

end