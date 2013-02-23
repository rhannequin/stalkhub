class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user

  def home
  end

  private
    def current_user
      return @current_user if @current_user
      @current_user = User.current_user
    end
    helper_method :current_user

end