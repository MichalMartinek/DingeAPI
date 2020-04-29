Class {
	#name : #UserService,
	#superclass : #Object,
	#category : #'DingeAPI-services'
}

{ #category : #'as yet unclassified' }
UserService class >> findUserByEmail: anEmail [
	^ User selectOne: [ :each | each email = anEmail ]
]

{ #category : #'as yet unclassified' }
UserService class >> findUserByEmail: anEmail andPassword: aPassword [
	^ User
		selectOne: [ :each | (each email = anEmail) & (each password = aPassword) ]
]

{ #category : #'as yet unclassified' }
UserService class >> save: anUser [
	anUser save
]

{ #category : #'as yet unclassified' }
UserService class >> saveAsNew: anUser [
	| existingUser |
	existingUser := self findUserByEmail: anUser email.
	existingUser ifNotNil: [self error: 'User with this email already exists.'].
	anUser save
]
