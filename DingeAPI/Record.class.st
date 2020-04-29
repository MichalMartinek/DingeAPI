Class {
	#name : #Record,
	#superclass : #BaseModel,
	#instVars : [
		'channel',
		'field',
		'val',
		'createdAt'
	],
	#category : #'DingeAPI-models'
}

{ #category : #testing }
Record class >> isVoyageRoot [ 
	^ true
]

{ #category : #accessing }
Record >> channel [
	^ channel
]

{ #category : #accessing }
Record >> channel: anObject [
	channel := anObject
]

{ #category : #accessing }
Record >> createdAt [
	^ createdAt
]

{ #category : #accessing }
Record >> createdAt: anObject [
	createdAt := anObject
]

{ #category : #accessing }
Record >> field [
	^ field
]

{ #category : #accessing }
Record >> field: anObject [
	field := anObject
]

{ #category : #accessing }
Record >> val [
	^ val
]

{ #category : #accessing }
Record >> val: anObject [
	val := anObject
]
