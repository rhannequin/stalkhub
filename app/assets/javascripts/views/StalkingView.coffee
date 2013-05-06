define ['jquery', 'backbone'], ($, Backbone) ->

  StalkingView = Backbone.View.extend

    compiled: Handlebars.compile $('#stalking-template').html()

    initialize: ->

    render: ->
      @compiled @model.toJSON()