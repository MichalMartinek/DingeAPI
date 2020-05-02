Class {
	#name : #AuthController,
	#superclass : #APIController,
	#category : #'DingeAPI-controllers'
}

{ #category : #'as yet unclassified' }
AuthController >> addDevice [
	<apicontroller>
	teapot POST: '/api/devices' -> [ :req | self addDevice: req ]
]

{ #category : #accessing }
AuthController >> addDevice: req [
	| user parsedBody device jwt |
	parsedBody := req parseJSONBody.
	[ user := Authenticator getUser: req.
	device := Device new
		name: (parsedBody at: #name);
		user: user;
		createdAt: DateAndTime now.
	DeviceService save: device.
	user addDevice: device.
	UserService save: user ]
		on: Error
		do: [ :err | 
			req
				abort:
					(TeaResponse new
						code: 400;
						body: err messageText).
			^ nil ].
	jwt := JWTWrapper
		encode:
			(JWTClaimsSet new
				at: 'user' put: user email;
				at: 'dev' put: device voyageId value asString).
	^ jwt token
]

{ #category : #'as yet unclassified' }
AuthController >> getCurrentUser [
	<apicontroller>
	teapot GET: '/api/user' -> [ :req | self getCurrentUser: req ]
]

{ #category : #'as yet unclassified' }
AuthController >> getCurrentUser: req [
	^ Authenticator getUser: req
]

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

{ #category : #'as yet unclassified' }
AuthController >> removeDevice [
	<apicontroller>
	teapot DELETE: '/api/devices/<id>' -> [ :req | self removeDevice: req ]
]

{ #category : #'as yet unclassified' }
AuthController >> removeDevice: req [
	| user oid device |
	[ user := Authenticator getUser: req.
	oid := OID value: (req at: #id) asNumber.
	device := DeviceService findById: oid.
	device
		ifNil: [ req abort: TeaResponse notFound.
			^ nil ].
	device user removeDevice: device.
	UserService save: device user.
	DeviceService remove: device ]
		on: Error
		do: [ :err | 
			req
				abort:
					(TeaResponse new
						code: 400;
						body: err messageText).
			^ nil ].
	^ TeaResponse code: 204
]
