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
				session: session;
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
		host: 'localhost' 
		database: 'pharo'.
	repository enableSingleton.
	teapot := Teapot
		configure:
			{(#defaultOutput -> #json).
			(#port -> 8080).
			(#debugMode -> true)}.
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

{ #category : #api }
DingeAPIServer >> welcomeFor: req [
	^ 'Welcome'
]
