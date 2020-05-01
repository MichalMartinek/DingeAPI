Class {
	#name : #Record,
	#superclass : #BaseModel,
	#instVars : [
		'field',
		'val',
		'createdAt'
	],
	#category : #'DingeAPI-models'
}

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
