"
A HealthzControllerTest is a test class for testing the behavior of HealthzController
"
Class {
	#name : #HealthzControllerTest,
	#superclass : #APIControllerTest,
	#category : #'DingeAPI-Tests-controllers'
}

{ #category : #tests }
HealthzControllerTest >> testGetStatus [
	| response |
	response := ZnClient new
		url: self baseURL , '/healthz';
		get.
	self assert: response equals: '"Healthz! API is running."'.
]
