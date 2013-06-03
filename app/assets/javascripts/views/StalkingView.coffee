define ['jquery', 'backbone', 'handlebars'], ($, Backbone, Handlebars) ->

  StalkingView = Backbone.View.extend

    compiled: Handlebars.compile $('#stalking-template').html()

    initialize: ->

    render: ->
      @compiled @model.toJSON()