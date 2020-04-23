Class {
	#name : #AuthController,
	#superclass : #APIController,
	#category : #'DingeAPI-controllers'
}

{ #category : #'as yet unclassified' }
AuthController >> createtoken [
	<apicontroller>
	| jwt |
	teapot
		GET:
			'/auth'
				-> [ :req | 
					jwt := JWTWrapper encode: (JWTClaimsSet new at: 'bar' put: 'foo').
					jwt token ]
]
