(function(){
  'use strict';

var app = angular.module('myapp', ['ui.router','ngAnimate']);

app.config(['$urlRouterProvider', '$stateProvider', function($urlRouterProvider, $stateProvider) {
    $urlRouterProvider.otherwise('home');
    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'views/home.html',
        controller: 'homeCtrl as home'
      })
      .state('hire', {
        url: '/hire',
        templateUrl: 'views/hire.html',
        controller: 'hireCtrl as hire'
      })
      .state('test', {
          
          url: '/test',
          templateUrl: 'views/test.html',
          
      })
      .state('test.many',{
              templateUrl:"views/test.many.html",
              controller: 'testCtrl'
              
      })
      .state('test.many2',{
              templateUrl:"views/test.many.html",
              controller: 'test2Ctrl'
              
      })
      .state('test.many3',{
              templateUrl:"views/test.many.html",
              controller: 'test3Ctrl'
            
      })
      .state('register', {
        url: '/register',
        templateUrl: 'views/register.html',
        controller: 'registerCtrl as register'
      });
      
}]);


app.factory('Quiz', function(){
  var data =[
      {q:'Jestes gotowy/a ?',a:'tak'},
      {q:'2+2?',a:'4'}
    ];
  return {
    getData: function(){
      return data;
    }
  }
});

}());

