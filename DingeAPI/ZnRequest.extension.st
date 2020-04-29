Extension { #name : #ZnRequest }

{ #category : #'*DingeAPI' }
ZnRequest >> getUser [
	| payload jwt |
	jwt := JWTWrapper decode: self authorization.
	payload := jwt data.
	^ UserService findUserByEmail: (payload at: #user)
]
