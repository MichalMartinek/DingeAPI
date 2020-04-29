Class {
	#name : #ChannelsController,
	#superclass : #APIController,
	#category : #'DingeAPI-controllers'
}

{ #category : #lessons }
ChannelsController >> create [
	<apicontroller>
	teapot POST: '/api/channels' -> [ :req | self create: req ]
]

{ #category : #lessons }
ChannelsController >> create: req [
	| parsedBody channel user |
	parsedBody := req parseJSONBody.
	[ user := req getUser.
	channel := Channel new
		name: (parsedBody at: #name);
		createdAt: DateAndTime now;
		updatedAt: DateAndTime now.
	ChannelService saveChannel: channel ]
		on: Error
		do: [ :err | 
			req
				abort:
					(TeaResponse new
						code: 400;
						body: err messageText).
			^ nil ].
	^ TeaResponse created
]

{ #category : #lessons }
ChannelsController >> edit [
	<apicontroller>
	teapot PUT: '/api/channels/<id>' -> [ :req | self edit: req ]
]

{ #category : #lessons }
ChannelsController >> edit: req [
	| parsedBody channel user oid |
	parsedBody := req parseJSONBody.
	[ user := req getUser.
	oid := OID value: (req at: #id) asNumber.
	channel := ChannelService findById: oid.
	channel
		ifNil: [ req abort: TeaResponse notFound.
			^ nil ].
	channel
		name: (parsedBody at: #name);
		updatedAt: DateAndTime now.
	ChannelService saveChannel: channel ]
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
ChannelsController >> listAll [
	<apicontroller>
	teapot GET: '/api/channels' -> [ :req | self listAll: req ]
]

{ #category : #lessons }
ChannelsController >> listAll: req [
	^ Channel selectAll 
]
