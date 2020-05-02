Class {
	#name : #RecordsController,
	#superclass : #APIController,
	#category : #'DingeAPI-controllers'
}

{ #category : #lessons }
RecordsController >> create [
	<apicontroller>
	teapot POST: '/api/channels/<id>/records' -> [ :req | self create: req ]
]

{ #category : #lessons }
RecordsController >> create: req [
	| parsedBody channel user oid record |
	parsedBody := req parseJSONBody.
	[ user := Authenticator getUser: req.
	oid := OID value: (req at: #id) asNumber.
	channel := ChannelService findById: oid.
	channel
		ifNil: [ req abort: TeaResponse notFound.
			^ nil ].
	record := Record new
		field: (parsedBody at: #field);
		val: (parsedBody at: #value);
		createdAt: DateAndTime now.
	channel addRecord: record.
	ChannelService save: channel ]
		on: Error
		do: [ :err | 
			req
				abort:
					(TeaResponse new
						code: 400;
						body: err messageText).
			^ nil ].
	^ channel records
]

{ #category : #lessons }
RecordsController >> listAll [
	<apicontroller>
	teapot GET: '/api/channels/<id>/records' -> [ :req | self listAll: req ]
]

{ #category : #lessons }
RecordsController >> listAll: req [
	| channel user oid |
	user := Authenticator getUser: req.
	oid := OID value: (req at: #id) asNumber.
	channel := ChannelService findById: oid.
	channel
		ifNil: [ req abort: TeaResponse notFound.
			^ nil ].
	^ channel records
]
