define [
  'jquery',
  'backbone',
  'collections/CommitList',
  'models/Commit',
  'views/CommitView'
], ($, Backbone, CommitList, Commit, CommitView) ->

  CommitListView = Backbone.View.extend

    initialize: ->
      @collection = new CommitList()

    render: ->
      content = ''
      _.map @collection.models, (model) ->
        content += new CommitView({ model: model }).render();
      content