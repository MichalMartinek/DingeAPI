Class {
	#name : #BzAPIServer,
	#superclass : #Object,
	#instVars : [
		'teapot',
		'session',
		'controllers'
	],
	#category : #'BzAPI-server'
}

{ #category : #'instance creation' }
BzAPIServer class >> start [
	^ self new
		start
]

{ #category : #registering }
BzAPIServer class >> stopAll [
	self allInstancesDo: #stop.
	Teapot stopAll
]

{ #category : #private }
BzAPIServer >> collectRoutes [
	controllers := APIController allSubclasses
		collect: [ :each | 
			each new
				session: session;
				teapot: teapot;
				yourself ].
	controllers
		do: [ :eachController | 
			(Pragma allNamed: #mopcontroller in: eachController class)
				do:
					[ :eachPragma | (Message selector: eachPragma method selector) sendTo: eachController ] ]
]

{ #category : #actions }
BzAPIServer >> start [
	self class stopAll.
	teapot := Teapot
		configure:
			{(#defaultOutput -> #json).
			(#port -> 8080).
			(#debugMode -> true)}.
	self collectRoutes.
	teapot start
]

{ #category : #actions }
BzAPIServer >> stop [
	teapot ifNil: [ ^ self ].
	teapot
		removeAllDynamicRoutes;
		stop
]

{ #category : #api }
BzAPIServer >> welcomeFor: req [
	^ 'Welcome'
]
