class SessionsController < ApplicationController
  def callback
    if !request['code'].nil?
      code = request['code']
      require 'net/http'
      require 'uri'

      uri = URI.parse("https://github.com/login/oauth/access_token")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(
                              :client_id     => ENV['GITHUB_APP_ID_DEV'],
                              :client_secret => ENV['GITHUB_APP_SECRET_DEV'],
                              :code          => code
                            )

      response = http.request(request)

      token = response.body.split('&').first.split('=')
      token = { token[0] => token[1]  }
      session[:user_token] = token['access_token']
      redirect_to root_path
    end
  end
end

#access_token=792ca82e2b4f1de431e6f04ee509f15f0f7b6dd2&token_type=bearer