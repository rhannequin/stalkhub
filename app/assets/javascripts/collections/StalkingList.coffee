define ['jquery', 'backbone', 'models/Stalking'], ($, Backbone, Stalking) ->

  StalkingList = Backbone.Collection.extend

    model : Stalking

    initialize: ->