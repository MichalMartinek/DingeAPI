Class {
	#name : #Device,
	#superclass : #BaseModel,
	#instVars : [
		'name',
		'user',
		'createdAt'
	],
	#category : #'DingeAPI-models'
}

{ #category : #testing }
Device class >> isVoyageRoot [ 
	^ true
]

{ #category : #testing }
Device class >> neoJsonMapping: mapper [
	mapper
		for: self
		do: [ :mapping | 
			mapping
				mapInstVars: #(#name #createdAt);
				mapAccessor: #voyageId to: #id ]
]

{ #category : #accessing }
Device >> createdAt [
	^ createdAt
]

{ #category : #accessing }
Device >> createdAt: anObject [
	createdAt := anObject
]

{ #category : #accessing }
Device >> name [
	^ name
]

{ #category : #accessing }
Device >> name: anObject [
	name := anObject
]

{ #category : #accessing }
Device >> user [
	^ user
]

{ #category : #accessing }
Device >> user: anObject [
	user := anObject
]
