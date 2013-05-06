define [], ->

  class Github

    constructor: ->
      @apiUrl = 'https://api.github.com/'
      @ciPerPage = 20
      @params = ($el = $ '#require-js') and $el.data('params') or {}
      @token = if @params? then @params.user.token else ''
      @default =
        method: 'get'
        dataType: 'jsonp'
        data: {}

    makeRequest: (url = '', method = @default.method, dataType = @default.dataType, data = @default.data) ->
      data.access_token = @token
      data.per_page = @ciPerPage unless data.per_page?
      $.ajax
        url:      @apiUrl + url
        type:     method
        dataType: dataType
        data:     data

    getCommits: (owner, repo, params, cb) ->
      method   = if params.method?   params.method   else @default.method
      dataType = if params.dataType? params.dataType else @default.dataType
      data     = if params.data?     params.data     else @default.data
      @makeRequest('repos/' + owner + '/' + repo + '/commits', method, dataType, data)
        .done (res) =>
            cb(res.data)


  # Return class instance
  new Github