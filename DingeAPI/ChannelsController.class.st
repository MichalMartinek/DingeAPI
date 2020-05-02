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
	[ user := Authenticator getUser: req.
	channel := Channel new
		name: (parsedBody at: #name);
		createdAt: DateAndTime now;
		updatedAt: DateAndTime now;
		addUser: user.
	ChannelService saveChannel: channel.
	user addChannel: channel.
	UserService save: user. ]
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
ChannelsController >> delete [
	<apicontroller>
	teapot DELETE: '/api/channels/<id>' -> [ :req | self delete: req ]
]

{ #category : #lessons }
ChannelsController >> delete: req [
	| channel user oid |
	[ user := Authenticator getUser: req.
	oid := OID value: (req at: #id) asNumber.
	channel := ChannelService findById: oid.
	channel
		ifNil: [ req abort: TeaResponse notFound.
			^ nil ].
	channel users
		do: [ :u | 
			u removeChannel: channel.
			UserService save: u ].
	ChannelService removeChannel: channel ]
		on: Error
		do: [ :err | 
			req
				abort:
					(TeaResponse new
						code: 400;
						body: err messageText).
			^ nil ].
	^ TeaResponse code: 204
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
	[ user := Authenticator getUser: req.
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
