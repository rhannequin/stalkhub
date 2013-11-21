# Stalkhub

Stalhub is an application based on the [Github API](http://developer.github.com/v3) which aim is to follow push activity about Github repositories.

You can check it, use it, enjoy it right now: [Stalkhub](http://stalkhub.herokuapp.com). See more information on the [about page](http://stalkhub.herokuapp.com/about).


## Requirements

All you need is `ruby 2.0.0` installed. All gems are defined in the Gemfile.
You only have to run `bundle install`.


## Installation

    git clone git@github.com:rhannequin/stalkhub.git
    cd stalkhub
    bundle install
    rake db:migrate


## Configuration

You must create your own Github application to use the application. You can create one in your [settings page](https://github.com/settings/applications). You'll notice you have now a client_id and client_secret available.

The app config file is saved in `/app/application.yml` which is not versionned. You have to create one with the variables contained in the [application.example.yml](https://github.com/rhannequin/stalkhub/blob/master/config/application.example.yml) file.


*Notice: If you're not planning to push the application in production, don't need to edit the following environment variables:*

* `DB_ADAPTER_PROD`
* `DB_DATABASE_PROD`
* `DB_ENCODING_PROD`
* `DB_HOST_PROD`
* `DB_PASSWORD_PROD`
* `DB_PORT_PROD`
* `GITHUB_APP_ID`
* `GITHUB_APP_SECRET`
* `GITHUB_CALLBACK_URI`
* `ROOT_URL`


## Launch!

You can use the Rails command `rails server -p 5000` or the Procfile file with `foreman start`.


## Testing

    bundle install
    rake db:create:all
    rake db:migrate RAILS_ENV=test
    rspec spec


## Contribute

You can [fork](https://github.com/rhannequin/stalkhub/fork) and submit pull-requests.

Feel free to submit [issues](https://github.com/rhannequin/stalkhub/issues) if you notice a bug or think of a new feature. Please check the [changelog file](https://github.com/rhannequin/stalkhub/blob/master/changelog.md) to see the project history.


## License

MIT, see [LICENSE file](https://github.com/rhannequin/stalkhub/blob/master/LICENSE).
