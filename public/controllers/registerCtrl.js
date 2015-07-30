(function(){

	angular.module('myapp').controller('registerCtrl', ['$scope','Jobseeker', 'multipartForm',function($scope, Jobseeker, multipartForm){
		'use strict';

	    /*
		$scope.$watch('home.nationality' , function(newValue, oldValue){

			if(newValue) alert(newValue);
		},true);*/

		
		
		

		home.doSignup = function(){
			console.log($scope.jobseeker);
			Jobseeker.signup($scope.jobseeker)
				.success(function(data){
					console.log('from service' + data);
					return data;
				});
			

		};





	}]);

}());
			

