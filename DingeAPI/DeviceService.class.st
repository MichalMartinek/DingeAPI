Class {
	#name : #DeviceService,
	#superclass : #BaseService,
	#category : #'DingeAPI-services'
}

{ #category : #'as yet unclassified' }
DeviceService class >> findById: anId [
	^ Device selectOne: {('_id' -> anId)} asDictionary
]
