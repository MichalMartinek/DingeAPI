Class {
	#name : #APIControllerTest,
	#superclass : #TestCase,
	#instVars : [
		'oldRepository',
		'newRepository',
		'server'
	],
	#category : #'DingeAPI-Tests-controllers'
}

{ #category : #accessing }
APIControllerTest >> baseURL [
	^ 'http://localhost:', ServerSettings serverPort asString 
]

{ #category : #accessing }
APIControllerTest >> setUp [
	server := DingeAPIServer start.
	oldRepository := VORepository current.
	newRepository := VOMongoRepository
		host: ServerSettings databaseHost
		database: 'pharoTest'.
	"newRepository := VOMemoryRepository new."
	VORepository setRepository: newRepository.
	User removeAll.
	Device removeAll.
	Channel removeAll.
]

{ #category : #accessing }
APIControllerTest >> tearDown [
	VORepository setRepository: oldRepository.
	server stop.
]
