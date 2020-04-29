Class {
	#name : #RecordService,
	#superclass : #Object,
	#category : #'DingeAPI-services'
}

{ #category : #'as yet unclassified' }
RecordService class >> findByChannelId: aChannelId [
	^ Record selectMany: [ :each | each channel = aChannelId ].
]

{ #category : #'as yet unclassified' }
RecordService class >> findById: anId [
	^ Record selectOne: {('_id' -> anId)} asDictionary
]

{ #category : #'as yet unclassified' }
RecordService class >> saveRecord: aRecord [
	aRecord save
]
