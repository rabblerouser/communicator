var aws = require('aws-sdk');

console.log("File loaded");

exports.handler = function(event, context, callback) {
    console.log("event: ", event);
    console.log("context: ", context);
    callback(null, {message: "I did a thing!"});
};
