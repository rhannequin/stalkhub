define ['jquery', 'jqueryujs'], ($, jqueryujs) ->
  script = $('#require-js').data 'script'
  if script? then require([script])