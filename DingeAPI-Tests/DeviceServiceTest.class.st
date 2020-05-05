Class {
	#name : #DeviceServiceTest,
	#superclass : #BaseServiceTest,
	#category : #'DingeAPI-Tests-services'
}

{ #category : #tests }
DeviceServiceTest >> testSave [
	| device |
	device := Device new
		name: 'ESP8266 - garden 1';
		createdAt: DateAndTime now.
	DeviceService save: device.
	self assert: device voyageId value asString size > 0.
]
