Class {
	#name : #ChannelService,
	#superclass : #BaseService,
	#category : #'DingeAPI-services'
}

{ #category : #'as yet unclassified' }
ChannelService class >> findById: anId [
	^ Channel selectOne: {('_id' -> anId)} asDictionary
]
