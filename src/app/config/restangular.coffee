`// @ngInject`
angular.module('cobudget').config (RestangularProvider, config) ->
  RestangularProvider.setBaseUrl(config.apiEndpoint)
  RestangularProvider.setDefaultHttpFields
    withCredentials: true
  RestangularProvider.setDefaultHeaders
    Accept: "application/json"

  RestangularProvider.setResponseInterceptor (data, operation, what, url, response, deferred) ->
    if operation is "get" or operation is "post"
      # Trim the 's' off so we can reference the singular root note name
      # This is a total hack and won't work for resources like "people"
      return response.data[what.substring(0, what.length-1)]
    if operation is "getList"
      return response.data[what]

  RestangularProvider.setRequestInterceptor (element, operation, what, url) ->
    if operation is "post"
      # Add singular root node to element
      newElem = {}
      newElem[what.substring(0, what.length-1)] = element
      return newElem
    if operation is "update"
      # Trim the 's' off so we can reference the singular root note name
      # This is a total hack and won't work for resources like "people"
      return response.data[what.substring(0, what.length-1)]