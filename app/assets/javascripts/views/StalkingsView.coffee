define [
  'jquery',
  'lodash',
  'backbone',
  'models/Commit',
  'views/CommitView'
], ($, _, Backbone, Commit, CommitView) ->

  StalkingsView = Backbone.View.extend

    el: '.stalkings'
    $results: $('.results')
    apiUrl: 'https://api.github.com/'
    userToken: $('#require-js').data('params').user.token
    ciPerPage: 20

    events:
      'click .stalk': 'stalk'

    initialize: ->

    stalk: (e) ->
      self = @
      target = $(e.currentTarget).parent()
      repoBig = target.find('.repo').text()
      data = repoBig.split('/')
      url = 'repos/' + data[0] + '/' + data[1] + '/commits'

      apiCall = @apiCall(url, 'get', 'jsonp',
        access_token: @userToken
        per_page: this.ciPerPage
      ).done (res) =>
        @$results.find('h2').html data[1]
        @showResults res.data, url, no

    showResults: (data, url, recursive) ->
      self    = @
      ciStr   = ''
      dataLen = data.length

      # Create all <li>s to display
      for obj in data
        ci = obj.commit
        params =
          date: new Date ci.committer.date
          message: ci.message
        if obj.committer?
          author = author: obj.committer.login, isLoggedProfile: yes
        else author = author: obj.commit.author.name
        commit = new Commit _.extend(params, author)
        commitView = new CommitView()
        commitView.model = commit
        ciStr += commitView.render()

      # Render commits
      @$results.find('.commits').html ciStr

    apiCall: (url, method, dataType, data) ->
      $.ajax
        url:      @apiUrl + url
        type:     method
        dataType: dataType
        data:     data

  new StalkingsView()