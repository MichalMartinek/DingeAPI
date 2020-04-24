Class {
	#name : #CryptoUtils,
	#superclass : #Object,
	#category : #'DingeAPI-utils'
}

{ #category : #utils }
CryptoUtils class >> hash: aPassword with: aSalt [
	| hashedPassword |
	hashedPassword := SHA256 hashMessage: aPassword , aSalt.
	^ hashedPassword base64Encoded
]
