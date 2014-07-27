'use strict';

var searchApp = angular.module('searchApp', [
    'searchControllers'
]);

searchApp.factory('filterSelectService', function () {
    return {
    };
});

var searchControllers = angular.module('searchControllers', []);

searchControllers.controller('SearchListController', ['$rootScope', '$scope', '$http', 'filterSelectService', function ($rootScope, $scope, $http, filterSelectService) {
    $scope.filter = filterSelectService;

    $http.get('search/results.json').success(function(data) {
    	$scope.results = data;
    });	

    $scope.$watch('filter.profession', function (newValue, oldValue) {
	if (typeof(oldValue) !== 'undefined' && typeof(newValue) !== 'undefined') {
    	    $http.get('search/results.json', {params: $scope.filter}).success(function(data) {
    		$scope.results = data;
    	    });
	}
    });
    $scope.$watch('filter.speciality', function (newValue, oldValue) {
	if (typeof(oldValue) !== 'undefined' && typeof(newValue) !== 'undefined') {
    	    $http.get('search/results.json', {params: $scope.filter}).success(function(data) {
    		$scope.results = data;
    	    });
	}
    });
    $scope.$watch('filter.city', function (newValue, oldValue) {
	if (typeof(oldValue) !== 'undefined' && typeof(newValue) !== 'undefined') {
    	    $http.get('search/results.json', {params: $scope.filter}).success(function(data) {
    		$scope.results = data;
    	    });
	}
    });
}]);

searchControllers.controller('SearchFilterBarController', ['$rootScope', '$scope', '$http', 'filterSelectService', function ($rootScope, $scope, $http, filterSelectService) {

    $scope.filter = filterSelectService;
    
    $http.get('search/filters.json').success(function(data) {
	$scope.professions = data.professions;
	$scope.specialities = data.specialities;

	$scope.current_profession = data.professions[0];
	$scope.current_speciality = data.specialities[0];
	$scope.current_city = "New York";

	$scope.filter.profession = $scope.current_profession;
	$scope.filter.speciality = $scope.current_speciality;
	$scope.filter.city = $scope.current_city;
    });
    
    $scope.change_profession = function ( opt ) {
	$scope.filter.profession = $scope.current_profession;
    }

    $scope.change_speciality = function ( opt ) {
	$scope.filter.speciality = $scope.current_speciality;
    }

    $scope.change_city = function ( opt ) {
	$scope.filter.city = $scope.current_city;
    }

}]);
