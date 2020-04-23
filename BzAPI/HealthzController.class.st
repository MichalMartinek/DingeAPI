Class {
	#name : #HealthzController,
	#superclass : #APIController,
	#category : #'BzAPI-controllers'
}

{ #category : #lessons }
HealthzController >> getStatus [
	<apicontroller>
	teapot GET: '/healthz' -> [ :req | 'Healthz! API is running.' ]
]
