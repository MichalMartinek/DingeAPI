Class {
	#name : #Channel,
	#superclass : #BaseModel,
	#instVars : [
		'name',
		'createdAt',
		'updatedAt',
		'users',
		'records'
	],
	#category : #'DingeAPI-models'
}

{ #category : #testing }
Channel class >> isVoyageRoot [ 
	^ true
]

{ #category : #testing }
Channel class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping | mapping mapInstVars: #(#name #createdAt #updatedAt #records); mapAccessor: #voyageId to: #id ]
]

{ #category : #accessing }
Channel >> addRecord: aRecord [
	self records add: aRecord
]

{ #category : #accessing }
Channel >> addUser: aUser [
   self users add: aUser
]

{ #category : #accessing }
Channel >> createdAt [
	^ createdAt
]

{ #category : #accessing }
Channel >> createdAt: anObject [
	createdAt := anObject
]

{ #category : #accessing }
Channel >> name [
	^ name
]

{ #category : #accessing }
Channel >> name: anObject [
	name := anObject
]

{ #category : #accessing }
Channel >> records [
	^ records ifNil: [ records := LinkedList new ]
]

{ #category : #accessing }
Channel >> updatedAt [
	^ updatedAt
]

{ #category : #accessing }
Channel >> updatedAt: anObject [
	updatedAt := anObject
]

{ #category : #accessing }
Channel >> users [
   ^ users ifNil: [ users := Set new ]
]
