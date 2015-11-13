null

### @ngInject ###
global.cobudgetApp.directive 'groupPageFunders', () ->
    restrict: 'E'
    template: require('./group-page-funders.html')
    replace: true
    controller: (Dialog, $scope, $window) ->

      $scope.toggleMemberAdmin = (membership) ->
        membership.isAdmin = !membership.isAdmin
        membership.save()

      $scope.removeMembership = (membership) ->
        Dialog.custom
          template: require('./remove-membership-dialog.tmpl.html')
          scope: $scope
          controller: ($scope, $mdDialog, Records) ->
            $scope.member = membership.member()
            $scope.warnings = [
              "All of their funds will be removed from currently funding buckets",
              "All of their funds will be removed from the group",
              "All of their ideas will be removed from the group",
              "All of their funding buckets will be removed from the group and money will be refunded"
            ]
            $scope.cancel = ->
              $mdDialog.cancel()
            $scope.proceed = ->
              membership.archive().then ->
                $mdDialog.hide()
                Dialog.alert(
                  title: 'Success!' 
                  content: "#{$scope.member.name} was removed from #{$scope.group.name}"
                ).then ->
                  $window.location.reload()

      return