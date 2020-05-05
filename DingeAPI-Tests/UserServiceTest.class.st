Class {
	#name : #UserServiceTest,
	#superclass : #BaseServiceTest,
	#category : #'DingeAPI-Tests-services'
}

{ #category : #'as yet unclassified' }
UserServiceTest >> createUser: name [
	^ User new
		name: name;
		email: name, '@email.com';
		password: 'test'.
]

{ #category : #'as yet unclassified' }
UserServiceTest >> tearDown [
	super tearDown.
	User removeAll.
]

{ #category : #'as yet unclassified' }
UserServiceTest >> testFindById [
	| user1 user2 |
	user1 := self createUser: 'test'.
	user2 := self createUser: 'test'.
	user1 save.
	user2 save.
	self assert: (UserService findById: user2 voyageId) equals: user2.
]

{ #category : #'as yet unclassified' }
UserServiceTest >> testFindUserByEmail [
	| user1 user2 |
	user1 := self createUser: 'test'.
	user2 := self createUser: 'testa'.
	user1 save.
	user2 save.
	self assert: (UserService findUserByEmail: user2 email) equals: user2.
]

{ #category : #'as yet unclassified' }
UserServiceTest >> testFindUserByEmailAndPassowrd [
	| user1 user2 |
	user1 := self createUser: 'test'.
	user2 := self createUser: 'testa'.
	user1 save.
	user2 save.
	self
		assert:
			(UserService findUserByEmail: user2 email andPassword: user2 password)
		equals: user2
]

{ #category : #'as yet unclassified' }
UserServiceTest >> testSave [
	| user |
	user := self createUser: 'martinek'.
	UserService save: user.
	self deny: user voyageId value asString isEmpty.
	self assert: User selectAll size equals: 1.
	self assert: User selectAll any name equals: user name.
]

{ #category : #'as yet unclassified' }
UserServiceTest >> testSaveAsNew [
	| user1 user2 |
	user1 := self createUser: 'martinek'.
	user1 save.
	self assert: User selectAll size equals: 1.
	user2 := self createUser: 'michal'.
	UserService saveAsNew: user2.
	self deny: user2 voyageId value asString isEmpty.
	self assert: User selectAll size equals: 2.
]
