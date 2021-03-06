let Gpio = require('onoff').Gpio
let mqtt = require('mqtt')
let usonic = require('mmm-usonic')

let client = mqtt.connect('mqtt://broker.hivemq.com') //mqtt broker connection

let rotation = new Gpio(4, 'in', 'falling', {debounceTimeout: 10}) //declares wire that works as current sensor for wheel rotation counting
//let turnLeft = new Gpio(26, 'in', 'both', {debounceTimeout: 10})
//let turnRight = new Gpio(27, 'in', 'both', {debounceTimeout: 10})
//let ledLeft = new Gpio(24, 'out')
//let ledRight = new Gpio(23, 'out')
let led = new Gpio(17, 'out') //declares wire responsable for reacting to the proximity sensor

let vcc = new Gpio(18, 'out')
vcc.write(1, function() {})

let counter = 0 //wheel turn counter
//let makingALeft = false
//let makingARight = false
let resposta = {} //object used to send data

//let leftTurnInterval, rightTurnInterval
let mqttInterval = setInterval(function(){sendMqtt();}, 2000) // defines the interval in which the mqtt data is published

function sendMqtt() { //function to send mqtt data
	resposta.counter = counter
	resposta.timestamp = new Date()
	counter = 0
	console.log(resposta)
	client.publish('bikeiot', JSON.stringify(resposta))
}

function makeALeft(){ //code for the turning button, not finished during the hackathon
	makingALeft = true
	makingARight = false
	leftTurnInterval = setInterval(function(){
		if(ledLeft.readSync())
			ledLeft.write(0, function() {})
		else
			ledLeft.write(1, function() {})
	}, 500)
}

function makeARight(){ //code for the turning button, not finished during the hackathon
	makingARight = true
	makingLeft = false
	console.log(ledRight.readSync())
	rightTurnInterval = setInterval(function(){
		if(ledRight.readSync())
			ledRight.write(0, function() {})
		else
			ledRight.write(1, function() {})
	}, 500)
}

rotation.watch((err, value) => { //function that reacts to the state change in the makeshift current sensor used for counting wheel turns
	if (err) 
		throw err
	counter++
})

usonic.init(function (error) { //initialization of the ultrasonic proximity sensor
	if (error) {
		console.log(error)
		return
	}
	let sensor = usonic.createSensor(21, 20, 1000) //defining the proximity sensor
	setInterval(function() {
		if(sensor().toFixed(2) < 120){
			led.write(1, function() {}) // turns on leds and buzzer if distance from the sensor is under 120 cm
		} else {
			led.write(0, function() {}) // turns off leds and buzzer if distance from the sensor is above 120 cm
		}
	}, 200)
})

/*
turnLeft.watch((err, value) => {
	if (err) 
		throw err
		
	if(!makingALeft)
		makeALeft()
	else
		clearInterval(leftTurnInterval)
})

turnRight.watch((err, value) => {
	if (err)
		throw err
	if(!makingARight)
		makeARight()
	else
		clearInterval(rightTurnInterval)
})
*/
