Rails.application.config.middleware.use OmniAuth::Builder do
  # TODO: make `scope: "user:follow,public_repo"` work
  production = Rails.env.production?
  provider  :github,
            (production ? ENV['GITHUB_APP_ID']     : ENV['GITHUB_APP_ID_DEV']),
            (production ? ENV['GITHUB_APP_SECRET'] : ENV['GITHUB_APP_SECRET_DEV'])
end