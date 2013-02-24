define ['jquery', 'backbone', 'models/Commit', 'views/CommitView'], ($, Backbone, Commit, CommitView) ->

  MainView = Backbone.View.extend

    tagName: 'div'
    className: 'jumbotron'
    $results: $('.results')
    lastCommit: null
    apiUrl: 'https://api.github.com/'
    userToken: $('#require-js').data('params').user.token
    ciPerPage: 100

    events:
      'submit form': 'stalk'

    initialize: ->
      @$el = $(@tagName).find '.' + @className

    stalk: (e) ->
      e.preventDefault()

      form  = $ e.currentTarget
      owner = form.find('input[name=owner]').val()
      repo  = form.find('input[name=repo]').val()
      url   = 'repos/' + owner + '/' + repo + '/commits'

      apiCall = @apiCall(url, 'get', 'jsonp',
        access_token: @userToken
        per_page: this.ciPerPage
      ).done (data) =>
        @$results.html ''
        @showResults data.data, url, no

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
      $('.results').append ciStr

      # Check if they were the last commits
      if dataLen > 1
        @lastCommit = data[dataLen - 1].sha
        params =
          access_token: @userToken
          per_page: @ciPerPage,
          sha: data[dataLen - 1].sha # Last commit displayed

        call = @apiCall(url, 'get', 'jsonp', params)
                  .done (data) =>
                    commits = data.data
                    commitsLength = commits.length
                    if commitsLength > 1 or (commitsLength is 1 && commits[commitsLength - 1].sha isnt @lastCommit)
                      @showResults(commits, url, yes)

    apiCall: (url, method, dataType, data) ->
      $.ajax
        url:      @apiUrl + url
        type:     method
        dataType: dataType
        data:     data

  MainView