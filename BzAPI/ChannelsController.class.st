Class {
	#name : #ChannelsController,
	#superclass : #APIController,
	#category : #'BzAPI-controllers'
}

{ #category : #lessons }
ChannelsController >> getAll [
	<apicontroller>
	teapot GET: '/channels' -> [ :req | Channel selectAll ]
]
