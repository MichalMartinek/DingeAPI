Class {
	#name : #Channel,
	#superclass : #BaseModel,
	#instVars : [
		'name',
		'createdAt'
	],
	#category : #'BzAPI-models'
}

{ #category : #testing }
Channel class >> isVoyageRoot [ 
	^ true
]

{ #category : #accessing }
Channel >> createdAt [
	^ createdAt
]

{ #category : #accessing }
Channel >> createdAt: anObject [
	createdAt := anObject
]

{ #category : #accessing }
Channel >> name [
	^ name
]

{ #category : #accessing }
Channel >> name: anObject [
	name := anObject
]
