(function(){
	module.exports = function(app, express){
		var multer = require('multer');
		var fs = require('fs');
		var api = express.Router();

		var storage = multer.diskStorage({
		  destination: function (req, file, cb) {
		    cb(null, './uploads/');
		  },
		  filename: function (req, file, cb) {
		    cb(null, file.originalname);
		  }
		 
		});

		var upload = multer({ storage: storage });

		/*var upload = multer({ 
			dest: './uploads/',
			limits: {
	       	   fileSize: 5000000
	    	},
			
		});*/

		api.post('/signup', upload.single('file'), function(req,res){

			var resumeurl;

			if(req.file){
				resumeurl = req.file.path;
			}else resumeurl = 'null';

			var jobseekerDao = require('./jobseekerDao.js');
			//console.log('text data arrived in api' + req.body + req.file);
			
			jobseekerDao.jobseekerDao.createJobseeker(req.body, resumeurl, function(status){
				res.json(status);
				console.log(status);
			});
		
			
			
				

		});
		api.post('/setcampaign', function(req,res){

			
			console.log(req.body);
			
			var jobseekerDao = require('./jobseekerDao.js');
			
			jobseekerDao.jobseekerDao.setCampaign(req.body, function(status){
				res.json(status);
				console.log(status);
			});
				

		});

		api.post('/setposition', function(req,res){
		
			console.log(req.body);
			
			var jobseekerDao = require('./jobseekerDao.js');
			
			jobseekerDao.jobseekerDao.setPosition(req.body, function(status){
				res.json(status);
				console.log(status);
			});
				

		});

		api.get('/jobseekers', function(req,res){

			var jobseekerDao = require('./jobseekerDao.js');

			jobseekerDao.jobseekerDao.getAllJobseekers(function(jobseekers){

				console.log(jobseekers);
				res.json({jobseekers : jobseekers});
				
			});

		});
		
		api.get('/campaigns', function(req,res){

			var campaignsDao = require('./campaignsDao.js');

			campaignsDao.campaignsDao.getAllCampaigns(function(campaigns){

				console.log(campaigns);
				res.json(campaigns);
				
			});

		});
		api.get('/positions', function(req,res){

			var positionsDao = require('./positionsDao.js');

			positionsDao.positionsDao.getAllPositions(function(positions){

				console.log(positions);
				res.json(positions);
				
			});

		});
		/*
		api.get('/translations', function(req,res){
			
				var dupa = function(){
					return 'Wybiez swoje umiejetnosci zawodowe.';
				};

				var lang = req.query.lang;
				if(lang === 'pl'){
					res.json({

						
					        SKILLS: 'Wybiez swoje umiejetnosci zawodowe.',
					        PARAGRAPH: 'Ernsthaft!',
					        PASSED_AS_TEXT: 'Hey! Ich wurde als text übergeben!',
					        PASSED_AS_ATTRIBUTE: 'Ich wurde als Attribut übergeben, cool oder?',
					        PASSED_AS_INTERPOLATION: 'Anfänger! Ich bin interpoliert!',
					        VARIABLE_REPLACEMENT: 'Hi {{name}}',
					        // MISSING_TRANSLATION is ... missing :)
					        BUTTON_LANG_DE: 'deutsch',
					        BUTTON_LANG_EN: 'englisch'
					    
					   
				 	   
				      }); 
				}
				else if(lang === 'en'){
					res.json({

						
					        SKILLS: 'dfgdfgdghdfghdhdhhdhddhdhdfhdhdhh',
					        PARAGRAPH: 'Ernsthaft!',
					        PASSED_AS_TEXT: 'Hey! Ich wurde als text übergeben!',
					        PASSED_AS_ATTRIBUTE: 'Ich wurde als Attribut übergeben, cool oder?',
					        PASSED_AS_INTERPOLATION: 'Anfänger! Ich bin interpoliert!',
					        VARIABLE_REPLACEMENT: 'Hi {{name}}',
					        // MISSING_TRANSLATION is ... missing :)
					        BUTTON_LANG_DE: 'deutsch',
					        BUTTON_LANG_EN: 'englisch'
					    
					   
				 	   
				      }); 
				}
	
		});*/

		api.get('/translations', function(req,res){

			var fs = require('fs'),
				JSONStream = require('JSONStream'),
				es = require('event-stream');
			
			var query = req.query.lang;
			
			var getStream = function(){
				var jsonData = 'translations.json',
					stream = fs.createReadStream(jsonData, {encoding:'utf8'}),
					parser = JSONStream.parse(['lang',true,query]);
					return stream.pipe(parser);
			};

			getStream().pipe(es.mapSync(function(data){
			
				res.json(data);
			}));

			
			/*
			if(query === 'pl'){
				res.json(
				   data.lang[0].pl
				);
			}*/
	
		});


		return api;
	};
}());

/*
		{
			"en": {
				SKILLS: 'Select your work skills',
		        PARAGRAPH: 'Ernsthaft!',
		        PASSED_AS_TEXT: 'Hey! Ich wurde als text übergeben!',
		        PASSED_AS_ATTRIBUTE: 'Ich wurde als Attribut übergeben, cool oder?',
		        PASSED_AS_INTERPOLATION: 'Anfänger! Ich bin interpoliert!',
		        VARIABLE_REPLACEMENT: 'Hi {{name}}',
		        // MISSING_TRANSLATION is ... missing :)
		        BUTTON_LANG_DE: 'deutsch',
		        BUTTON_LANG_EN: 'englisch'
			}
		},
		{
			"ro": {
				SKILLS: 'sdgfsfsdfsdfsfsfr sfsf  fsfs ',
		        PARAGRAPH: 'Ernsthaft!',
		        PASSED_AS_TEXT: 'Hey! Ich wurde als text übergeben!',
		        PASSED_AS_ATTRIBUTE: 'Ich wurde als Attribut übergeben, cool oder?',
		        PASSED_AS_INTERPOLATION: 'Anfänger! Ich bin interpoliert!',
		        VARIABLE_REPLACEMENT: 'Hi {{name}}',
		        // MISSING_TRANSLATION is ... missing :)
		        BUTTON_LANG_DE: 'deutsch',
		        BUTTON_LANG_EN: 'englisch'
			}
		}*/