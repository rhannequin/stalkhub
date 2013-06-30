define [
  'jquery',
  'backbone',
  'handlebars',
  'Github'
], ($, Backbone, Handlebars, Github) ->

  Handlebars.registerHelper 'strToTime', (dateStr) ->
    date = new Date dateStr
    date.toDateString()

  Handlebars.registerHelper 'isset', (arr, key, fn) ->
    fn(this) if typeof arr[key] isnt 'undefined'

  StalkingView = Backbone.View.extend

    config: JSON.parse document.getElementById('require-js').getAttribute('data-params')
    compiled: Handlebars.compile document.getElementById('stalking-template').innerHTML
    contributorsTemplate: Handlebars.compile document.getElementById('contributors-template').innerHTML
    commits: []
    el: '.stalking'
    $contributors: document.getElementById('contributors')

    initialize: ->
      owner = @config.stalking.owner
      repo = @config.stalking.repo
      Github.getRepo owner, repo, {}, (repo) =>
        @$el.html @compiled(repo)
        @getAllCommits()
      , => @error404()
      Github.getContributors owner, repo, {}, (contributors) =>
        topThree = contributors.slice(0, 3)
        @$contributors.innerHTML = @contributorsTemplate(topThree: topThree)
      , => @error404()

    render: ->
      @compiled @model.toJSON()

    getAllCommits: (sha) ->
      self = @
      params = if sha? then data: sha: sha else {}
      Github.getCommits @config.stalking.owner, @config.stalking.repo, params, (commits) ->
        self.commits = self.commits.concat(commits)
        lastCommitParents = commits[commits.length-1].parents
        if lastCommitParents.length is 0
          self.$el.find('.commits-count').html self.commits.length
        else if self.commits.length >= 1000
          self.$el.find('.commits-count').html '1000+'
        else
          self.getAllCommits lastCommitParents[0].sha

    error404: -> @$el.html '<h1>Repository not found</h1>'

  new StalkingView()