(function(){

	var dbConnection = require('./dbConnection.js');
	var totalScore = require('./totalScore.js');

	var jobseekerDao = {

		createJobseeker : function(jobseeker, resumeurl, OnSuccessfulCallback){



			var timestamp = function() { 
				    var d = new Date(Date.now()),
				        month = '' + (d.getMonth() + 1),
				        day = '' + d.getDate(),
				        year = d.getFullYear(),
				        hours = d.getHours(),
				        minutes = d.getMinutes(),
				        seconds = d.getSeconds();


				    if (month.length < 2) month = '0' + month;
				    if (day.length < 2) day = '0' + day;

				    var formattedDate = [year, month, day].join('/');
				    var formattedTime = [hours, minutes, seconds].join(':');

				    return formattedDate +' '+ formattedTime;
				};

			var totalScore = function(){
				var totalScore = 0,
				english = jobseeker.english_level,
				availability = jobseeker.employement_status,
				whenCanStart = jobseeker.when_to_start_work;

				if(availability){
					if(availability == 1 ) totalScore += 30;
					else if (availability == 2) totalScore += 10;
					else if (availability == 3) totalScore -= 20;
					else if (availability == 4) totalScore += 10;
				}else {
					console.log('no availability OR when_to_start_work answer has been passed!');
				}


				if(whenCanStart){
					if(whenCanStart == 1 ) totalScore += 30;
					else if (whenCanStart == 2) totalScore += 10;
					else if (whenCanStart == 3) totalScore -= 10;
					else if (whenCanStart == 4) totalScore -= 50;
				}else {
					console.log('no availability OR when_to_start_work answer has been passed!');
				}


				if(english){
					if(english == 1) totalScore += 40;
					else if (english == 2) totalScore += 20;
					else if (english == 3) totalScore += 10;
			
				}else {
					console.log('no english lvl answer has been passed!');
				}

				return totalScore;
			};

			/*totalScore.totalScore.getScore(jobseeker, function(scores){
					console.log(scores + 'fsdfsfs');
					return scores;
			});*/

			console.log('TOTAL SCORE FOR THIS JOBSEEKER IS: ' + totalScore());

			var insertStatement = "INSERT INTO jobseeker SET?";
			var jobseekerObj = {

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
				total_score: totalScore(),
				date_of_register: timestamp()
				
			};

			var connection = dbConnection.dbConnection.getMysqlConnection();

			if(connection){

				connection.query(insertStatement, jobseekerObj, function(err, result){

					if(err){throw err;}
					OnSuccessfulCallback({status: 'Successfuly inserted into MySQL!'});
					console.log(result);
				});

				dbConnection.dbConnection.closeMysqlConnection(connection);
			}
		},

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


		}
	};

	module.exports.jobseekerDao = jobseekerDao;

}());
