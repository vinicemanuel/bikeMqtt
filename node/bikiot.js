let Gpio = require('onoff').Gpio
let mqtt = require('mqtt')
let usonic = require('mmm-usonic')

let client = mqtt.connect('mqtt://broker.hivemq.com')

let rotation = new Gpio(4, 'in', 'falling', {debounceTimeout: 10})
//let turnLeft = new Gpio(26, 'in', 'both', {debounceTimeout: 10})
//let turnRight = new Gpio(27, 'in', 'both', {debounceTimeout: 10})
//let ledLeft = new Gpio(24, 'out')
//let ledRight = new Gpio(23, 'out')
let led = new Gpio(17, 'out')

let vcc = new Gpio(18, 'out')
vcc.write(1, function() {})

let counter = 0
//let makingALeft = false
//let makingARight = false
let resposta = {}

//let leftTurnInterval, rightTurnInterval
let mqttInterval = setInterval(function(){sendMqtt();}, 2000)

function sendMqtt() {
	resposta.counter = counter
	resposta.timestamp = new Date()
	counter = 0
	console.log(resposta)
	client.publish('bikeiot', JSON.stringify(resposta))
}

function makeALeft(){
	makingALeft = true
	makingARight = false
	leftTurnInterval = setInterval(function(){
		if(ledLeft.readSync())
			ledLeft.write(0, function() {})
		else
			ledLeft.write(1, function() {})
	}, 500)
}

function makeARight(){
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

rotation.watch((err, value) => {
	if (err) 
		throw err
	counter++
})

usonic.init(function (error) {
	if (error) {
		console.log(error)
		return
	}
	let sensor = usonic.createSensor(21, 20, 1000)
	setInterval(function() {
		if(sensor().toFixed(2) < 120){
			led.write(1, function() {})
		} else {
			led.write(0, function(){})
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
