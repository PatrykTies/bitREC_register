var mysql = require('mysql'),
	database_config = require('./database_config.js'),
	dbConnection = {
		getMysqlConnection: function(){
			var connection = mysql.createConnection(database_config.database_config.dev);

			connection.connect(function(err){
				if(err){throw err;}
				console.log('Connected to MySQL');
			});
			return connection;
		},
		closeMysqlConnection: function(currentConnection){
			if(currentConnection){
				currentConnection.end(function(err){
					if(err){throw err;}
					console.log('Connection with DB closed.');
				});
			};
		}
	}

module.exports.dbConnection = dbConnection;
