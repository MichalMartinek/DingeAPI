Class {
	#name : #DeviceServiceTest,
	#superclass : #BaseServiceTest,
	#category : #'DingeAPI-Tests-services'
}

{ #category : #tests }
DeviceServiceTest >> createDevice: name [
	^ Device new
		name: name;
		createdAt: DateAndTime now.
]

{ #category : #tests }
DeviceServiceTest >> testFindById [
	| device1 device2 |
	device1 := self createDevice: 'ESP8266 - garden 1'.
	device2 := self createDevice: 'ESP8266 - garden 2'.
	device1 save.
	device2 save.
	self assert: (DeviceService findById: device2 voyageId) equals: device2.
]

{ #category : #tests }
DeviceServiceTest >> testRemove [
	| device1 device2 |
	device1 := self createDevice: 'ESP8266 - garden 1'.
	device2 := self createDevice: 'ESP8266 - garden 2'.
	device1 save.
	device2 save.
	self assert: Device selectAll size equals: 2.
	DeviceService remove: device1.
	self assert: Device selectAll size equals: 1.
	DeviceService remove: device2.
	self assert: Device selectAll size equals: 0.
]

{ #category : #tests }
DeviceServiceTest >> testSave [
	| device |
	device := self createDevice: 'ESP8266 - garden 1'.
	DeviceService save: device.
	self deny: device voyageId value asString isEmpty.
	self assert: Device selectAll size equals: 1.
	self assert: Device selectAll any name equals: device name.
]
