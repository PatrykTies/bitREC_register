module.exports = function(app, express){
	var multer = require('multer');
	var fs = require('fs');
	var api = express.Router();

	var upload = multer({ 
		dest: './uploads/',
		limits: {
       	   fileSize: 5000000
    	},
		
	});

	api.post('/signup', upload.single('file'), function(req,res){
		 /** When using the "single"
      data come in "req.file" regardless of the attribute "name". **/
	  var tmp_path = req.file.path;

	  /** The original name of the uploaded file
	      stored in the variable "originalname". **/
	  var target_path = './uploads/' + req.file.originalname;

	  /** A better way to copy the uploaded file. **/
	  var src = fs.createReadStream(tmp_path);
	  var dest = fs.createWriteStream(target_path);
	  src.pipe(dest);
	  src.on('end', function() { console.log('completed!'); });
	  src.on('error', function(err) { res.render('error'); });

		var jobseekerDao = require('./jobseekerDao.js');
		//console.log('text data arrived in api' + req.body + req.file);
		
		jobseekerDao.jobseekerDao.createJobseeker(req.body,  target_path, function(status){
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

	return api;
};