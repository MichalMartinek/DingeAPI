Class {
	#name : #Authenticator,
	#superclass : #Object,
	#category : #'DingeAPI-server'
}

{ #category : #'as yet unclassified' }
Authenticator class >> checkRequest: req [
	[ JWTWrapper decode: req authorization ]
		on: Error
		do: [ req abort: (TeaResponse code: 401) ]
]

{ #category : #'as yet unclassified' }
Authenticator class >> getUser: req [
	| payload jwt |
	jwt := JWTWrapper decode: req authorization.
	payload := jwt data.
	^ UserService findUserByEmail: (payload at: #user)
]
