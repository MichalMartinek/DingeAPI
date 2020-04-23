Class {
	#name : #AuthController,
	#superclass : #APIController,
	#category : #'DingeAPI-controllers'
}

{ #category : #'as yet unclassified' }
AuthController >> createToken [
	<apicontroller>
	teapot GET: '/auth' -> [ :req | self createToken: req ]
]

{ #category : #'as yet unclassified' }
AuthController >> createToken: req [
	| user parsedBody hashedPassword jwt |
	parsedBody := (NeoJSONReader on: req entity contents readStream)
		propertyNamesAsSymbols: true;
		next.
	[ hashedPassword := SHA256
		hashMessage: (parsedBody at: #password) , (parsedBody at: #email).
	user := User
		selectOne: [ :each | (each email = (parsedBody at: #email)) & (each password = hashedPassword base64Encoded) ] ]
		on: Error
		do: [ req abort: (TeaResponse code: 400) ].
	user ifNil: [ req abort: (TeaResponse code: 401) ].
	jwt := JWTWrapper
		encode: (JWTClaimsSet new at: 'user' put: (parsedBody at: #email)).
	^ jwt token
]

{ #category : #'as yet unclassified' }
AuthController >> createUser [
	<apicontroller>
	teapot GET: '/register' -> [ :req | self createUser: req ]
]

{ #category : #'as yet unclassified' }
AuthController >> createUser: req [
	| user parsedBody hashedPassword |
	parsedBody := (NeoJSONReader on: req entity contents readStream)
		propertyNamesAsSymbols: true;
		next.
	[ hashedPassword := SHA256
		hashMessage: (parsedBody at: #password) , (parsedBody at: #email).
	user := User new
		email: (parsedBody at: #email);
		password: (hashedPassword base64Encoded);
		name: (parsedBody at: #name);
		save ]
		on: KeyNotFound
		do: [ req abort: (TeaResponse code: 401) ].
	^ user
]
