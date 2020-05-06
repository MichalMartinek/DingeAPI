Class {
	#name : #AuthedControllerTest,
	#superclass : #APIControllerTest,
	#category : #'DingeAPI-Tests-controllers'
}

{ #category : #tests }
AuthedControllerTest >> prepareAuthToken [
	| registerResponse loginResponse token |
	registerResponse := ZnClient new
		url: self baseURL , '/register';
		contents:
			'{	"email": "tester1@windy.com", "name": "tester1",	"password": "tester1passw"}';
		post;
		response.
	self assert: registerResponse code equals: 201.
	loginResponse := ZnClient new
		url: self baseURL , '/auth';
		contents:
			'{	"email": "tester1@windy.com",	"password": "tester1passw"}';
		post;
		response.
	self assert: loginResponse code equals: 200.
	token := loginResponse contents.
	^ token copyFrom: 2 to: token size - 1
]

{ #category : #tests }
AuthedControllerTest >> userProfile: jwtToken [
	| currentUserResponse currentUser |
	currentUserResponse := ZnClient new
		url: self baseURL , '/api/user';
		headerAt: 'Authorization' put: jwtToken;
		get;
		response.
	self assert: currentUserResponse code equals: 200.
	currentUser := (NeoJSONReader
		on: currentUserResponse contents readStream)
		propertyNamesAsSymbols: true;
		next.
	^ currentUser
]
