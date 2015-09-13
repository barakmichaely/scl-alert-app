/* EMAIL */


var postmark = require("postmark")('f8536579-7284-4950-9e3d-977cc96332d0');

function Send (data,callback) {
	postmark.send({
        "From": data.from? data.from : 'bm09148n@pace.edu',
        "To": data.to? data.to : 'bm09148n@pace.edu',
        "Subject": data.subject? data.subject : 'Default Subject',
        "TextBody": data.body? data.body : 'Default Body',
        "Tag": data.tag? data.tag : 'Important'
    }, callback);
    // callback (error, success)
}

module.exports = Send;