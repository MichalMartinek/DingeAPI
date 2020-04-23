Class {
	#name : #DingeAPIServer,
	#superclass : #Object,
	#instVars : [
		'teapot',
		'session',
		'controllers',
		'repository'
	],
	#category : #'DingeAPI-server'
}

{ #category : #'instance creation' }
DingeAPIServer class >> start [
	^ self new
		start
]

{ #category : #registering }
DingeAPIServer class >> stopAll [
	self allInstancesDo: #stop.
	Teapot stopAll
]

{ #category : #private }
DingeAPIServer >> collectRoutes [
	controllers := APIController allSubclasses
		collect: [ :each | 
			each new
				teapot: teapot;
				yourself ].
	controllers
		do: [ :eachController | 
			(Pragma allNamed: #apicontroller in: eachController class)
				do:
					[ :eachPragma | (Message selector: eachPragma method selector) sendTo: eachController ] ]
]

{ #category : #actions }
DingeAPIServer >> start [
	self class stopAll.
	repository := VOMongoRepository
		host: ServerSettings databaseHost
		database: ServerSettings databaseCollection.
	repository enableSingleton.
	teapot := Teapot
		configure:
			{(#defaultOutput -> #json).
			(#port -> ServerSettings serverPort).
			(#debugMode -> true)}.
	teapot before: '/api/*' -> [ :req | Authenticator checkRequest: req ].
	self collectRoutes.
	teapot start
]

{ #category : #actions }
DingeAPIServer >> stop [
	teapot ifNil: [ ^ self ].
	teapot
		removeAllDynamicRoutes;
		stop
]
