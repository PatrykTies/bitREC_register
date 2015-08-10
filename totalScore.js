(function(){

	var totalScore ={

		getScore : function(jobseeker, callback){

			var scores = {};

			var english = jobseeker.english_level;

			if(english){
				if(english == 1) scores.english = 30;
				else if (english == 2) scores.english = 20;
				else if (english == 3) scores.english = 10;
		
			}else {
				console.log('no english lvl answer has been passed!');
			}
			callback(scores.english);
			
			/*var jobseekerObj = {

				first_name: jobseeker.first_name,
				last_name: jobseeker.last_name,
				age: jobseeker.age ,
				email_id: jobseeker.email_id,
				nationality: jobseeker.nationality,
				contact_no: jobseeker.contact_no,
				postal_code: jobseeker.postal_code,
				resume_url: resumeurl,
				employement_status: jobseeker.employement_status,
				when_to_start_work: jobseeker.when_to_start_work,
				worked_before: jobseeker.worked_before,
				english_level: jobseeker.english_level,
				date_of_register: timestamp()
				
			};*/

			
		}
		/*
		getAllJobseekers : function(callback){

			var queryStatement = "SELECT * FROM jobseeker ORDER BY jobseeker_id DESC";
			var connection = dbConnection.dbConnection.getMysqlConnection();

			if(connection){

				connection.query(queryStatement, function(err, rows, fields){

					if(err){throw err;}
					console.log(rows);
					callback(rows);
				});

				dbConnection.dbConnection.closeMysqlConnection(connection);
			}


		}*/
	};

	module.exports.totalScore = totalScore;

}());
