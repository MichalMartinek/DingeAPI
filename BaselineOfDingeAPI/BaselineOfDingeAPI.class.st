Class {
	#name : #BaselineOfDingeAPI,
	#superclass : #BaselineOf,
	#category : #BaselineOfDingeAPI
}

{ #category : #baselines }
BaselineOfDingeAPI >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Voyage'
					with: [ spec
						repository: 'github://pharo-nosql/voyage/mc';
						loads: #('mongo tests' 'memory') ];
				baseline: 'JSONWebToken'
					with: [ spec repository: 'github://noha/JSONWebToken:master/source' ];
				baseline: 'Teapot'
					with: [ spec repository: 'github://zeroflag/Teapot/source' ];
				package: #DingeAPI with: [ spec requires: #(Teapot JSONWebToken Voyage) ];
				group: #default with: #(#DingeAPI) ]
]
