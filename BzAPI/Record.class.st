Class {
	#name : #Record,
	#superclass : #BaseModel,
	#instVars : [
		'channel',
		'field',
		'value',
		'createdAt'
	],
	#category : #'BzAPI-models'
}

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
Record >> value1 [
	^ value
]

{ #category : #accessing }
Record >> value: anObject [
	value := anObject
]
