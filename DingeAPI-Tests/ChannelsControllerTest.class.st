"
A ChannelsControllerTest is a test class for testing the behavior of ChannelsController
"
Class {
	#name : #ChannelsControllerTest,
	#superclass : #AuthedControllerTest,
	#category : #'DingeAPI-Tests-controllers'
}

{ #category : #tests }
ChannelsControllerTest >> testCreate [
	| jwtToken createResponse currentUser |
	jwtToken := self prepareAuthToken.
	createResponse := ZnClient new
		url: self baseURL , '/api/channels';
		headerAt: 'Authorization' put: jwtToken;
		contents: '{	"name": "Channel 1"}';
		post;
		response.
	self assert: createResponse code equals: 201.
	currentUser := self userProfile: jwtToken.
	self assert: (currentUser at: #channels) size equals: 1.
	self
		assert: ((currentUser at: #channels) first at: #name)
		equals: 'Channel 1'.
]

{ #category : #tests }
ChannelsControllerTest >> testDelete [
	| jwtToken createResponse currentUser deleteResponse nonExistingDeleteResponse |
	jwtToken := self prepareAuthToken.
	createResponse := ZnClient new
		url: self baseURL , '/api/channels';
		headerAt: 'Authorization' put: jwtToken;
		contents: '{	"name": "Channel 1"}';
		post;
		response.
	self assert: createResponse code equals: 201.
	currentUser := self userProfile: jwtToken.
	self assert: (currentUser at: #channels) size equals: 1.
	deleteResponse := ZnClient new
		url:
			self baseURL , '/api/channels/'
				, ((currentUser at: #channels) first at: #id) asString;
		headerAt: 'Authorization' put: jwtToken;
		delete;
		response.
	self assert: deleteResponse code equals: 204.
	currentUser := self userProfile: jwtToken.
	self assert: (currentUser at: #channels) size equals: 0.
	nonExistingDeleteResponse := ZnClient new
		url: self baseURL , '/api/channels/346';
		headerAt: 'Authorization' put: jwtToken;
		delete;
		response.
	self assert: nonExistingDeleteResponse code equals: 400
]

{ #category : #tests }
ChannelsControllerTest >> testEdit [
	| jwtToken createResponse currentUser editResponse nonExistingEditResponse |
	jwtToken := self prepareAuthToken.
	createResponse := ZnClient new
		url: self baseURL , '/api/channels';
		headerAt: 'Authorization' put: jwtToken;
		contents: '{	"name": "Channel 1"}';
		post;
		response.
	self assert: createResponse code equals: 201.
	currentUser := self userProfile: jwtToken.
	self assert: (currentUser at: #channels) size equals: 1.
	editResponse := ZnClient new
		url:
			self baseURL , '/api/channels/'
				, ((currentUser at: #channels) first at: #id) asString;
		headerAt: 'Authorization' put: jwtToken;
		contents: '{	"name": "Channel edited"}';
		put;
		response.
	self assert: editResponse code equals: 200.
	currentUser := self userProfile: jwtToken.
	self assert: (currentUser at: #channels) size equals: 1.
	self
		assert: ((currentUser at: #channels) first at: #name)
		equals: 'Channel edited'.
	nonExistingEditResponse := ZnClient new
		url: self baseURL , '/api/channels/123';
		headerAt: 'Authorization' put: jwtToken;
		contents: '{	"name": "Channel edited"}';
		put;
		response.
	self assert: nonExistingEditResponse code equals: 400
]
