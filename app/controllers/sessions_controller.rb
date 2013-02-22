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