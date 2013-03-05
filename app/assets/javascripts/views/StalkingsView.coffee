define [
  'jquery',
  'lodash',
  'backbone',
  'Github',
  'views/CommitListView',
  'models/Commit'
], ($, _, Backbone, Github, CommitListView, Commit) ->

  StalkingsView = Backbone.View.extend

    el: '.stalkings'
    $results: $('.results')

    events:
      'click .stalk': 'stalk'

    initialize: ->
      @commitListView = new CommitListView()

    stalk: (e) ->
      self = @
      @commitListView.collection.reset()
      target = $(e.currentTarget).parent()
      loader = target.find('.loading').show()
      repoBig = target.find('.repo').text()
      data = repoBig.split('/')
      repo = data[1]

      Github.getCommits data[0], repo, {}, (res) =>
        @$results.find('h2').html repo
        loader.hide()
        @showResults res, no

    showResults: (data, recursive) ->
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
      @$results.find('.commits').html @commitListView.render()

  new StalkingsView()