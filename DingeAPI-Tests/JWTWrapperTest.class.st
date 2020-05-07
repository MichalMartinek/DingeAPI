"
A JWTWrapperTest is a test class for testing the behavior of JWTWrapper
"
Class {
	#name : #JWTWrapperTest,
	#superclass : #TestCase,
	#category : #'DingeAPI-Tests-utils'
}

{ #category : #tests }
JWTWrapperTest >> testData [
	| jwt payload |
	jwt := JWTWrapper
		decode: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiZW1haWxzZEBzYWQuY3oifQ.dgnr1fq-KIwXpV7UJCja-mjrFw5owhzo9s7KsNlmwQc'.
	payload := jwt data.
	self assert: (payload at: #user) equals: 'emailsd@sad.cz'
]

{ #category : #tests }
JWTWrapperTest >> testDecode [
	| jwt payload token |
	token := 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiZW1haWxzZEBzYWQuY3oifQ.dgnr1fq-KIwXpV7UJCja-mjrFw5owhzo9s7KsNlmwQc'.
	jwt := JWTWrapper
		decode: token.
	payload := jwt data.
	self assert: jwt token equals: token
]

{ #category : #tests }
JWTWrapperTest >> testEncode [
	| jwt |
	jwt := JWTWrapper
		encode:
			(JWTClaimsSet new
				at: 'user' put: 'emailsd@sad.cz').
	self assert: jwt token equals: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiZW1haWxzZEBzYWQuY3oifQ.dgnr1fq-KIwXpV7UJCja-mjrFw5owhzo9s7KsNlmwQc'.
	
]

{ #category : #tests }
JWTWrapperTest >> testJws [
	| jwt testingValue |
	testingValue := 'asd'.
	jwt := JWTWrapper
		new
		jws: testingValue.
	self assert: jwt jws equals: testingValue
]

{ #category : #tests }
JWTWrapperTest >> testToken [
	| jwt |
	jwt := JWTWrapper
		encode:
			(JWTClaimsSet new
				at: 'user' put: 'emailsd@sad.cz').
	self assert: jwt token equals: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiZW1haWxzZEBzYWQuY3oifQ.dgnr1fq-KIwXpV7UJCja-mjrFw5owhzo9s7KsNlmwQc'.
]
