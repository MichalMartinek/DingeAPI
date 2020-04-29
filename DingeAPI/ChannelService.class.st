Class {
	#name : #ChannelService,
	#superclass : #Object,
	#category : #'DingeAPI-services'
}

{ #category : #'as yet unclassified' }
ChannelService class >> findById: anId [
	^ Channel selectOne: {('_id' -> anId)} asDictionary
]

{ #category : #'as yet unclassified' }
ChannelService class >> saveChannel: aChannel [
	aChannel save
]
