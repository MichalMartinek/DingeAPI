Class {
	#name : #APIServer,
	#superclass : #Object,
	#instVars : [
		'teapot',
		'session',
		'controllers'
	],
	#category : #'BzAPI-server'
}

{ #category : #'instance creation' }
APIServer class >> start [
	^ self new
		start
]

{ #category : #registering }
APIServer class >> stopAll [
	self allInstancesDo: #stop.
	Teapot stopAll
]

{ #category : #private }
APIServer >> collectRoutes [
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
APIServer >> start [
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
APIServer >> stop [
	teapot ifNil: [ ^ self ].
	teapot
		removeAllDynamicRoutes;
		stop
]

{ #category : #api }
APIServer >> welcomeFor: req [
	^ 'Welcome'
]
