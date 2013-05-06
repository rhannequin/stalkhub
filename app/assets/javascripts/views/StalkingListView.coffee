define [
  'jquery',
  'backbone',
  'collections/StalkingList',
  'models/Stalking',
  'views/StalkingView'
], ($, Backbone, StalkingList, Stalking, StalkingView) ->

  StalkingListView = Backbone.View.extend

    initialize: ->
      @collection = new StalkingList()

    render: ->
      content = ''
      _.map @collection.models, (model) ->
        content += new StalkingView({ model: model }).render();
      content