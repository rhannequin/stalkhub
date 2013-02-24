class SessionsController < ApplicationController
  def callback
    if !request['code'].nil?
      require 'json'
      code = request['code']
      params =  { :client_id     => ENV['GITHUB_APP_ID_DEV'],
                  :client_secret => ENV['GITHUB_APP_SECRET_DEV'],
                  :code          => code }

      response = make_request 'https://github.com/login/oauth/access_token', 'post', params, true

      token = response.body.split('&').first.split('=')
      user = JSON.parse get_user_info(token[1]).body
      session[:github_user] = { :token      => token[1],
                                :login      => user['login'],
                                :avatar_url => user['avatar_url'] }
      redirect_to new_users_path
    end
  end

  def login
    user = User.authenticate request.params[:login], request.params[:password]
    session[:check_token] = { :id => user.id } if !user.nil?
    if !request.params[:code].nil? and !session[:check_token].nil? # Get access_token and update User
      params =  { :client_id     => ENV['GITHUB_APP_ID_DEV'],
                  :client_secret => ENV['GITHUB_APP_SECRET_DEV'],
                  :code          => request.params[:code] }

      response = make_request 'https://github.com/login/oauth/access_token', 'post', params, true
      token = response.body.split('&').first.split('=')
      @user = User.find(session[:check_token][:id])
      @user.token = token[1]
      @user.save
      User.current_user = @user
      session[:check_token] = nil # session value not necessary anymore
      redirect_to root_path, flash: { success: 'Welcome back %{username}!' % { :username => current_user.login } }
    elsif session[:check_token].nil? # Wrong User login
      redirect_to root_path, flash: { error: "Sorry we couldn't log you" }
    else # User is ok, get oauth.authorize's code to ask access_token
      redirect_to '%{github_auth_url}?client_id=%{client_id}&scope=%{scope}&redirect_uri=%{redirect_uri}' % {
        :github_auth_url => 'https://github.com/login/oauth/authorize',
        :client_id       => (Rails.env.production? ? ENV['GITHUB_APP_ID'] : ENV['GITHUB_APP_ID_DEV']).to_s,
        :scope           => 'user:email,user:follow,public_repo',
        :redirect_uri    => ((Rails.env.production? ? ENV['ROOT_URL'] : ENV['ROOT_URL_DEV']) + 'login').to_s
      }
    end
  end


  private

    def make_request(url, method, data = {}, ssl = false)
      require 'net/http'
      require 'uri'

      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = ssl

      if method == 'post'
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data data
      else
        request = Net::HTTP::Get.new(uri.request_uri)
      end

      http.request(request)
    end

    def get_user_info(access_token)
      url = 'https://api.github.com/user?access_token=' + access_token
      make_request url, 'get', {}, true
    end
end