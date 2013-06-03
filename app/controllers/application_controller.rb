class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user
  before_filter :require_js

  def home
    puts current_user.gh.inspect if not current_user.nil?
    @require_js[:script] = 'views/MainView'
  end

  def about
  end

  private
    def current_user=(usr)
      session[:user] = usr
    end

    def current_user
      return @current_user if @current_user
      unless session[:user].nil?
        @current_user = session[:user]
        init_github_client
        return @current_user
      end
      @current_user = session[:user] = nil
    end
    helper_method :current_user

    def is_logged?
      redirect_to root_path, flash: { error: 'You must be logged to enjoy this application.' } if current_user.nil?
    end

    def require_js
      @require_js = { :script => {}, :params => { :user => current_user } }
    end

    def init_github_client
      # Add Octokit to current_user
      @current_user.gh = Octokit::Client.new(:login => @current_user.login, :password => @current_user.token)
    end

end