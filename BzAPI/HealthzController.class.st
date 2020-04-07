Class {
	#name : #HealthzController,
	#superclass : #APIController,
	#category : #'BzAPI-controllers'
}

{ #category : #lessons }
HealthzController >> welcome [
	<mopcontroller>
	teapot GET: '/' -> [ :req | 'Healthz!' ]
]
