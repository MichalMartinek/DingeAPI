Class {
	#name : #BaseModel,
	#superclass : #Object,
	#category : #'DingeAPI-models'
}

{ #category : #accessing }
BaseModel class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping | mapping mapAllInstVars ]
]
