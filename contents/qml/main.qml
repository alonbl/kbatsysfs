import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore
import "plasmapackage:/code/main.js" as BAT

Item {
	id: mainItem

	Image {
		id: batteryImage0
		anchors.fill: parent
		fillMode: Image.PreserveAspectFit
		source: "plasmapackage:/images/0%.png"
		visible: false
	}
	Image {
		id: batteryImage20
		anchors.fill: parent
		fillMode: Image.PreserveAspectFit
		source: "plasmapackage:/images/20%.png"
		visible: false
	}
	Image {
		id: batteryImage40
		anchors.fill: parent
		fillMode: Image.PreserveAspectFit
		source: "plasmapackage:/images/40%.png"
		visible: false
	}
	Image {
		id: batteryImage60
		anchors.fill: parent
		fillMode: Image.PreserveAspectFit
		source: "plasmapackage:/images/60%.png"
		visible: false
	}
	Image {
		id: batteryImage80
		anchors.fill: parent
		fillMode: Image.PreserveAspectFit
		source: "plasmapackage:/images/80%.png"
		visible: false
	}
	Image {
		id: batteryImage100
		anchors.fill: parent
		fillMode: Image.PreserveAspectFit
		source: "plasmapackage:/images/100%.png"
		visible: false
	}
	Image {
		id: powerImage
		z: 1
		width: batteryImage0.width
		height: batteryImage0.height * 0.60
		anchors.bottom: batteryImage0.bottom
		fillMode: Image.PreserveAspectFit
		visible: false
		source: "plasmapackage:/images/power.png"
	}

	PlasmaCore.ToolTip {
		id: toolTip
		target: mainItem
		mainText: "Battery"
		subText: ""
	}

	Timer {
		id: timer
		repeat: true
		interval: 1000
		onTriggered: { BAT.poll() }
	}

	Component.onCompleted: { BAT.initialize() }
}
