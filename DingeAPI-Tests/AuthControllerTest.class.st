"
An AuthControllerTest is a test class for testing the behavior of AuthController
"
Class {
	#name : #AuthControllerTest,
	#superclass : #AuthedControllerTest,
	#category : #'DingeAPI-Tests-controllers'
}

{ #category : #tests }
AuthControllerTest >> testAddDevice [
	| jwtToken addDeviceResponse currentUserResponse currentUser addAnotherDeviceResponse |
	jwtToken := self prepareAuthToken.
	addDeviceResponse := ZnClient new
		url: self baseURL , '/api/devices';
		headerAt: 'Authorization' put: jwtToken;
		contents: '{	"name": "ESP8266 - garden"}';
		post;
		response.
	self assert: addDeviceResponse code equals: 200.
	currentUser := self userProfile: jwtToken.
	self
		assert: ((currentUser at: #devices) first at: #name)
		equals: 'ESP8266 - garden'.
	addAnotherDeviceResponse := ZnClient new
		url: self baseURL , '/api/devices';
		headerAt: 'Authorization' put: jwtToken;
		contents: '{	"name": "ESP8266 - garden 2"}';
		post;
		response.
	self assert: addAnotherDeviceResponse code equals: 200.
	currentUser := self userProfile: jwtToken.
	self assert: (currentUser at: #devices) size equals: 2
]

{ #category : #tests }
AuthControllerTest >> testGetCurrentUser [
	| jwtToken unauthorizedUserResponse currentUser |
	jwtToken := self prepareAuthToken.
	unauthorizedUserResponse := ZnClient new
		url: self baseURL , '/api/user';
		get;
		response.
	self assert: unauthorizedUserResponse code equals: 401.
	currentUser := self userProfile: jwtToken.
	self assert: (currentUser at: #email) equals: 'tester1@windy.com'.
	self assert: (currentUser at: #name) equals: 'tester1'.
]

{ #category : #tests }
AuthControllerTest >> testLogin [
	| registerResponse loginResponse failingLoginResponse invalidLoginResponse |
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
	self deny: loginResponse contents isEmpty.
	
	invalidLoginResponse := ZnClient new
		url: self baseURL , '/auth';
		contents:
			'{	"email": "tester1@windy.com"}';
		post;
		response.
	self assert: invalidLoginResponse code equals: 400.
	
	failingLoginResponse := ZnClient new
		url: self baseURL , '/auth';
		contents:
			'{	"email": "tester1@windy.com",	"password": "invalidPassword"}';
		post;
		response.
	self assert: failingLoginResponse code equals: 401.
]

{ #category : #tests }
AuthControllerTest >> testRegister [
	| response |
	response := ZnClient new
		url: self baseURL , '/register';
		contents:
			'{	"email": "tester1@windy.com", "name": "tester1",	"password": "tester1passw"}';
		post;
		response.
	self assert: response code equals: 201
]

{ #category : #tests }
AuthControllerTest >> testRemoveDevice [
	| jwtToken addDeviceResponse currentUser removeDeviceResponse removeNonExistingDeviceResponse |
	jwtToken := self prepareAuthToken.
	addDeviceResponse := ZnClient new
		url: self baseURL , '/api/devices';
		headerAt: 'Authorization' put: jwtToken;
		contents: '{	"name": "ESP8266 - garden"}';
		post;
		response.
	self assert: addDeviceResponse code equals: 200.
	currentUser := self userProfile: jwtToken.
	self assert: (currentUser at: #devices) size equals: 1.
	removeDeviceResponse := ZnClient new
		url:
			self baseURL , '/api/devices/'
				, ((currentUser at: #devices) first at: #id) asString;
		headerAt: 'Authorization' put: jwtToken;
		delete;
		response.
	self assert: removeDeviceResponse code equals: 204.
	removeNonExistingDeviceResponse := ZnClient new
		url: self baseURL , '/api/devices/12345';
		headerAt: 'Authorization' put: jwtToken;
		delete;
		response.
	self assert: removeNonExistingDeviceResponse code equals: 400.
	currentUser := self userProfile: jwtToken.
	self assert: (currentUser at: #devices) size equals: 0
]
