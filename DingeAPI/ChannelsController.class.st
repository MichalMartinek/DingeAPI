Class {
	#name : #ChannelsController,
	#superclass : #APIController,
	#category : #'DingeAPI-controllers'
}

{ #category : #lessons }
ChannelsController >> getAll [
	<apicontroller>
	teapot GET: '/api/channels' -> [ :req | self getAll: req ]
]

{ #category : #lessons }
ChannelsController >> getAll: req [
	^ Channel selectAll 
]
