// location filters
var fs = require('fs'),
	fileLocation = 'locations.json';
var locations = {},
	locationsFormatted = {}; // remove excessive data such as gps points of buildings

LoadFile();

function LoadFile () {
	// load from file
	fs.readFile(fileLocation, function(err,data) {
		if (err) {
			console.log('loading error');
			return;
		}
		if (data != null) {
			var json = {};
			try {
				json = JSON.parse(data);
			}
			catch (error) {
				console.log(error);
			}
			finally {
				locations = json;
			}
		}
	});
}

function getLocations (coordinates) {
	var tempLocations = {
		selected: locations.selected,
		locations: locations.locations
	};
	
	if (coordinates != null) tempLocations.selected = MatchCoordinates(coordinates);

	return tempLocations;
}

function MatchCoordinates (coordinates) {
	// if no match return null
	// else, return {building:x,campus:x}

	/* 	LOOK FOR MATCHING LOCATIONS
		------------------
		Use Google Maps +
		Use https://github.com/tparkin/Google-Maps-Point-in-Polygon
		To Find if coordinates match any saved locations


		IF NONE FOUND, LOOK FOR CLOSEST LOCATION
		------------------
		Use GetDistance Function
		Loop every point of every location...compare to coordinates
	*/
}

function GetDistance (x1,y1,x2,y2) {
	return Math.sqrt( ((x2-x1)*(x2-x1)) + ((y2-y1)*(y2-y1)) );
}

module.exports = getLocations;