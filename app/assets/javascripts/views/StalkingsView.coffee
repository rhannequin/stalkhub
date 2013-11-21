define [
  'jquery',
  'lodash',
  'backbone',
  'Github',
  'views/StalkingListView',
  'models/Stalking',
  'views/CommitListView',
  'models/Commit'
], ($, _, Backbone, Github, StalkingListView, Stalking, CommitListView, Commit) ->

  StalkingsView = Backbone.View.extend

    el: '.stalkings'
    $results: $('.results')

    events:
      'click .stalk': 'stalk'

    initialize: ->
      @$stalingList = @$el.find('.stalkink-list')
      @stalkingListView = new StalkingListView()
      @stalkingListView.commitListView = new CommitListView()
      @getStalkings().done (stalkings) =>
        @renderStalkings stalkings

    getStalkings: ->
      $.ajax
        url: '/stalkings'
        dataType: 'json'

    renderStalkings: (stalkings) ->
      @stalkingListView.collection.add stalkings
      @$stalingList.prepend @stalkingListView.render()

    stalk: (e) ->
      @stalkingListView.commitListView.collection.reset()
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
      commitListView = @stalkingListView.commitListView
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
        commitListView.collection.add commit

      # Render commits
      @$results.find('.commits').html commitListView.render()

  new StalkingsView()