define ['jquery', 'backbone', 'handlebars'], ($, Backbone, Handlebars) ->

  Handlebars.registerHelper 'safe', (text) -> new Handlebars.SafeString text

  CommitView = Backbone.View.extend

    tagName: 'li'
    compiled: Handlebars.compile $('#commit-template').html()

    initialize: ->

    render: () ->
      model    = @model
      datetime = @createDatetime()

      ciStr = @compiled
        author:  @setAuthor()
        message: model.get('message')
        date:    datetime.date
        time:    datetime.time

    setAuthor: ->
      model = @model
      login = model.get('author')
      if model.get('isLoggedProfile') then '<a href="https://github.com/' + login + '">@' + login + '</a>' else login

    createDatetime: () ->
      date    = @model.get('date')
      day     = parseInt(date.getDate(),    10) + 1
      month   = parseInt(date.getMonth(),   10) + 1
      hour    = parseInt(date.getHours(),   10)
      minutes = parseInt(date.getMinutes(), 10)
      time    = (if hour < 10 then '0' + hour else hour) + ':' + (if minutes < 10 then '0' + minutes else minutes)
      date    = (if day  < 10 then '0' + day else day)   + '/' + (if month < 10 then '0' + month else month) +  '/' + date.getFullYear()
      result = date: date, time: time