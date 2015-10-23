
/********************************************  THIS IS NODE.JS API RELATED   *******************************************************/
(function(){

	var dbConnection = require('./dbConnection.js');
	var totalScore = require('./totalScore.js');

	var companyAndCampaignObj = {};
	var companyIDObj = {};
	var jobseekerPositionType = {};


	var jobseekerDao = {

		createJobseeker : function(jobseeker, resumeurl, OnSuccessfulCallback){

			
			console.log('from createJobseeker '+ companyAndCampaignObj.campaign);

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

			console.log('TOTAL SCORE FOR THIS JOBSEEKER IS: ' + totalScore());

			
			
			//var insertStatement = "INSERT INTO jobseeker SET?";
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

			var jobseekerCampaign = {campaign_id: jobseeker.campaign_id};

			var connection = dbConnection.dbConnection.getMysqlConnection();

			if(connection){
				connection.beginTransaction(function(err){
					if(err) {throw err;}

					connection.query("INSERT INTO jobseeker SET?", jobseekerObj, function(err, result){

						if(err){					
							return connection.rollback(function(){
								throw err;
							});
						}
						var jobseeker_id = result.insertId;
						
						//THIS IS OBJECT CREATED FOR MYSQL INSERT
						var jobseeker_status = {jobseeker_id: jobseeker_id, 
												company_id: companyIDObj.company, 
												campaign_id: companyAndCampaignObj.campaign,
												position_id: jobseekerPositionType.position
											   };

						connection.query("INSERT INTO jobseeker_status SET?",
									     jobseeker_status,									 
										 function(err, result){
							if(err){					
								return connection.rollback(function(){
									throw err;
								});
							}
							connection.commit(function(err){
								if(err){					
									return connection.rollback(function(){
										throw err;
									});
								}
								
								console.log('Successfuly inserted into MySQL!');
								dbConnection.dbConnection.closeMysqlConnection(connection);
							});

						});
						
					});

						
				});
				
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


		},
	

		setCampaign : function(campaign, callback){

			var selectedCampaign = campaign.campaign;

			var message = "JobseekerServer " + selectedCampaign;
			

			//---------------------------------------------------------
			companyAndCampaignObj = {campaign: selectedCampaign}; 
			console.log(companyAndCampaignObj.campaign);
			//NOW I MUST QUERY campaign TABLE WHERE campaign_id == companyAndCampaignObj.campaign and select its company_id
			var queryStatement = "SELECT company_id FROM campaigns WHERE campaign_id =?";
			var connection = dbConnection.dbConnection.getMysqlConnection();

			if(connection){

				connection.query(queryStatement, [companyAndCampaignObj.campaign] ,function(err, result){

					if(err){
						throw err;
					}

					
					companyIDObj = {company: result[0].company_id};

					callback({status: companyIDObj.company});
						
				});

				dbConnection.dbConnection.closeMysqlConnection(connection);
			}

		},

		setPosition : function(position, callback){

			var selectedPosition = position.position;

			var message = "JobseekerServer " + selectedPosition;
			

			//---------------------------------------------------------
			jobseekerPositionType = {position: selectedPosition}; 
			console.log('Position inside jobseekerDAO: ' + jobseekerPositionType.position);
			

		}


	};
	

	module.exports.jobseekerDao = jobseekerDao;

}());
