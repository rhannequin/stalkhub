require.config
  paths:
    jquery: 'jquery'
    bootstrap: 'twitter/bootstrap'
    backbone: 'backbone'
    lodash: 'lodash'
    handlebars: 'handlebars.min'
  shim:
    jquery:
      exports: '$'
    bootstrap:
      deps: ['jquery']
      exports: 'Bootstrap'
    lodash:
      exports: '_'
    backbone:
      deps: ['lodash']
      exports: 'Backbone'
    handlebars:
      exports: 'Handlebars'
  baseUrl: '/assets/'

require ['jquery', 'bootstrap'], ($) ->
  require(['app']) if $('#require-js').data('params').user?