Class {
	#name : #ChannelsController,
	#superclass : #APIController,
	#category : #'DingeAPI-controllers'
}

{ #category : #lessons }
ChannelsController >> getAll [
	<apicontroller>
	teapot GET: '/channels' -> [ :req | Channel selectAll ]
]
