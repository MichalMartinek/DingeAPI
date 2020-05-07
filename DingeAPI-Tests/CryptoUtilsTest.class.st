"
A CryptoUtilsTest is a test class for testing the behavior of CryptoUtils
"
Class {
	#name : #CryptoUtilsTest,
	#superclass : #TestCase,
	#category : #'DingeAPI-Tests-utils'
}

{ #category : #tests }
CryptoUtilsTest >> testHashWith [
	| hash1 hash2 |
	hash1 := CryptoUtils hash: 'password' with: 'userSalt'.
	hash2 := CryptoUtils hash: 'complecetedPasword' with: '123o31pi2kds,.'.
	self assert: hash1 equals: 'ArAYbdVa7gU+A8pPWgkXNdZ8jkBrKLGMgcAlDcGzLS4='.
	self assert: hash2 equals: 'LAnp++JXrdfKG6QI4jmNlSOLgHZXL5AQl5fMPtfGJg0='.
]
