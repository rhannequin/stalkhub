define ['backbone'], (Backbone) ->

  Commit = Backbone.Model.extend

    defaults:
      author: 'Unknown user'
      isLoggedProfile: yes

    initialize: ->