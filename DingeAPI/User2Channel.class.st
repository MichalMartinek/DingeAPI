Class {
	#name : #User2Channel,
	#superclass : #BaseModel,
	#instVars : [
		'channel',
		'access',
		'user'
	],
	#category : #'DingeAPI-models'
}

{ #category : #accessing }
User2Channel >> access [
	^ access
]

{ #category : #accessing }
User2Channel >> access: anObject [
	access := anObject
]

{ #category : #accessing }
User2Channel >> channel [
	^ channel
]

{ #category : #accessing }
User2Channel >> channel: anObject [
	channel := anObject
]

{ #category : #accessing }
User2Channel >> user [
	^ user
]

{ #category : #accessing }
User2Channel >> user: anObject [
	user := anObject
]
