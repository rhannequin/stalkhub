define [
  'jquery',
  'lodash',
  'backbone',
  'handlebars',
  'Github'
], ($, _, Backbone, Handlebars, Github) ->

  Handlebars.registerHelper 'strToTime', (dateStr) ->
    date = new Date dateStr
    date.toDateString()

  Handlebars.registerHelper 'isset', (arr, key, fn) ->
    fn(this) if typeof arr[key] isnt 'undefined'

  Handlebars.registerHelper 'safeUsername', (commit) ->
    return commit.commit.author.name unless commit.author?
    '<a href="' + commit.author.html_url + '">@' + commit.author.login + '</a>'

  StalkingView = Backbone.View.extend

    config: JSON.parse document.getElementById('require-js').getAttribute('data-params')
    compiled: Handlebars.compile document.getElementById('stalking-template').innerHTML
    contributorsTemplate: Handlebars.compile document.getElementById('contributors-template').innerHTML
    commitsTemplate: Handlebars.compile document.getElementById('commits-template').innerHTML
    commitsLoopTemplate: Handlebars.compile document.getElementById('commits-loop-template').innerHTML
    commits: []
    el: '.show'
    $contributors: document.getElementById('contributors')
    $commits: document.getElementById('commits')

    events:
      'click .toggle-old-commits': 'toggleOldCommits'

    initialize: ->
      owner = @config.stalking.owner
      repo = @config.stalking.repo
      Github.getRepo owner, repo, {}, (repo) =>
        @$el.find('.stalking').html @compiled(repo)
        @getAllCommits()
      , => @error404()
      Github.getContributors owner, repo, {}, (contributors) =>
        topThree = contributors.slice(0, 3)
        @$contributors.innerHTML = @contributorsTemplate(topThree: topThree)
      , => @error404()

    getAllCommits: (sha) ->
      self = @
      params = if sha? then data: sha: sha else {}
      Github.getCommits @config.stalking.owner, @config.stalking.repo, params, (commits) ->
        self.commits = self.commits.concat(commits)
        lastCommitParents = commits[commits.length-1].parents
        if lastCommitParents.length is 0 or self.commits.length >= 1000
          self.$el.find('.commits-count').html(if lastCommitParents.length is 0 then self.commits.length else '1000+')
          self.showUnreadCommits() # Show commits
        else
          self.getAllCommits lastCommitParents[0].sha # Continue adding commits

    showUnreadCommits: ->
      visible = no
      lastCommitsSeen = @config.stalking.last_commit_seen
      lastCommitSha = @commits[0].sha # Save last commit sha before it is removed from list
      if lastCommitsSeen? # User has already stalked this repo at least once
        notSeenCommits = []
        _.each @commits, (commit) ->
          if commit.sha is lastCommitsSeen then return no # Stop pushing commits if we've reached last commit seen
          notSeenCommits.push(commit)
        if notSeenCommits.length > 0 # If there are new commits to display
          content = @commitsLoopTemplate notSeenCommits
        else
          content = '<p>You\'ve already seen all commits for this repository.</p>'
        @commits = @commits.slice(notSeenCommits.length) # Remove new commits to the commits list
      else # User has never stalked this repo
        visible = yes # As user has never stalked the repo, show him all commits for the first time
        content = '<p>Commits not seen yet.<br>You can now see them in order to see new commits next time you\'ll stalk this repository</p>'
      commitsLoop = @commitsLoopTemplate(@commits)
      @$commits.innerHTML = @commitsTemplate(content: content, commits: commitsLoop, visible: visible)
      @updateLastCommitSeen lastCommitSha # Update stalking.last_commit_seen to the last commit of the repo

    toggleOldCommits: (e) ->
      e.preventDefault()
      $previous = @$el.find('.previous')
      if $previous.is(':visible') then $previous.hide() else $previous.show()

    updateLastCommitSeen: (sha) ->
      $.ajax
        url: '/stalkings/' + @config.stalking.id
        type: 'PUT'
        dataType: 'json'
        data: stalking: last_commit_seen: sha

    error404: -> @$el.find('.stalking').html '<h1>Repository not found</h1>'

  new StalkingView()