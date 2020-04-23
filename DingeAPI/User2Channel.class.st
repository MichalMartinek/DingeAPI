Class {
	#name : #User2Channel,
	#superclass : #BaseModel,
	#instVars : [
		'channel',
		'user'
	],
	#category : #'DingeAPI-models'
}

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
