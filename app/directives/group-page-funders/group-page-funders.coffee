null

### @ngInject ###
global.cobudgetApp.directive 'groupPageFunders', () ->
    restrict: 'E'
    template: require('./group-page-funders.html')
    replace: true
    controller: ($scope, Dialog) ->

      $scope.toggleMemberAdmin = (membership) ->
        membership.isAdmin = !membership.isAdmin
        membership.save()

      $scope.deleteMembership = (membership) ->
        Dialog.custom
          template: require('./delete-membership-dialog.tmpl.html')
          scope: $scope
          controller: ($scope, $mdDialog, Records) ->
            $scope.member = membership.member()
            $scope.warnings = [
              "All of their funds will be deleted from currently funding buckets",
              "All of their funds will be removed from the group",
              "All of their ideas will be deleted from the group",
              "All of their comments will be deleted from the group"
            ]
            $scope.cancel = ->
              $mdDialog.cancel()
            $scope.proceed = ->
              membership.destroy().then ->
                $mdDialog.hide()

      return