Class {
	#name : #ServerSettings,
	#superclass : #Object,
	#category : #'DingeAPI-server'
}

{ #category : #'as yet unclassified' }
ServerSettings class >> databaseCollection [
	^ 'pharo'
]

{ #category : #'as yet unclassified' }
ServerSettings class >> databaseHost [
	^ 'localhost'
]

{ #category : #'as yet unclassified' }
ServerSettings class >> jwtKey [
	^ 'This is JWT key.'
]

{ #category : #'as yet unclassified' }
ServerSettings class >> serverPort [
	^ 8080
]
