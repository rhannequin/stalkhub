# Stalkhub

## Requirements

- Ruby 1.9.3 (my RPM version is 4.9.1.1)
- Ruby On Rails 3.2.11
- SQLite3

## Installation

    git clone git@github.com:RemyHannequin/stalkhub.git
    cd stalkhub
    bundle install
    rake db:migrate

## Configuration

You must create your own Github application to use the application. You can create one in your [settings page](https://github.com/settings/applications). You'll notice you have now a client_id and client_secret available.

The app config file is saved in `/app/application.yml` which is not versionned and must be written like so:

    ROOT_URL_DEV: "http://localhost:5000/"
    ROOT_URL:     "http://localhost:5000/"

    # Github config
    GITHUB_APP_ID_DEV:       "YOUR GITHUB APPLICATION CLIENT_ID"
    GITHUB_APP_ID:           "YOUR GITHUB APPLICATION CLIENT_ID"
    GITHUB_APP_SECRET_DEV:   "YOUR GITHUB APPLICATION CLIENT_SECRET"
    GITHUB_APP_SECRET:       "YOUR GITHUB APPLICATION CLIENT_SECRET"
    GITHUB_CALLBACK_URI_DEV: "http://localhost:5000/auth/callback"
    GITHUB_CALLBACK_URI:     "http://localhost:5000/auth/callback"
    SECRET_HASH:             "WHAT-YOU-WANT"

*Notice: If you're not planning to push the application in production, don't need to set `ROOT_URL`, `GITHUB_APP_ID`, `GITHUB_APP_SECRET` and `GITHUB_CALLBACK_URI` environment variables.*

## Launch!

You can use the Rails command `rails server -p 5000` or the Procfile file with `foreman start`.

## Contribute

You can [fork](https://github.com/RemyHannequin/stalkhub/fork) and submit pull-requests.

Feel free to submit [issues](https://github.com/RemyHannequin/stalkhub/issues) if you notice a bug or think of a new feature. Please check the [changelog file](https://github.com/RemyHannequin/stalkhub/blob/master/changelog.md) to see the project history.

## License

MIT, see [LICENSE file](https://github.com/RemyHannequin/stalkhub/blob/master/LICENSE).