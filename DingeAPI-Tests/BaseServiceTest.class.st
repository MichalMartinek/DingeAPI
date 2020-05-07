"
A BaseServiceTest is a test class for testing the behavior of BaseService
"
Class {
	#name : #BaseServiceTest,
	#superclass : #TestCase,
	#instVars : [
		'oldRepository',
		'newRepository'
	],
	#category : #'DingeAPI-Tests-services'
}

{ #category : #running }
BaseServiceTest >> setUp [
	oldRepository := VORepository current.
	newRepository := VOMongoRepository
		host: ServerSettings databaseHost
		database: 'pharoTest'.
	"newRepository := VOMemoryRepository new."
	VORepository setRepository: newRepository.
	User removeAll.
	Device removeAll.
	Channel removeAll
]

{ #category : #running }
BaseServiceTest >> tearDown [
	VORepository setRepository: oldRepository.
]
