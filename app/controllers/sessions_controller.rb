class SessionsController < ApplicationController
  def callback
    if !request['code'].nil?
      code = request['code']
      params =  { :client_id     => ENV['GITHUB_APP_ID_DEV'],
                  :client_secret => ENV['GITHUB_APP_SECRET_DEV'],
                  :code          => code }

      response = http.request(uri, 'post', params, true)

      token = response.body.split('&').first.split('=')
      # token = { token[0] => token[1] }
      # session[:user_token] = token['access_token']
      user = get_user_info token[1]
      # session[:github_user] = { :access_token => token[1], :name => user['name'], :email => user['email'] } # Maybe user.parse ?
      redirect_to users_new_path
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
        request = Net::HTTP::GET.new(uri.request_uri)
      end

      http.request(request)
    end

    def get_user_info(access_token)
      uri = 'https://api.github.com/user'
      http.request(uri, 'get', { :access_token => access_token }, true)
    end
end