define ['jquery'], ($) ->

  class Github

    constructor: ->
      @apiUrl = 'https://api.github.com/'
      @ciPerPage = 100
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

    setParams: (params) ->
      method   = if params.method?   then params.method   else @default.method
      dataType = if params.dataType? then params.dataType else @default.dataType
      data     = if params.data?     then params.data     else @default.data
      return {
        method: method
        dataType: dataType
        data: data
      }

    getRepo: (owner, repo, params, cb, err = ->) ->
      params = @setParams params
      @makeRequest('repos/' + owner + '/' + repo, params.method, params.dataType, params.data)
      .done (res) ->
        if res.meta.status is 404 then err() else cb(res.data)
      .fail -> err()

    getCommits: (owner, repo, params, cb, err = ->) ->
      params = @setParams params
      @makeRequest('repos/' + owner + '/' + repo + '/commits', params.method, params.dataType, params.data)
      .done (res) ->
        if res.meta.status is 404 then err() else cb(res.data)
      .fail -> err()

    getContributors: (owner, repo, params, cb, err = ->) ->
      params = @setParams params
      @makeRequest('repos/' + owner + '/' + repo + '/contributors', params.method, params.dataType, params.data)
      .done (res) ->
        if res.meta.status is 404 then err() else cb(res.data)
      .fail -> err()


  # Return class instance
  new Github