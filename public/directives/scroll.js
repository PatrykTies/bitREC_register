(function(){
	'use strict';

	angular.module('myapp')
		.directive('scroll', function($window){
			return {
				
				link: function(scope, element, attrs) {
			        angular.element($window).bind("scroll", function() {
			             if (this.pageYOffset >= 400) {
			                 scope.boolChangeClass = true;               
			             } else {
			                 scope.boolChangeClass = false;     
			             }
			            scope.scroll =this.pageYOffset;
			            scope.$apply();
			      	  });
			    	}
			};
		});
}());