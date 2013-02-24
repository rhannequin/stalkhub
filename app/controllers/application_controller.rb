class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user

  def home
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

end