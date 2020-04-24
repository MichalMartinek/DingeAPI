Class {
	#name : #JWTWrapper,
	#superclass : #Object,
	#instVars : [
		'jws'
	],
	#category : #'DingeAPI-utils'
}

{ #category : #converting }
JWTWrapper class >> decode: aTokenString [
	| jws |
	jws := JsonWebSignature
		materializeCompact: aTokenString
		key: ServerSettings jwtKey.
	^ self new jws: jws
]

{ #category : #converting }
JWTWrapper class >> encode: aPayload [
	| jws |
	jws := JsonWebSignature new
		algorithmName: 'HS256';
		payload: aPayload.
	jws key: ServerSettings jwtKey.
	^ self new jws: jws
]

{ #category : #accessing }
JWTWrapper >> data [ 
	^ jws payload
]

{ #category : #accessing }
JWTWrapper >> jws [
	^ jws
]

{ #category : #accessing }
JWTWrapper >> jws: anObject [
	jws := anObject
]

{ #category : #accessing }
JWTWrapper >> token [ 
	^ jws compactSerialized
]
