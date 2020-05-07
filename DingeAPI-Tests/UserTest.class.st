"
An UserTest is a test class for testing the behavior of User
"
Class {
	#name : #UserTest,
	#superclass : #TestCase,
	#category : #'DingeAPI-Tests-models'
}

{ #category : #tests }
UserTest >> testAddChannel [
	| user channel |
	user := User new.
	channel := Channel new name: 'awesome channel'.
	user addChannel: channel.
	self
		assert: user channels
		equals:
			(Set new
				add: channel;
				yourself)
]

{ #category : #tests }
UserTest >> testAddDevice [
	| user device |
	user := User new.
	device := Device new name: 'awesome device'.
	user addDevice: device.
	self
		assert: user devices
		equals:
			(Set new
				add: device;
				yourself)
]

{ #category : #tests }
UserTest >> testEmail [
	| user |
	user := User new.
	self should: [ user email: 'invalidmail' ] raise: Error.
	self should: [ user email: 'invalidmail@sdsa' ] raise: Error.
	user email: 'validmail@sdsa.cz'.
	self assert: user email equals: 'validmail@sdsa.cz'.
]

{ #category : #tests }
UserTest >> testRemoveChannel [
	| user channel |
	user := User new.
	channel := Channel new name: 'awesome channel'.
	user addChannel: channel.
	self
		assert: user channels
		equals:
			(Set new
				add: channel;
				yourself).
	user removeChannel: channel.
	self assert: user channels equals: Set new
]

{ #category : #tests }
UserTest >> testRemoveDevice [
	| user device |
	user := User new.
	device := Channel new name: 'awesome device'.
	user addDevice: device.
	self
		assert: user devices
		equals:
			(Set new
				add: device;
				yourself).
	user removeDevice: device.
	self assert: user devices equals: Set new
]
