var express = require('express');
var router = express.Router();

var db = require('../queries');
/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/checkIns', db.getAllCheckIns);
router.get('/checkIns/:id', db.getSingleCheckIn);
router.post('/checkIns', db.checkIn);
router.put('/checkIns/:id', db.updateCheckIn);
router.delete('/checkIns/:id', db.removeCheckIn);

module.exports = router;
