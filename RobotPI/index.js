'use strict';

// This example takes uncompressed wav audio from the Text to Speech service and plays it through the computer's speakers
// Should work on windows/mac/linux, but linux may require some extra setup first: https://www.npmjs.com/package/speaker

var TJBot = require('tjbot');
const TextToSpeechV1 = require('watson-developer-cloud/text-to-speech/v1');
const wav = require('wav');
const Speaker = require('speaker');
require('dotenv').load({ silent: true }); // imports environment properties from a .env file if present

const mqtt = require('mqtt')
const Credentials = require('./Credentials.js');
const mqtt_broker = 'mqtt://'+Credentials.IOT_ORG+'.messaging.internetofthings.ibmcloud.com'

var mqtt_options = {
  username: Credentials.IOT_API_KEY,
  password: Credentials.IOT_AUTH_TOKEN,
  clientId: 'a:' + Credentials.IOT_ORG + ':RemoteRobotPI'
}

var mqtt_client = mqtt.connect(mqtt_broker, mqtt_options);
var channel = 'iot-2/type/' + Credentials.IOT_DEVICE_TYPE + '/id/' + Credentials.IOT_DEVICE_ID + '/evt/RemoteRobot/fmt/json'


// these are the hardware capabilities that TJ needs for this recipe
var hardware = ['led'];

// set up TJBot's configuration
var tjConfig = {
    log: {
        level: 'verbose'
    }
};

// instantiate our TJBot!
var tj = new TJBot(hardware, tjConfig, Credentials);
// turn the LED off
tj.shine('off');

mqtt_client.on('connect', function () {
  mqtt_client.subscribe(channel,function(err, granted){
  	if(err){
  		console.log(err);  		
  	}
  	console.log(granted);
  });
});



mqtt_client.on('message', function (topic, message) {	
  var contentForRobot = JSON.parse(message)  
  var text = contentForRobot.text
  var ledColor = contentForRobot.blinkColor

  console.log("Text: "+ text);
  console.log("blinkColor: "+ledColor);
     
  //call watson api and play the sound.
  if(text){
  	playTextToTheSpeaker(text);
  }

// send signal to led to shine with the color
  if(ledColor){
  	tj.shine(ledColor.toLowerCase())
  }

});

const textToSpeech = new TextToSpeechV1(
  {
    // if left unspecified here, the SDK will fall back to the TEXT_TO_SPEECH_USERNAME and TEXT_TO_SPEECH_PASSWORD
    // environment properties, and then Bluemix's VCAP_SERVICES environment property
     username: Credentials.TEXT_TO_SPEECH_USERNAME,
     password: Credentials.TEXT_TO_SPEECH_PASSWORD
  }
);

/**
This call the watson services with the text and plays to the speaker
**/
function playTextToTheSpeaker(text){
	const reader = new wav.Reader();

	// the "format" event gets emitted at the end of the WAVE header
	reader.on('format', function(format) {
	  // the WAVE header is stripped from the output of the reader
	  reader.pipe(new Speaker(format));
	});

	textToSpeech.synthesize({ text: text, accept: 'audio/wav' }).pipe(reader);
}


function handleCloseRequest (message) {
  if (state !== 'closed' && state !== 'closing') {
    state = 'closing'
    sendStateUpdate()

    // simulate door closed after 5 seconds (would be listening to hardware)
    setTimeout(() => {
      state = 'closed'
      sendStateUpdate()
    }, 5000)
  }
}

/**
 * Want to notify controller that garage is disconnected before shutting down
 */
function handleAppExit (options, err) {
  if (err) {
    console.log(err.stack)
  }
  if (options.exit) {
    process.exit()
  }
}

/**
 * Handle the different ways an application can shutdown
 */
process.on('exit', handleAppExit.bind(null, {
  cleanup: true
}))
process.on('SIGINT', handleAppExit.bind(null, {
  exit: true
}))
process.on('uncaughtException', handleAppExit.bind(null, {
  exit: true
}))

