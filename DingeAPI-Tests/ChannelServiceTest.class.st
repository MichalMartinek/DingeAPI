Class {
	#name : #ChannelServiceTest,
	#superclass : #BaseServiceTest,
	#category : #'DingeAPI-Tests-services'
}

{ #category : #'as yet unclassified' }
ChannelServiceTest >> createChannel: name [
	^ Channel new
		name: name;
		createdAt: DateAndTime now;
		updatedAt: DateAndTime now.
]

{ #category : #'as yet unclassified' }
ChannelServiceTest >> tearDown [
	super tearDown.
	Channel removeAll.
]

{ #category : #'as yet unclassified' }
ChannelServiceTest >> testFindById [
	| channel1 channel2 |
	channel1 := self createChannel:  'Smart temp 1'.
	channel2 := self createChannel: 'Smart temp 2'.
	channel1 save.
	channel2 save.
	self assert: (ChannelService findById: channel2 voyageId) equals: channel2.
]

{ #category : #'as yet unclassified' }
ChannelServiceTest >> testRemove [
	| channel1 channel2 |
	channel1 := self createChannel:  'Smart temp 1'.
	channel2 := self createChannel: 'Smart temp 2'.
	channel1 save.
	channel2 save.
	self assert: Channel selectAll size equals: 2.
	ChannelService remove: channel1.
	self assert: Channel selectAll size equals: 1.
	ChannelService remove: channel2.
	self assert: Channel selectAll size equals: 0.
]

{ #category : #'as yet unclassified' }
ChannelServiceTest >> testSave [
	| channel |
	channel := self createChannel: 'Smart temp'.
	ChannelService save: channel.
	self deny: channel voyageId value asString isEmpty.
	self assert: Channel selectAll size equals: 1.
	self assert: Channel selectAll any name equals: channel name.
]
