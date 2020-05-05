"
A BaseServiceTest is a test class for testing the behavior of BaseService
"
Class {
	#name : #BaseServiceTest,
	#superclass : #TestCase,
	#instVars : [
		'oldRepository'
	],
	#category : #'DingeAPI-Tests-services'
}

{ #category : #running }
BaseServiceTest >> setUp [
	oldRepository := VORepository current.
	VORepository setRepository: VOMemoryRepository new.
]

{ #category : #running }
BaseServiceTest >> tearDown [
	VORepository setRepository: oldRepository.
]
