Extension { #name : #DateAndTime }

{ #category : #'*DingeAPI' }
DateAndTime class >> neoJsonMapping: mapper [
	mapper for: self customDo: [ :mapping | mapping encoder: #printString ]
]
