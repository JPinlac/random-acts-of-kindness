var promise = require('bluebird');

var options = {
	// Initialization Options
	promiseLib: promise
};

var pgp = require('pg-promise')(options);
var connectionString = 'postgres://postgres:super@localhost:5432/rak';
var db = pgp(connectionString);

// add query functions
function getAllCheckIns(req, res, next) {
	db.any('select * from checkIn')
		.then(function (data) {
			res.status(200)
			.json({
				status: 'success',
				data: data,
				message: 'Retrieved all check-ins'
			});
		})
	.catch(function (err) {
		return next(err);
	});
}

function getSingleCheckIn(req, res, next) {
	var checkInId = parseInt(req.params.id);
	db.one('select * from checkIn where id = $1', checkInId)
		.then(function (data) {
			res.status(200)
			.json({
				request: req.body,
				status: 'success',
				data: data,
				message: 'Retrieved ONE check-in'
			});
		})
	.catch(function (err) {
		return next(err);
	});
}

function checkIn(req, res, next) {
	req.body.location[0] = parseFloat(req.body.location[0]);
	req.body.location[1] = parseFloat(req.body.location[1]);
	db.none('insert into checkIn(location, userId, descriptionProperty, card)' +
			'values(${location}, ${userId}, ${descriptionProperty}, ${card})',
			req.body)
		.then(function () {
			res.status(200)
			.json({
				status: 'success',
			message: 'Inserted ONE check-in'
			});
		})
	.catch(function (err) {
		return next(err);
	});
}
function addUser(req, res, next) {
		req.bo
}
function updateCheckIn(req, res, next) {
	db.none('update checkIn set location=$1, userId=$2, descriptionProperty=$3 where id=$4',
			[req.body.location, req.body.userId,
			req.body.descriptionProperty, parseInt(req.params.id)])
		.then(function () {
			res.status(200)
			.json({
				status: 'success',
			message: 'Updated check-in'
			});
		})
	.catch(function (err) {
		return next(err);
	});
}

function removeCheckIn(req, res, next) {
	var checkInId = parseInt(req.params.id);
	db.result('delete from checkIn where id = $1', checkInId)
		.then(function (result) {
			/* jshint ignore:start */
			res.status(200)
			.json({
				status: 'success',
				message: `Removed ${result.rowCount} check-in`
			});
		/* jshint ignore:end */
		})
	.catch(function (err) {
		return next(err);
	});
}
module.exports = {
	getAllCheckIns: getAllCheckIns,
	getSingleCheckIn: getSingleCheckIn,
	checkIn: checkIn,
	updateCheckIn: updateCheckIn,
	removeCheckIn: removeCheckIn
};
