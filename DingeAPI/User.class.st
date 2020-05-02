Class {
	#name : #User,
	#superclass : #BaseModel,
	#instVars : [
		'name',
		'password',
		'email',
		'channels',
		'devices'
	],
	#category : #'DingeAPI-models'
}

{ #category : #testing }
User class >> isVoyageRoot [ 
	^ true
]

{ #category : #testing }
User class >> neoJsonMapping: mapper [
	mapper
		for: self
		do: [ :mapping | 
			mapping
				mapInstVars: #(#name #email #devices #channels);
				mapAccessor: #voyageId to: #id ]
]

{ #category : #accessing }
User >> addChannel: aChannel [ 
   self channels add: aChannel
]

{ #category : #accessing }
User >> addDevice: aDevice [ 
   self devices add: aDevice
]

{ #category : #accessing }
User >> channels [
   ^ channels ifNil: [ channels := Set new ]
]

{ #category : #accessing }
User >> devices [
   ^ devices ifNil: [ devices := Set new ]
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

{ #category : #accessing }
User >> removeChannel: aChannel [ 
   self channels remove: aChannel
]

{ #category : #accessing }
User >> removeDevice: aDevice [ 
   self devices remove: aDevice
]
