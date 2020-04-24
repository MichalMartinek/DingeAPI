Extension { #name : #ZnMessage }

{ #category : #'*DingeAPI' }
ZnMessage >> parseJSONBody [
	^ (NeoJSONReader on: self entity contents readStream)
		propertyNamesAsSymbols: true;
		next
]
