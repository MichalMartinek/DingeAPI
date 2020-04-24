Class {
	#name : #User,
	#superclass : #BaseModel,
	#instVars : [
		'name',
		'password',
		'email'
	],
	#category : #'DingeAPI-models'
}

{ #category : #testing }
User class >> isVoyageRoot [ 
	^ true
]

{ #category : #accessing }
User >> email [
	^ email
]

{ #category : #accessing }
User >> email: anEmail [
	(anEmail matchesRegex: '[A-z]+@[A-z]+\.[A-z]+')
		ifFalse: [ self error: 'Invalid email' ].
	email := anEmail
]

{ #category : #accessing }
User >> name [
	^ name
]

{ #category : #accessing }
User >> name: anObject [
	name := anObject
]

{ #category : #accessing }
User >> password [
	^ password
]

{ #category : #accessing }
User >> password: anObject [
	password := anObject
]
