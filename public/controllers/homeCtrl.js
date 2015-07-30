(function(){

	angular.module('myapp').controller('homeCtrl', ['$scope','Jobseeker', 'multipartForm',function($scope, Jobseeker, multipartForm){
		'use strict';

		var home = this;
		
		home.step = 1;

		$scope.advance = function () {
		      home.step++;
		};
		$scope.goback = function () {
			if(home.step != 1) home.step--; 
		};
		
	    
		/*$scope.$watch('jobseeker.file' , function(newValue, oldValue){

			if(newValue) alert(newValue);
		},true);*/

		


		$scope.jobseeker = {};

		
		
		


		

		home.doSignup = function(){
			
			Jobseeker.signup($scope.jobseeker);
				

		};





	}]);
			








}());