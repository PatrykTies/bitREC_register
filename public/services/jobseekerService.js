(function(){
	angular.module('myapp')

	.factory('Jobseeker', ['$http', function($http){
		'use strict';
		var jobseekerFactory = {};

		jobseekerFactory.signup = function(jobseeker){

			/*return $http.post('/api/signup', jobseeker).success(function(data){
				console.log('POST from angular successful' + data);
				return data;
			});*/
			
			var fd = new FormData();
			for(var key in jobseeker){
				fd.append(key, jobseeker[key]);
			}
			
			$http.post('/api/signup', fd, {
				transformRequest: angular.identity,
				headers: {'Content-Type': undefined}
			});
				
			
		};

		return jobseekerFactory;
	}]);






	


}());