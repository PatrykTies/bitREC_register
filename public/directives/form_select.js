(function(){
	'use strict';

	 var form_select = function(){



	 	//var template = '<div class="col s4"></div>',

	 	var link = function(s,element,a){
	 			
	 			
	 			element.material_select();
	 			
	 			
	 		};




			return {	
				link: link,
				//template: template
			};
		};



	angular.module('myapp').directive('formSelect', form_select);

}());