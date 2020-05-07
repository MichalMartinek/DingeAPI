"
A ChannelTest is a test class for testing the behavior of Channel
"
Class {
	#name : #ChannelTest,
	#superclass : #TestCase,
	#category : #'DingeAPI-Tests-models'
}

{ #category : #tests }
ChannelTest >> testAddRecord [
	| channel rec1 rec2 |
	channel := Channel new.
	rec1 := Record new
		field: 'temp';
		val: 'val1'.
	rec2 := Record new
		field: 'temp';
		val: 'val2'.
	channel addRecord: rec1.
	self
		assert: channel records
		equals:
			(LinkedList new
				add: rec1;
				yourself).
	channel addRecord: rec2.
	self
		assert: channel records
		equals:
			(LinkedList new
				add: rec1;
				add: rec2;
				yourself)
]

{ #category : #tests }
ChannelTest >> testAddUser [
	| channel user |
	channel := Channel new.
	user := User new name: 'Vladimir Putin'.
	channel addUser: user.
	self
		assert: channel users
		equals:
			(Set new
				add: user;
				yourself)
]
