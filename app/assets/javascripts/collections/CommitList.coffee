define ['jquery', 'backbone', 'models/Commit'], ($, Backbone, Commit) ->

  CommitList = Backbone.Collection.extend

    model : Commit

    initialize: ->