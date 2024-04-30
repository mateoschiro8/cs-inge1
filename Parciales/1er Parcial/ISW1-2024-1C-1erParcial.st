!classDefinition: #FloorTest category: 'ISW1-2024-1C-1erParcial'!
TestCase subclass: #FloorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-1erParcial'!

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 16:54:55'!
test01CannotCreateFloorWithoutRooms

	self
		should: [ self createFloorWith: 0 and: self defaultPriceList ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Floor numberOfRoomsMustBePositiveErrorDescription ! !

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 16:55:02'!
test02CannotCreateFloorWithNoIntergerNumberOfRooms

	self
		should: [ self createFloorWith: 1.5 and: self defaultPriceList ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Floor numberOfRoomsMustBeIntegerErrorDescription ! !

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 16:55:06'!
test03CannotCreateFloorWithoutPrices

	self
		should: [ self createFloorWith: 10 and:  Dictionary new ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Floor pricesListCannotBeEmptyErrorDescription ! !

!FloorTest methodsFor: 'testing' stamp: 'MS 4/29/2024 19:18:15'!
test04WhenAFloorIsCreatedAllTheRoomsAreAvailable

	| floor |
	
	floor := self createFloorWith10RoomsAndDefaultPrices.
	
	self assert: floor isAvailable.
	
	self assertThat: floor hasAvailable: 10 andOccupied: 0 andReserved: 0. 
! !

!FloorTest methodsFor: 'testing' stamp: 'MS 4/29/2024 19:36:31'!
test05WhenAFloorReceivesAGuestInARoomReducesTheAvailableRoomsByOneAndIncreaseOccupiedByOne

	| floor |
	
	floor := self createFloorWith10RoomsAndDefaultPrices.
	
	"Tech Debt"
	self receiveAType: (self guestTypeVacation) inRoomNumber: 1 at: floor.
	
	self assertThat: floor hasAvailable: 9 andOccupied: 1 andReserved: 0. 
! !

!FloorTest methodsFor: 'testing' stamp: 'MS 4/29/2024 19:38:10'!
test06WhenAFloorReceivesOnReservationAGuestInARoomKeepsTheAvailableRoomsAndOccupiedAndReducesTheReservedByOne

	| floor roomsAvailable roomsOccupied roomsReserved |

	floor := self createFloorWith10RoomsAndDefaultPrices.
	
	"Tech Debt"
	self reserveRoomNumber: 1 at: floor. 

	roomsAvailable := floor totalRoomsAvailable.
	roomsOccupied := floor totalRoomsOccupied.
	roomsReserved := floor totalRoomsReserved.

	"Tech Debt"
	self recieveWithReservation: (self guestTypeVacation) inRoom: 1 at: floor. 
	
	self assertThat: floor hasAvailable: roomsAvailable andOccupied: roomsOccupied andReserved: (roomsReserved - 1). 
! !

!FloorTest methodsFor: 'testing' stamp: 'MS 4/29/2024 19:23:02'!
test07WhenARoomIsReservedTheFloorAvailableRoomsReducesByOneAndIncreaseReservedAndOccupiedByOne

	| floor  |
	
	floor := self createFloorWith10RoomsAndDefaultPrices.
	
	"Tech Debt"
	self reserveRoomNumber: 1 at: floor.
	
	self assertThat: floor hasAvailable: 9 andOccupied: 1 andReserved: 1. 
! !

!FloorTest methodsFor: 'testing' stamp: 'MS 4/29/2024 19:38:47'!
test08TotalProfitShouldBeTheSumOfOccupiedRoomsProfits

	| floor |
	
	floor := self createFloorWith10RoomsAndDefaultPrices.
	
	"Tech Debt"
	self   receiveAType: (self guestTypeVacation ) inRoomNumber: 1 at: floor;
		receiveAType: (self guestTypeConference) inRoomNumber: 2 at: floor; 
		reserveRoomNumber: 3 at: floor. 
		
	self assert: (100*peso) + (200*peso) + (50*peso) equals: floor totalProfits
! !

!FloorTest methodsFor: 'testing' stamp: 'MS 4/29/2024 19:39:05'!
test09TotalLossesShouldBeTheSumOfAvailableRoomsLosses

	| floor |
	
	floor := self createFloorWith10RoomsAndDefaultPrices.
	
	"Tech Debt"
	self  receiveAType: (self guestTypeVacation ) inRoomNumber: 1 at: floor;
		receiveAType: (self guestTypeConference) inRoomNumber: 2 at: floor; 
		reserveRoomNumber: 3 at: floor. 
		
	self assert: (200*peso) * 7 equals: floor totalLosses
! !


!FloorTest methodsFor: 'assertions' stamp: 'MS 4/29/2024 19:17:42'!
assertThat: aFloor hasAvailable: availableRooms andOccupied: occupiedRooms andReserved: reservedRooms

	self assert: availableRooms equals: aFloor totalRoomsAvailable.
	self assert: occupiedRooms equals: aFloor totalRoomsOccupied.
	self assert: reservedRooms equals: aFloor totalRoomsReserved.
	
! !


!FloorTest methodsFor: 'data' stamp: 'FRT 4/21/2024 17:01:23'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: 100*peso;
		at: self guestTypeConference put: 200*peso;
		yourself ! !

!FloorTest methodsFor: 'data' stamp: 'FRT 4/21/2024 17:00:09'!
guestTypeConference
	
	^ #conferenceGuest! !

!FloorTest methodsFor: 'data' stamp: 'FRT 4/21/2024 17:00:42'!
guestTypeVacation
	
	^ #vacationGuest! !


!FloorTest methodsFor: 'guests' stamp: 'MS 4/29/2024 19:35:21'!
receiveAType: aGuestType inRoomNumber: aRoomNumber at: aFloor

	((aFloor rooms) at: aRoomNumber) receive: aGuestType.! !

!FloorTest methodsFor: 'guests' stamp: 'MS 4/29/2024 19:34:05'!
recieveWithReservation: aGuestType inRoom: aRoomNumber at: aFloor

	((aFloor rooms) at: aRoomNumber) receiveWithReservation: aGuestType! !

!FloorTest methodsFor: 'guests' stamp: 'MS 4/29/2024 19:28:17'!
reserveRoomNumber: aRoomNumber at: aFloor

	((aFloor rooms) at: aRoomNumber) reserve.! !


!FloorTest methodsFor: 'create' stamp: 'MS 4/29/2024 17:25:44'!
createFloorWith10RoomsAndDefaultPrices

	^ self createFloorWith: 10 and: self defaultPriceList! !

!FloorTest methodsFor: 'create' stamp: 'MS 4/29/2024 19:20:15'!
createFloorWith: aNumberOfRooms and: aPrice

	| floor |

	floor := Floor new.
	floor setNumberOfRooms: aNumberOfRooms; setPrices: aPrice.
	
	^ floor.! !


!classDefinition: #HotelTest category: 'ISW1-2024-1C-1erParcial'!
TestCase subclass: #HotelTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-1erParcial'!

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:16:52'!
test01CannotCreateHotelWithoutFloors

	self
		should: [ Hotel new setFloors: OrderedCollection new. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Hotel noFloorsErrorDescription.! !

!HotelTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 11:30:09'!
test02NewHotelsAreEmpty

	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel isEmpty.! !

!HotelTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:06:27'!
test03HotelCanReceiveATypeOfGuestInRoomAtFloor

	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 2.

	self assertThat: hotel hasAvailable: (hotel totalRooms - 1) andOccupied: 1 andReserved: 0.
! !

!HotelTest methodsFor: 'testing' stamp: 'MS 4/29/2024 19:46:13'!
test04HotelCanTakeAReservationForARoomAtFloor

	| hotel |
	
	hotel := self createHotel.

	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel reserveRoom: 2 atFloor: 1.

	self assertThat: hotel hasAvailable: (hotel totalRooms - 1) andOccupied: 1 andReserved: 1.! !

!HotelTest methodsFor: 'testing' stamp: 'MS 4/29/2024 19:46:35'!
test05HotelCanReceiveWithReservationATypeOfGuestInRoomAtFloor

	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel reserveRoom: 2 atFloor: 1.
	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 2.

	self assertThat: hotel hasAvailable: (hotel totalRooms - 1) andOccupied: 1 andReserved: 0.
! !

!HotelTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:10:17'!
test06HotelCannotReceiveWithReservationWithoutPreviousReservation
	
	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	self 
		should: [ 	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [		:error |	 self assertAvailable: (hotel totalRooms) andOccupied: 0 andReserved: 0 afterRoomNotReservedIn: hotel andThrow: error 	]


! !

!HotelTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:10:38'!
test07HotelProfitsAreTheSumOfEachFloorProfits
	
	| hotel floor1 floor2 floors |
	
	floor1 := self createFloorWithDefaultPricesAndRooms: 10.
	floor2 := self createFloorWithDefaultPricesAndRooms: 10.

	floors := OrderedCollection with: floor1 with: floor2.
	hotel := 	Hotel new setFloors: floors.
	
	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 1.
	hotel receive: self guestTypeConference atFloor: 2 atRoom: 1.

	self assert: floor1 totalProfits + floor2 totalProfits equals:		hotel totalProfits.! !

!HotelTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:10:34'!
test08HotelLossesAreTheSumOfEachFloorLosses
	
	| hotel floor1 floor2 floors |
	
	floor1 := self createFloorWithDefaultPricesAndRooms: 10.
	floor2 := self createFloorWithDefaultPricesAndRooms: 10.

	floors := OrderedCollection with: floor1 with: floor2.
	hotel := 	Hotel new setFloors: floors.
	
	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 1.
	hotel receive: self guestTypeConference atFloor: 2 atRoom: 1.

	hotel reserveRoom: 4 atFloor: 1.
	hotel reserveRoom: 2 atFloor: 2.

	self assert: floor1 totalLosses + floor2 totalLosses equals:		hotel totalLosses.! !

!HotelTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:03:52'!
test09HotelCannotReserveANonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWithDefaultPricesAndRooms: 10.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.
	
	self 
		should: [ 	hotel reserveRoom: 42 atFloor: 1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [		:error |	 self assertAvailable: (hotel totalRooms) andOccupied: 0 andReserved: 0 afterRoomNumberNotExistingIn: hotel andThrow: error.] 
! !

!HotelTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:05:51'!
test10HotelCannotReserveANonexistentFloor
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWithDefaultPricesAndRooms: 10.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.
	
	self 
		should: [ 	hotel reserveRoom: 1 atFloor: 42. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [		:error |		 	self assertAvailable: (hotel totalRooms) andOccupied: 0 andReserved: 0 afterFloorNumberNotExistingIn: hotel andThrow: error ]! !

!HotelTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:03:58'!
test11HotelCannotReceiveAtNonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWithDefaultPricesAndRooms: 10.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.
	
	self 
		should: [ 	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 42. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [		:error |	 self assertAvailable: (hotel totalRooms) andOccupied: 0 andReserved: 0 afterRoomNumberNotExistingIn: hotel andThrow: error. ]
		! !

!HotelTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:05:40'!
test12HotelCannotReceiveAtNonexistentFloor
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWithDefaultPricesAndRooms: 10.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.
	
	self 
		should: [ 	hotel receive: self guestTypeVacation atFloor: 42 atRoom: 1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [		:error |	 	self assertAvailable: (hotel totalRooms) andOccupied: 0 andReserved: 0 afterFloorNumberNotExistingIn: hotel andThrow: error ]! !

!HotelTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:04:37'!
test13HotelCannotReceiveWithReservationAtNonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.

	hotel reserveRoom: 1 atFloor: 1. 
	
	self 
	should: [ 	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	 self assertAvailable: (hotel totalRooms - 1) andOccupied: 1 andReserved: 1 afterRoomNumberNotExistingIn: hotel andThrow: error. ]! !


!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:05'!
createFloorWith: aNumberOfRooms and: aPrice

	| floor |

	floor := Floor new.
	floor setNumberOfRooms: aNumberOfRooms.
	floor setPrices: aPrice.
	
	^ floor.! !

!HotelTest methodsFor: 'create' stamp: 'MS 4/29/2024 17:29:41'!
createFloorWithDefaultPricesAndRooms: aNumberOfRooms

	^ self createFloorWith: aNumberOfRooms and: self defaultPriceList
								      	 
								! !

!HotelTest methodsFor: 'create' stamp: 'MS 4/29/2024 17:30:02'!
createHotel

	^ Hotel new 
		      setFloors: (OrderedCollection with: (self createFloorWithDefaultPricesAndRooms: 10)
								      	 with: (self createFloorWithDefaultPricesAndRooms: 1)).
								! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:22'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: self minPriceInList;
		at: self guestTypeConference put: self maxPriceInList;
		yourself ! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:36'!
guestTypeConference
	
	^ #conferenceGuest! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:42'!
guestTypeVacation
	
	^ #vacationGuest! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:48'!
maxPriceInList
	
	^ 200*peso ! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:53'!
minPriceInList
	
	^ 100*peso ! !


!HotelTest methodsFor: 'assertions' stamp: 'MS 4/29/2024 20:08:24'!
assertAvailable: availableRooms andOccupied: occupiedRooms andReserved: reservedRooms afterFloorNumberNotExistingIn: anHotel andThrow: anError

	self assert: Hotel  floorNumberDoesNotExistErrorDescription equals: anError messageText.
			
	self assertThat: anHotel hasAvailable: availableRooms andOccupied: occupiedRooms andReserved: reservedRooms.! !

!HotelTest methodsFor: 'assertions' stamp: 'MS 4/29/2024 20:08:54'!
assertAvailable: availableRooms andOccupied: occupiedRooms andReserved: reservedRooms afterRoomNotReservedIn: anHotel andThrow: anError

	self assert: Room roomIsNotReservedErrorDescription equals: anError messageText.
			
	self assertThat: anHotel hasAvailable: availableRooms andOccupied: occupiedRooms andReserved: reservedRooms.! !

!HotelTest methodsFor: 'assertions' stamp: 'MS 4/29/2024 20:00:23'!
assertAvailable: availableRooms andOccupied: occupiedRooms andReserved: reservedRooms afterRoomNumberNotExistingIn: anHotel andThrow: anError

	" Comentario de alumno: Moví la errorDescription al piso y la saqué del hotel, así que lo cambié acá también.
	Originalmente era self assert: Hotel roomNumberDoesNotExistErrorDescription"
	self assert: Floor roomNumberDoesNotExistErrorDescription equals: anError messageText.
			
	self assertThat: anHotel hasAvailable: availableRooms andOccupied: occupiedRooms andReserved: reservedRooms.! !

!HotelTest methodsFor: 'assertions' stamp: 'MS 4/29/2024 19:44:57'!
assertThat: anHotel hasAvailable: availableRooms andOccupied: occupiedRooms andReserved: reservedRooms

	self assert: availableRooms equals: anHotel totalRoomsAvailable.
	self assert: occupiedRooms equals: anHotel totalRoomsOccupied.
	self assert: reservedRooms equals: anHotel totalRoomsReserved.
	! !


!classDefinition: #RoomTest category: 'ISW1-2024-1C-1erParcial'!
TestCase subclass: #RoomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-1erParcial'!

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:17:17'!
assertARoomIsAvailable: aRoom

	self assert: aRoom isAvailable.
	self deny: aRoom isOccupied.
	self deny: aRoom isReserved! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:18:16'!
assertARoomIsOccupiedAndReserved: aRoom

	self assert: aRoom isReserved.
	self assert: aRoom isOccupied.
	self deny: aRoom isAvailable! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:19:00'!
assertARoomIsOccupiedButNotReserved: aRoom

	self assert: aRoom isOccupied.
	self deny: aRoom isAvailable.
	self deny: aRoom isReserved! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:17:17'!
test01NewRoomsAreAvailable

	| room |
	
	room := Room new.

	self assertARoomIsAvailable: room.! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:19:00'!
test02ReceivingAGuestMakesTheRoomOccupied

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self assertARoomIsOccupiedButNotReserved: room.! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:18:16'!
test03ReservingARoomMakesTheRoomReservedAndOccupied

	| room |
	
	room := Room new.

	room reserve.

	self assertARoomIsOccupiedAndReserved: room.
! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:19:00'!
test04CannotReceiveAGuestInAOccupiedRoom

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.
	
	self 
		should: [ room receive: self guestTypeVacation ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotEmptyErrorDescription equals: error messageText.
			self assertARoomIsOccupiedButNotReserved: room. 		]
	
! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:19:26'!
test05CannotReceiveAGuestInAReservedRoom

	| room |
	
	room := Room new.

	room reserve.
	
	self 
		should: [ room receive: self guestTypeVacation ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotEmptyErrorDescription equals: error messageText.
			self assertARoomIsOccupiedAndReserved: room. 	]

	
! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:19:39'!
test06ReceivingOnReservationMakesTheRoomOccupied

	| room |
	
	room := Room new.

	room reserve.
	
	room receiveWithReservation: self guestTypeVacation.
	
	self assertARoomIsOccupiedButNotReserved: room.! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:19:56'!
test07CannotReceiveOnReservationAnAvailableRoom

	| room |
	
	room := Room new.

	self 
		should: [ room receiveWithReservation: self guestTypeVacation. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.
			self assertARoomIsAvailable: room		]

	
! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:20:16'!
test08CannotReceiveOnReservationAnOccupiedRoom

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self 
		should: [ room receiveWithReservation: self guestTypeVacation. ] 
		raise: Error - MessageNotUnderstood 	
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.
			self assertARoomIsOccupiedButNotReserved: room ]! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:22:02'!
test09ProfitOfAvailableRoomIsCeroPesos

	| room |
	
	room := Room new.

	self assert: 0*peso equals: (room profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
	
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:22:57'!
test10ProfitOfReservedRoomIsHalfTheMinPriceInList

	| room |
	
	room := Room new.

	room reserve.

	self assert: self minPriceInList / 2 equals: (room profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 20:16:17'!
test11ProfitOfOccupiedRoomDependsOnGuestType

	| roomWithConferenceGuest roomWithVacationGuest |
	
	roomWithConferenceGuest := Room new .
	roomWithConferenceGuest receive: self guestTypeConference.
	
	roomWithVacationGuest := Room new.
	roomWithVacationGuest receive: self guestTypeVacation.

	self assert: (self defaultPriceList at: self guestTypeConference) 
		equals: (roomWithConferenceGuest profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).

	self assert: (self defaultPriceList at: self guestTypeVacation) 
		equals: (roomWithVacationGuest profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:52:21'!
test12NoProfitOnOccupiedRoomByUnknownGuestType

	| room |
	
	room := Room new.
	room receive: #unknownGuest.
	
	room profitUsing: self defaultPriceList ifAbsentGuestType: [ ^self ].
	
	"we should not get here"
	self failWith: 'should not calculate profit on room occupied by unknown guest type'.
! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 18:54:08'!
test13LossesOfAvailableRoomIsHalfTheMaxPriceInList

	| room |
	
	room := Room new.

	self assert: self maxPriceInList equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
	
! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 18:57:32'!
test14LossesOfReservedRoomIsCeroPesos

	| room |

	room := Room new.

	room reserve.

	self assert: 0*peso equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'MS 4/29/2024 18:57:44'!
test15LossesOfOccupiedRoomIsCeroPesos

	| room |

	room := Room new.

	room receive: self guestTypeVacation.

	self assert: 0*peso equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/28/2024 15:53:31'!
test16CannotReserveWhenReserved

	| room |
	
	room := Room new.

	room reserve.

	self 
		should: [ room reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room roomIsNotEmptyErrorDescription equals: anError messageText.
			self assert: room isReserved ].! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/28/2024 15:53:48'!
test17CannotReserveWhenOccupied

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self 
		should: [ room reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room roomIsNotEmptyErrorDescription equals: anError messageText.
			self assert: room isOccupied ].! !


!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:16:28'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: self minPriceInList;
		at: self guestTypeConference put: self maxPriceInList;
		yourself ! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:20:45'!
guestTypeConference
	
	^ #conferenceGuest! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:02:15'!
guestTypeVacation
	
	^ #vacationGuest! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:16:13'!
maxPriceInList
	
	^ 200*peso ! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:40:38'!
minPriceInList
	
	^ 100*peso ! !


!classDefinition: #Floor category: 'ISW1-2024-1C-1erParcial'!
Object subclass: #Floor
	instanceVariableNames: 'rooms prices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-1erParcial'!

!Floor methodsFor: 'testing' stamp: 'FRT 4/21/2024 15:02:31'!
isAvailable
	
	^ self totalRooms = self totalRoomsAvailable

		
! !


!Floor methodsFor: 'accessing' stamp: 'FRT 4/20/2024 21:34:09'!
rooms

	^ rooms! !


!Floor methodsFor: 'accounting' stamp: 'MS 4/29/2024 19:06:45'!
totalLosses
	
	^ rooms sum: [ :room | room lossUsing: prices ifAbsentGuestType: [self class signalUnknownGuestType]] ifEmpty: [0]



		
! !

!Floor methodsFor: 'accounting' stamp: 'MS 4/29/2024 19:06:48'!
totalProfits

	^ rooms sum: [ :room | room profitUsing: prices ifAbsentGuestType: [self class signalUnknownGuestType]] ifEmpty: [0]
! !


!Floor methodsFor: 'setters' stamp: 'FRT 4/20/2024 19:48:41'!
setNumberOfRooms: aNumberOfRooms

	self class assertIsPositive: aNumberOfRooms ifFalse: [ self class signalNumberOfRoomsMustBePositive ].
	self class assertIsInteger: aNumberOfRooms ifFalse: [ self class signalNumberOfRoomsMustBeInteger ].
	
	self initializeRoomsWith: aNumberOfRooms.
! !

!Floor methodsFor: 'setters' stamp: 'FRT 4/21/2024 15:00:28'!
setPrices: aPriceList

	aPriceList isEmpty ifTrue: [ self class signalNoPrices ].
	
	aPriceList values do: [ :price | 
		self class assertIsPositive: price ifFalse: [ self class signalPriceMustBePositive ].
	].
	
	self initializeWith: aPriceList.! !


!Floor methodsFor: 'totals' stamp: 'FRT 4/21/2024 14:49:55'!
totalRooms
	
	^ rooms size
		
! !

!Floor methodsFor: 'totals' stamp: 'MS 4/29/2024 19:14:10'!
totalRoomsAvailable
	
	^ rooms count: [ :room | room isAvailable ]
		
! !

!Floor methodsFor: 'totals' stamp: 'MS 4/29/2024 19:14:14'!
totalRoomsOccupied
	
	^ rooms count: [ :room | room isOccupied ]
		
! !

!Floor methodsFor: 'totals' stamp: 'MS 4/29/2024 19:14:22'!
totalRoomsReserved
	
	^ rooms count: [ :room | room isReserved ]! !


!Floor methodsFor: 'initialization' stamp: 'MS 4/29/2024 17:23:13'!
initializeRoomsWith: aNumberOfRooms

	rooms := OrderedCollection new.
	
	aNumberOfRooms timesRepeat: [rooms add: Room new].
	
! !

!Floor methodsFor: 'initialization' stamp: 'FRT 4/21/2024 00:23:52'!
initializeWith: aPriceList

	prices := aPriceList! !

!Floor methodsFor: 'initialization' stamp: 'MS 4/29/2024 19:13:31'!
receive: aGuestType atRoom: aRoomNumber

	| room |
	
	room := self roomAtNumber: aRoomNumber.

	room receive: aGuestType.! !

!Floor methodsFor: 'initialization' stamp: 'MS 4/29/2024 19:13:24'!
receiveWithReservation: aGuestType atRoom: aRoomNumber

	| room |
	
	room := self roomAtNumber: aRoomNumber.

	room receiveWithReservation: aGuestType.! !

!Floor methodsFor: 'initialization' stamp: 'MS 4/29/2024 19:13:11'!
reserveRoom: aRoomNumber

	| room | 
	
	room := self roomAtNumber: aRoomNumber.
	 
	room reserve.! !

!Floor methodsFor: 'initialization' stamp: 'MS 4/29/2024 19:12:44'!
roomAtNumber: aRoomNumber

	^ rooms at: aRoomNumber ifAbsent: [ self class signalRoomNumberDoesNotExist ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Floor class' category: 'ISW1-2024-1C-1erParcial'!
Floor class
	instanceVariableNames: ''!

!Floor class methodsFor: 'assertions' stamp: 'FRT 4/20/2024 19:39:26'!
assertIsInteger: aNumber ifFalse: signalsBlock

	aNumber isInteger ifFalse: signalsBlock! !

!Floor class methodsFor: 'assertions' stamp: 'FRT 4/20/2024 19:40:06'!
assertIsPositive: aNumber ifFalse: signalsBlock

	aNumber strictlyPositive ifFalse: signalsBlock! !


!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:02:53'!
numberOfRoomsMustBeIntegerErrorDescription
	
	^ 'Number of rooms must be integer'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:35:54'!
numberOfRoomsMustBePositiveErrorDescription
	
	^'The number of rooms must be positive'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:42:12'!
priceMustBeIntegerErrorDescription
	
	^ 'Price must be integer'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:42:25'!
priceMustBePositiveErrorDescription
	
	^'Price must be positive'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/21/2024 14:43:01'!
pricesListCannotBeEmptyErrorDescription 
	
	^ 'Prices List must not be empty'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/21/2024 14:47:30'!
unknownGuestTypeErrorDescription
	
	^ 'The guest type is unknown'! !


!Floor class methodsFor: 'exceptions' stamp: 'MS 4/29/2024 18:42:17'!
roomNumberDoesNotExistErrorDescription

	^ 'Room number does not exist'.! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/21/2024 14:42:33'!
signalNoPrices
	
	self error: self pricesListCannotBeEmptyErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:02:35'!
signalNumberOfRoomsMustBeInteger
	
	self error: self numberOfRoomsMustBeIntegerErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:35:54'!
signalNumberOfRoomsMustBePositive

	self error: self numberOfRoomsMustBePositiveErrorDescription! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:41:37'!
signalPriceMustBeInteger
	
	self error: self priceMustBeIntegerErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:41:58'!
signalPriceMustBePositive

	self error: self priceMustBePositiveErrorDescription! !

!Floor class methodsFor: 'exceptions' stamp: 'MS 4/29/2024 18:41:58'!
signalRoomNumberDoesNotExist

	self error: self roomNumberDoesNotExistErrorDescription.! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/21/2024 14:48:09'!
signalUnknownGuestType

	self error: self class unknownGuestTypeErrorDescription
! !


!classDefinition: #Hotel category: 'ISW1-2024-1C-1erParcial'!
Object subclass: #Hotel
	instanceVariableNames: 'floors availableRoomsCount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-1erParcial'!

!Hotel methodsFor: 'accounting' stamp: 'MS 4/29/2024 18:35:07'!
totalLosses

	^ floors sum: [ :aFloor | aFloor totalLosses ] ifEmpty: [0]! !

!Hotel methodsFor: 'accounting' stamp: 'MS 4/29/2024 18:25:14'!
totalProfits

	^ floors sum: [ :aFloor | aFloor totalProfits ] ifEmpty: [0]
! !


!Hotel methodsFor: 'initialization' stamp: 'FRT 4/20/2024 23:37:37'!
initialize

	availableRoomsCount := 0.
! !


!Hotel methodsFor: 'setters' stamp: 'FRT 4/22/2024 11:50:40'!
setFloors: aFloorsCollection

	self class assertHaveFloors: aFloorsCollection.

	floors := aFloorsCollection.
	
	availableRoomsCount := self totalRooms.! !


!Hotel methodsFor: 'totals' stamp: 'MS 4/29/2024 18:37:38'!
totalRooms
	
	^ floors sum: [ :aFloor | aFloor totalRooms ] ifEmpty: [0]
! !

!Hotel methodsFor: 'totals' stamp: 'FRT 4/22/2024 11:43:00'!
totalRoomsAvailable

	^ availableRoomsCount.
! !

!Hotel methodsFor: 'totals' stamp: 'MS 4/29/2024 19:08:14'!
totalRoomsOccupied

	^ floors sum: [ :aFloor | aFloor totalRoomsOccupied ] ifEmpty: [0]

! !

!Hotel methodsFor: 'totals' stamp: 'MS 4/29/2024 19:08:36'!
totalRoomsReserved

	^ floors sum: [ :aFloor | aFloor totalRoomsReserved ] ifEmpty: [0]! !


!Hotel methodsFor: 'testing' stamp: 'MS 4/29/2024 19:09:17'!
isEmpty

	^ self totalRoomsOccupied = 0
! !


!Hotel methodsFor: 'guests' stamp: 'MS 4/29/2024 19:06:01'!
decreaseAvailableRooms

	^ availableRoomsCount := availableRoomsCount - 1! !

!Hotel methodsFor: 'guests' stamp: 'MS 4/29/2024 19:10:11'!
floorAtNumber: aFloorNumber

	^ floors at: aFloorNumber ifAbsent:  [ self class signalFloorNumberDoesNotExist ].! !

!Hotel methodsFor: 'guests' stamp: 'MS 4/29/2024 19:10:11'!
receive: aGuestType atFloor: aFloorNumber atRoom: aRoomNumber

	| floor |
	
	floor := self floorAtNumber: aFloorNumber. 
	
	floor receive: aGuestType atRoom: aRoomNumber.
	
	self decreaseAvailableRooms.
! !

!Hotel methodsFor: 'guests' stamp: 'MS 4/29/2024 19:10:11'!
receiveWithReservation: aGuestType atFloor: aFloorNumber atRoom: aRoomNumber

	| floor |
	
	floor := self floorAtNumber: aFloorNumber.
	
	floor receiveWithReservation: aGuestType atRoom: aRoomNumber.

! !

!Hotel methodsFor: 'guests' stamp: 'MS 4/29/2024 19:10:11'!
reserveRoom: aRoomNumber atFloor: aFloorNumber

	| floor |
	
	floor := self floorAtNumber: aFloorNumber.
	
	floor reserveRoom: aRoomNumber.
	
	self decreaseAvailableRooms.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Hotel class' category: 'ISW1-2024-1C-1erParcial'!
Hotel class
	instanceVariableNames: ''!

!Hotel class methodsFor: 'assertions' stamp: 'HAW 4/29/2024 08:48:39'!
assertHaveFloors: aFloorsCollection

	aFloorsCollection isEmpty ifTrue: [ self signalNoFloors ].! !


!Hotel class methodsFor: 'error description' stamp: 'FRT 4/25/2024 21:42:02'!
floorNumberDoesNotExistErrorDescription

	^ 'Floor number does not exist'.! !

!Hotel class methodsFor: 'error description' stamp: 'FRT 4/20/2024 21:42:02'!
noFloorsErrorDescription

	^ 'Cannot have a Hotel without floors'! !


!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/25/2024 21:42:24'!
signalFloorNumberDoesNotExist

	self error: self floorNumberDoesNotExistErrorDescription.! !

!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 21:41:30'!
signalNoFloors

	self error: self noFloorsErrorDescription.! !


!classDefinition: #Room category: 'ISW1-2024-1C-1erParcial'!
Object subclass: #Room
	instanceVariableNames: 'guest roomState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-1erParcial'!

!Room methodsFor: 'guests' stamp: 'MS 4/29/2024 18:05:34'!
receive: aGuestType

	roomState receiveAGuest: aGuestType in: self.
! !

!Room methodsFor: 'guests' stamp: 'MS 4/29/2024 18:08:52'!
receiveWithReservation: aGuestType
	
	roomState receiveWithReservation: aGuestType in: self.
	! !

!Room methodsFor: 'guests' stamp: 'MS 4/29/2024 18:08:08'!
reserve

	roomState reserveRoom: self.
	
! !


!Room methodsFor: 'testing' stamp: 'MS 4/29/2024 17:42:29'!
isAvailable

	^ roomState isAvailable ! !

!Room methodsFor: 'testing' stamp: 'MS 4/29/2024 17:42:39'!
isOccupied

	^ roomState isOcuppied 
! !

!Room methodsFor: 'testing' stamp: 'MS 4/29/2024 17:42:47'!
isReserved

	^ roomState isReserved ! !


!Room methodsFor: 'initialization' stamp: 'MS 4/29/2024 17:38:33'!
initialize

	roomState := AvailableRoom new! !


!Room methodsFor: 'accounting' stamp: 'MS 4/29/2024 18:56:15'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	^ roomState lossUsing: aPriceList ifAbsent: unknownGuestTypeBlock 
! !

!Room methodsFor: 'accounting' stamp: 'MS 4/29/2024 18:06:50'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	^ roomState profitUsing: aPriceList ifAbsent: unknownGuestTypeBlock ! !


!Room methodsFor: 'room state changes' stamp: 'MS 4/29/2024 18:05:55'!
canReceiveAGuest: aGuestType 

	roomState := OccupiedRoom new withGuestType: aGuestType .! !

!Room methodsFor: 'room state changes' stamp: 'MS 4/29/2024 18:08:59'!
canReceiveWithReservation: aGuestType

	roomState := OccupiedRoom new withGuestType: aGuestType.! !

!Room methodsFor: 'room state changes' stamp: 'MS 4/29/2024 18:08:15'!
canReserve

	roomState := ReservedRoom new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Room class' category: 'ISW1-2024-1C-1erParcial'!
Room class
	instanceVariableNames: ''!

!Room class methodsFor: 'error messages' stamp: 'FRT 4/22/2024 09:01:14'!
roomIsNotEmptyErrorDescription

	^ 'Room is not empty.'! !

!Room class methodsFor: 'error messages' stamp: 'FRT 4/22/2024 09:01:43'!
roomIsNotReservedErrorDescription

	^ 'Room is not reserved.'! !


!classDefinition: #RoomState category: 'ISW1-2024-1C-1erParcial'!
Object subclass: #RoomState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-1erParcial'!

!RoomState methodsFor: 'testing' stamp: 'MS 4/29/2024 17:40:42'!
isAvailable

	self subclassResponsibility! !

!RoomState methodsFor: 'testing' stamp: 'MS 4/29/2024 17:40:39'!
isOcuppied

	self subclassResponsibility! !

!RoomState methodsFor: 'testing' stamp: 'MS 4/29/2024 17:40:30'!
isReserved

	self subclassResponsibility! !


!RoomState methodsFor: 'profit/loss' stamp: 'MS 4/29/2024 18:57:13'!
lossUsing: aPriceList ifAbsent: unknownGuestTypeBlock

	self subclassResponsibility! !

!RoomState methodsFor: 'profit/loss' stamp: 'MS 4/29/2024 17:59:36'!
profitUsing: aPriceList ifAbsent: unknownGuestTypeBlock

	self subclassResponsibility! !


!RoomState methodsFor: 'guests' stamp: 'MS 4/29/2024 17:45:16'!
receiveAGuest: aGuestType in: aRoom 

	self subclassResponsibility! !

!RoomState methodsFor: 'guests' stamp: 'MS 4/29/2024 17:52:37'!
receiveWithReservation: aGuestType in: aRoom

	self subclassResponsibility! !

!RoomState methodsFor: 'guests' stamp: 'MS 4/29/2024 17:49:07'!
reserveRoom: aRoom

	self subclassResponsibility! !


!classDefinition: #AvailableRoom category: 'ISW1-2024-1C-1erParcial'!
RoomState subclass: #AvailableRoom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-1erParcial'!

!AvailableRoom methodsFor: 'testing' stamp: 'MS 4/29/2024 17:40:53'!
isAvailable

	^ true! !

!AvailableRoom methodsFor: 'testing' stamp: 'MS 4/29/2024 17:41:28'!
isOcuppied

	^ false! !

!AvailableRoom methodsFor: 'testing' stamp: 'MS 4/29/2024 17:41:31'!
isReserved

	^ false! !


!AvailableRoom methodsFor: 'guests' stamp: 'MS 4/29/2024 17:45:27'!
receiveAGuest: aGuestType in: aRoom 

	aRoom canReceiveAGuest: aGuestType ! !

!AvailableRoom methodsFor: 'guests' stamp: 'MS 4/29/2024 17:53:08'!
receiveWithReservation: aGuestType in: aRoom

	self error: aRoom class roomIsNotReservedErrorDescription
! !

!AvailableRoom methodsFor: 'guests' stamp: 'MS 4/29/2024 17:49:37'!
reserveRoom: aRoom
	
	aRoom canReserve ! !


!AvailableRoom methodsFor: 'profit/loss' stamp: 'MS 4/29/2024 18:59:10'!
lossUsing: aPriceList ifAbsent: unknownGuestTypeBlock

	^ aPriceList values max ! !

!AvailableRoom methodsFor: 'profit/loss' stamp: 'MS 4/29/2024 17:59:54'!
profitUsing: aPriceList ifAbsent: unknownGuestTypeBlock 

	^ 0*peso! !


!classDefinition: #NotAvailable category: 'ISW1-2024-1C-1erParcial'!
RoomState subclass: #NotAvailable
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-1erParcial'!

!NotAvailable methodsFor: 'testing' stamp: 'MS 4/29/2024 18:12:34'!
isAvailable

	^ false! !

!NotAvailable methodsFor: 'testing' stamp: 'MS 4/29/2024 18:13:08'!
isOcuppied

	^ true! !

!NotAvailable methodsFor: 'testing' stamp: 'MS 4/29/2024 18:17:26'!
isReserved

	self subclassResponsibility! !


!NotAvailable methodsFor: 'guests' stamp: 'MS 4/29/2024 18:14:04'!
receiveAGuest: aGuestType in: aRoom 

	self error: aRoom class roomIsNotEmptyErrorDescription ! !

!NotAvailable methodsFor: 'guests' stamp: 'MS 4/29/2024 18:17:45'!
receiveWithReservation: aGuestType in: aRoom

	self subclassResponsibility! !

!NotAvailable methodsFor: 'guests' stamp: 'MS 4/29/2024 18:14:32'!
reserveRoom: aRoom
	
	self error: aRoom class roomIsNotEmptyErrorDescription
	! !


!NotAvailable methodsFor: 'profit/loss' stamp: 'MS 4/29/2024 18:58:42'!
lossUsing: aPriceList ifAbsent: unknownGuestTypeBlock

	^ 0 * peso! !

!NotAvailable methodsFor: 'profit/loss' stamp: 'MS 4/29/2024 18:17:40'!
profitUsing: aPriceList ifAbsent: unknownGuestTypeBlock

	self subclassResponsibility! !


!classDefinition: #OccupiedRoom category: 'ISW1-2024-1C-1erParcial'!
NotAvailable subclass: #OccupiedRoom
	instanceVariableNames: 'guestType'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-1erParcial'!

!OccupiedRoom methodsFor: 'initialization' stamp: 'MS 4/29/2024 18:04:23'!
withGuestType: aGuestType

	guestType := aGuestType 

	! !


!OccupiedRoom methodsFor: 'testing' stamp: 'MS 4/29/2024 17:47:01'!
isReserved

	^ false! !


!OccupiedRoom methodsFor: 'profit' stamp: 'MS 4/29/2024 18:04:33'!
profitUsing: aPriceList ifAbsent: unknownGuestTypeBlock 

	^ aPriceList at: guestType ifAbsent: unknownGuestTypeBlock! !


!OccupiedRoom methodsFor: 'guests' stamp: 'MS 4/29/2024 17:53:25'!
receiveWithReservation: aGuestType in: aRoom

	self error: aRoom class roomIsNotReservedErrorDescription 
! !


!classDefinition: #ReservedRoom category: 'ISW1-2024-1C-1erParcial'!
NotAvailable subclass: #ReservedRoom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-1erParcial'!

!ReservedRoom methodsFor: 'testing' stamp: 'MS 4/29/2024 17:42:09'!
isReserved

	^ true! !


!ReservedRoom methodsFor: 'profit' stamp: 'MS 4/29/2024 18:00:11'!
profitUsing: aPriceList ifAbsent: unknownGuestTypeBlock 

	^ aPriceList values min / 2! !


!ReservedRoom methodsFor: 'guests' stamp: 'MS 4/29/2024 17:54:01'!
receiveWithReservation: aGuestType in: aRoom

	 aRoom canReceiveWithReservation: aGuestType
	
	
! !
