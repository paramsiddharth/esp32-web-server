const ssid     = 'SSID_HERE';
const password = 'PSWD_HERE';
const port     = 80;

const led = 2; // Or D2 or new Pin(2) or Pin(2)
let ledState = false;
const count = 10;
const duration = 50;

function onInit() {
	const wifi = require('Wifi');

	const blink = () => {
		ledState = !ledState;
		digitalWrite(led, ledState);
	};

	const blinkTimes = count => {
		if (count > 0) {
			blink();
			setTimeout(() => blinkTimes(count - 1), duration);
		}
	};

	const processRequest = (req, res) => {
		blinkTimes(4);
		const a = url.parse(req.url, true);
		let msg = 'Hello, World!'
		if (a.query && 'name' in a.query) {
			msg = 'Hello, ' + a.query.name + '!';
		}
		res.writeHead(200);
		res.end(msg);
	};

	digitalWrite(led, ledState);
	console.log('Connecting...');

	wifi.connect(ssid, { password: password }, () => {
		blinkTimes(count);
		console.log('Connected to Wi-Fi.');
		
		const http = require('http');
		const server = http.createServer(processRequest).listen(port);

		console.log(`Server running on http://${wifi.getIP().ip}${port === 80 ? '' : (':' + port)}/`);
	});
}