Class {
	#name : #APIController,
	#superclass : #Object,
	#instVars : [
		'session',
		'teapot'
	],
	#category : #'BzAPI-controllers'
}

{ #category : #accessing }
APIController >> session: anObject [
	session := anObject
]

{ #category : #accessing }
APIController >> teapot: anObject [
	teapot := anObject
]
