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
	[ user := req getUser.
	oid := OID value: (req at: #id) asNumber.
	channel := ChannelService findById: oid.
	channel
		ifNil: [ req abort: TeaResponse notFound.
			^ nil ].
	record := Record new
		field: (parsedBody at: #field);
		val: (parsedBody at: #value);
		channel: channel voyageId value printString;
		createdAt: DateAndTime now.
	RecordService saveRecord: record ]
		on: Error
		do: [ :err | 
			req
				abort:
					(TeaResponse new
						code: 400;
						body: err messageText).
			^ nil ].
	^ channel
]

{ #category : #lessons }
RecordsController >> listAll [
	<apicontroller>
	teapot GET: '/api/channels/<id>/records' -> [ :req | self listAll: req ]
]

{ #category : #lessons }
RecordsController >> listAll: req [
	| parsedBody channel user oid channelId |
	user := req getUser.
	oid := OID value: (req at: #id) asNumber.
	channel := ChannelService findById: oid.
	channel
		ifNil: [ req abort: TeaResponse notFound.
			^ nil ].
	channelId := channel voyageId value printString.
	^ RecordService findByChannelId: channelId
]
