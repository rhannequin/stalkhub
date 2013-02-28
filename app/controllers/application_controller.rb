class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user
  before_filter :require_js

  def home
    @require_js[:script] = 'views/MainView'
  end

  private
    def current_user=(usr)
      session[:user] = usr
    end

    def current_user
      return @current_user if @current_user
      return @current_user = session[:user] unless session[:user].nil?
      @current_user = session[:user] = nil
    end
    helper_method :current_user

    def is_logged?
      redirect_to root_path, flash: { error: 'You must be logged to enjoy this application.' } if current_user.nil?
    end

    def require_js
      @require_js = { :script => {}, :params => { :user => current_user } }
    end

end