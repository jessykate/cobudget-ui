`// @ngInject`

angular.module('cobudget').service 'ContributionService', (Restangular, ContributionModel) ->

  #get details of contribution
  get: (contribution_id) ->
    Restangular.one('contributions', contribution_id).get()
    .then (contribution) ->
      new ContributionModel(contribution.plain())

  create: (contribution) ->
    Restangular.all('contributions').post(contribution)

  update: (contribution) ->
    Restangular.one('contributions', contribution.id)
    .customPUT(contribution, '',
      {contribution: {amount_cents: contribution.amount_cents, bucket_id: contribution.bucket_id}},
      {Accept: "application/json"})

  save: (contribution) ->
    if contribution.id
      @update(contribution)
    else
      @create(contribution)