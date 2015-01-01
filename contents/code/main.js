var BASE = '/sys/class/power_supply';

function initialize() {
	plasmoid.globals = {}
	plasmoid.globals.lastPower = null
	plasmoid.globals.lastSample = -1
	plasmoid.globals.lastImage = 0
	plasmoid.globals.batteryImages = []
	for (i=0;i<=100;i+=20) {
		plasmoid.globals.batteryImages[i] = eval('batteryImage' + i);
	}
	plasmoid.addEventListener('ConfigChanged', configChanged)
}

function configChanged() {
	timer.running = false
	plasmoid.globals.base = BASE + '/' + plasmoid.readConfig("batteryName")
	timer.interval = Number(plasmoid.readConfig("pollinterval")) * 1000
	timer.running = true
}

function poll() {
	var job1 = plasmoid.getUrl(plasmoid.globals.base + '/capacity');
	job1.mydata = '';
	job1.data.connect(
		job1,
		function(job, data) {
			if(data.length > 0) {
				this.mydata += new String(data.valueOf());
			}
		}
	);
	job1.finished.connect(
		job1,
		function(job) {
			sample = Number(this.mydata)
			if (sample != plasmoid.globals.lastSample) {
				toolTip.subText = sample + '%';
				image = sample - (sample % 20)
				plasmoid.globals.batteryImages[plasmoid.globals.lastImage].visible = false
				plasmoid.globals.batteryImages[image].visible = true
				plasmoid.globals.lastSample = sample
				plasmoid.globals.lastImage = image
			}
		}
	);

	var job2 = plasmoid.getUrl(plasmoid.globals.base + '/status');
	job2.mydata = '';
	job2.data.connect(
		job2,
		function(job, data) {
			if(data.length > 0) {
				this.mydata += new String(data.valueOf());
			}
		}
	);
	job2.finished.connect(
		job2,
		function(job) {
			var power = true;
			if (this.mydata == 'Discharging\n') {
				power = false;
			}
			if (plasmoid.globals.lastPower != power) {
				plasmoid.globals.lastPower = power;
				powerImage.visible = power;
				for (i in plasmoid.globals.batteryImages) {
					plasmoid.globals.batteryImages[i].opacity = power ? 0.5 : 1;
				}
			}
		}
	);
}
