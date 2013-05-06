define [
  'jquery',
  'lodash',
  'backbone',
  'Github',
  'views/CommitListView',
  'models/Commit',
  'handlebars'
], ($, _, Backbone, Github, CommitListView, Commit) ->

  MainView = Backbone.View.extend

    tagName: 'div'
    className: 'jumbotron'
    $results: $('.results')
    lastCommit: null

    events:
      'submit form': 'stalk'

    initialize: ->
      @$el = $(@tagName).find '.' + @className
      @commitListView = new CommitListView()

    stalk: (e) ->
      e.preventDefault()

      @commitListView.collection.reset()
      form  = $ e.currentTarget
      owner = form.find('input[name=owner]').val()
      repo  = form.find('input[name=repo]').val()
      url   = 'repos/' + owner + '/' + repo + '/commits'

      Github.getCommits owner, repo, {}, (res) =>
        @showResults res, no

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
        @commitListView.collection.add commit

      # Render commits
      @$results.append @commitListView.render()

  new MainView()