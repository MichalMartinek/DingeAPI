Extension { #name : #DateAndTime }

{ #category : #'*BzAPI' }
DateAndTime class >> neoJsonMapping: mapper [
	mapper for: self customDo: [ :mapping | mapping encoder: #printString ]
]
