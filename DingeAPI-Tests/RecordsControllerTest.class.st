"
A RecordsControllerTest is a test class for testing the behavior of RecordsController
"
Class {
	#name : #RecordsControllerTest,
	#superclass : #AuthedControllerTest,
	#category : #'DingeAPI-Tests-controllers'
}

{ #category : #tests }
RecordsControllerTest >> testCreate [
	| jwtToken createResponse currentUser recordsEndpoint createRecordResponse parsedBody |
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
	recordsEndpoint := self baseURL , '/api/channels/'
		, ((currentUser at: #channels) first at: #id) asString , '/records'.
	createRecordResponse := ZnClient new
		url: recordsEndpoint;
		headerAt: 'Authorization' put: jwtToken;
		contents: '{	"field": "temp", "value": 15.64235455}';
		post;
		response.
	parsedBody := (NeoJSONReader
		on: createRecordResponse contents readStream)
		propertyNamesAsSymbols: true;
		next.
	self assert: createRecordResponse code equals: 200.
	self assert: parsedBody size equals: 1.
	self assert: (parsedBody first at: #field) equals: 'temp'.
	self assert: (parsedBody first at: #val) equals: 15.64235455
]

{ #category : #tests }
RecordsControllerTest >> testListAll [
	| jwtToken createResponse currentUser recordsEndpoint createRecordResponse parsedBody listRecordsResponse createAnotherRecordResponse nonExistingListRecordsResponse |
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
	recordsEndpoint := self baseURL , '/api/channels/'
		, ((currentUser at: #channels) first at: #id) asString , '/records'.
	createRecordResponse := ZnClient new
		url: recordsEndpoint;
		headerAt: 'Authorization' put: jwtToken;
		contents: '{	"field": "temp", "value": 15.64235455}';
		post;
		response.
	self assert: createRecordResponse code equals: 200.
	createAnotherRecordResponse := ZnClient new
		url: recordsEndpoint;
		headerAt: 'Authorization' put: jwtToken;
		contents: '{	"field": "temp", "value": 18}';
		post;
		response.
	self assert: createAnotherRecordResponse code equals: 200.
	listRecordsResponse := ZnClient new
		url: recordsEndpoint;
		headerAt: 'Authorization' put: jwtToken;
		get;
		response.
	parsedBody := (NeoJSONReader
		on: listRecordsResponse contents readStream)
		propertyNamesAsSymbols: true;
		next.
	self assert: listRecordsResponse code equals: 200.
	self assert: parsedBody size equals: 2.
	self assert: (parsedBody first at: #field) equals: 'temp'.
	self assert: (parsedBody first at: #val) equals: 15.64235455.
	self assert: (parsedBody second at: #field) equals: 'temp'.
	self assert: (parsedBody second at: #val) equals: 18.
	nonExistingListRecordsResponse := ZnClient new
		url: self baseURL, '/channels/123/records';
		headerAt: 'Authorization' put: jwtToken;
		get;
		response.
	self assert: nonExistingListRecordsResponse code equals: 404.
]
