Extension { #name : #OID }

{ #category : #'*DingeAPI' }
OID class >> neoJsonMapping: mapper [
	mapper for: self customDo: [ :mapping | mapping encoder: #value ]
]
