(function(){

	angular.module('myapp').controller('registerCtrl', ['$scope','Jobseeker', 'multipartForm', '$translate',function($scope, Jobseeker, multipartForm, $translate){
		'use strict';

		var register = this;
		
		register.step = 1;

		$scope.advance = function () {
		      register.step++;
		};
		$scope.goback = function () {
			if(register.step != 1) register.step--; 
		};
		$scope.advance = function () {
		      register.step++;
		};
		$scope.advanceLanguage = function (langKey) {

		    $translate.use(langKey);
		    register.step++;
		 };

		
	    
		/*$scope.$watch('jobseeker.file' , function(newValue, oldValue){

			if(newValue) alert(newValue);
		},true);*/

		


		$scope.jobseeker = {};

		
		

		register.doSignup = function(){
			
			Jobseeker.signup($scope.jobseeker);
				

		};

	}]);

}());

