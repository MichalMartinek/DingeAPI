Class {
	#name : #AuthController,
	#superclass : #APIController,
	#category : #'DingeAPI-controllers'
}

{ #category : #'as yet unclassified' }
AuthController >> login [
	<apicontroller>
	teapot POST: '/auth' -> [ :req | self login: req ]
]

{ #category : #accessing }
AuthController >> login: req [
	| user parsedBody hashedPassword jwt |
	parsedBody := req parseJSONBody.
	[ hashedPassword := CryptoUtils
		hash: (parsedBody at: #password)
		with: (parsedBody at: #email).
	user := UserService
		findUserByEmail: (parsedBody at: #email)
		andPassword: hashedPassword ]
		on: Error
		do: [ :err | 
			req abort: TeaResponse badRequest.
			^ nil ].
	user
		ifNil: [ req abort: TeaResponse unauthorized.
			^ nil ].
	jwt := JWTWrapper
		encode: (JWTClaimsSet new at: 'user' put: (parsedBody at: #email)).
	^ jwt token
]

{ #category : #'as yet unclassified' }
AuthController >> register [
	<apicontroller>
	teapot POST: '/register' -> [ :req | self register: req ]
]

{ #category : #accessing }
AuthController >> register: req [
	| user parsedBody hashedPassword |
	parsedBody := req parseJSONBody.
	[ hashedPassword := CryptoUtils
		hash: (parsedBody at: #password)
		with: (parsedBody at: #email).
	user := User new
		email: (parsedBody at: #email);
		password: hashedPassword;
		name: (parsedBody at: #name).
	UserService saveAsNew: user ]
		on: Error
		do: [ :err | 
			req
				abort:
					(TeaResponse new
						code: 400;
						body: err messageText).
			^ nil ].
	^ TeaResponse created
]
