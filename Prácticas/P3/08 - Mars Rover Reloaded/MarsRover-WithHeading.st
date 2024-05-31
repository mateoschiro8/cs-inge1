!classDefinition: #MarsRoverLogTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'fb 5/27/2024 21:28:35'!
test01LogStartsEmpty

	| aLogger aMarsRover |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogger := Logger for: aMarsRover.
	
	self assert: (aLogger log) isEmpty. ! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'fb 5/27/2024 21:30:32'!
test02MovingForwardLogsCorrectly

	| aLogger aMarsRover |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogger := Logger for: aMarsRover.
	aMarsRover moveForward.
	
	self assert: (aLogger log) equals: (OrderedCollection with: 0@1).! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'fb 5/29/2024 15:50:25'!
test03LogStartedAfterMovementDoesNotLog

	| aLogger aMarsRover |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aMarsRover moveForward.
	aLogger := Logger for: aMarsRover.
	
	self assert: (aLogger log) equals: (OrderedCollection new).! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'fb 5/29/2024 15:58:49'!
test04LeftRotationLogsCorrectly

	| aLogger aMarsRover |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogger := Logger for: aMarsRover.
	aMarsRover rotateLeft.
	
	self assert: (aLogger log) equals: (OrderedCollection with: #West).! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'fb 5/29/2024 16:07:51'!
test05LeftRotationAndMoveForwardLogsCorrectly

	| aLogger aMarsRover |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogger := Logger for: aMarsRover.
	aMarsRover rotateLeft.
	aMarsRover moveForward.

	self assert: (aLogger log) equals: (OrderedCollection with: #West with: -1@0).! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'fb 5/29/2024 16:09:07'!
test06LeftRotationAndMoveForwardPositionLogOnlyHasPosition

	| aLogger aMarsRover |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogger := Logger for: aMarsRover.
	aMarsRover rotateLeft.
	aMarsRover moveForward.

	self assert: (aLogger positionsLog) equals: (OrderedCollection with: -1@0).! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'fb 5/29/2024 16:09:58'!
test07LeftRotationAndMoveForwardHeadLogOnlyHasHead

	| aLogger aMarsRover |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogger := Logger for: aMarsRover.
	aMarsRover rotateLeft.
	aMarsRover moveForward.

	self assert: (aLogger headsLog) equals: (OrderedCollection with: #West).! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'fb 5/29/2024 16:12:32'!
test08TwoLoggersStartedAtDifferentTimeLogCorrectly

	| aLogger aMarsRover aSeccondLogger |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aLogger := Logger for: aMarsRover.
	aMarsRover rotateLeft.
	aSeccondLogger := Logger for: aMarsRover.
	aMarsRover moveForward.

	self assert: (aLogger log) equals: (OrderedCollection with: #West with: -1@0).
	self assert: (aSeccondLogger log) equals: (OrderedCollection with: -1@0).
! !


!classDefinition: #MarsRoverTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRoverWindowTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'fb 5/29/2024 16:20:33'!
test01NewMarsRoverWindowReportsCorrectly

	| aWindow aMarsRover |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aWindow := Window for: aMarsRover.
	
	self assert: (aWindow currentState) equals: (Set with: 0@0 with: #North).
	! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'fb 5/29/2024 16:42:04'!
test02MarsRoverMovesForwardWindowReportsCorrectly

	| aWindow aMarsRover |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aWindow := Window for: aMarsRover.
	aMarsRover moveForward.
	
	self assert: (aWindow currentState) equals: (Set with: 0@1 with: #North).
	! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'fb 5/29/2024 16:43:58'!
test03MarsRoverRotatesLeftAndMovesForwardWindowReportsCorrectly

	| aWindow aMarsRover |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aWindow := Window for: aMarsRover.
	aMarsRover rotateLeft.
	aMarsRover moveForward.
	
	self assert: (aWindow currentState) equals: (Set with: -1@0 with: #West).
	! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'fb 5/29/2024 16:44:45'!
test04MarsRoverRotatesLeftAndMovesForwardPositionWindowReportsCorrectly

	| aWindow aMarsRover |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aWindow := Window for: aMarsRover.
	aMarsRover rotateLeft.
	aMarsRover moveForward.
	
	self assert: (aWindow currentPosition) equals: (Set with: -1@0).
	! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'fb 5/29/2024 16:45:37'!
test05MarsRoverRotatesLeftAndMovesForwardHeadWindowReportsCorrectly

	| aWindow aMarsRover |
	
	aMarsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	aWindow := Window for: aMarsRover.
	aMarsRover rotateLeft.
	aMarsRover moveForward.
	
	self assert: (aWindow currentHead) equals: (Set with: #West).
	! !


!classDefinition: #MarsRover category: #'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'fb 5/29/2024 15:38:28'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	observer := MarsRoverObserver new.! !


!MarsRover methodsFor: 'heading' stamp: 'fb 5/29/2024 16:02:05'!
headEast
	
	head := MarsRoverHeadingEast for: self.
	observer broadcastHeadUpdate: #East. ! !

!MarsRover methodsFor: 'heading' stamp: 'fb 5/29/2024 16:02:17'!
headNorth
	
	head := MarsRoverHeadingNorth for: self.
	observer broadcastHeadUpdate: #North. ! !

!MarsRover methodsFor: 'heading' stamp: 'fb 5/29/2024 16:02:28'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
	observer broadcastHeadUpdate: #South. ! !

!MarsRover methodsFor: 'heading' stamp: 'fb 5/29/2024 16:02:43'!
headWest
	
	head := MarsRoverHeadingWest for: self.
	observer broadcastHeadUpdate: #West.  ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'fb 5/29/2024 15:48:44'!
moveEast
	
	position := position + (1@0).
	observer broadcastPositionUpdate: position.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'fb 5/29/2024 15:48:44'!
moveNorth
	
	position := position + (0@1).
	observer broadcastPositionUpdate: position.	! !

!MarsRover methodsFor: 'moving' stamp: 'fb 5/29/2024 15:48:44'!
moveSouth
	
	position := position + (0@-1).
	observer broadcastPositionUpdate: position.! !

!MarsRover methodsFor: 'moving' stamp: 'fb 5/29/2024 15:48:44'!
moveWest
	
	position := position + (-1@0).
	observer broadcastPositionUpdate: position.! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'tracking' stamp: 'fb 5/29/2024 16:27:54'!
addLogger: aLogger

	observer addSuscriber: aLogger.! !

!MarsRover methodsFor: 'tracking' stamp: 'fb 5/29/2024 16:38:34'!
addWindow: aWindow

	observer addSuscriber: aWindow.
	aWindow initializePosition: position andHead: head symbol. 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

!MarsRoverHeading methodsFor: 'initialization' stamp: 'fb 5/29/2024 16:38:50'!
symbol

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: #'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'initialization' stamp: 'fb 5/29/2024 16:39:01'!
symbol

	^ #East! !


!classDefinition: #MarsRoverHeadingNorth category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'initialization' stamp: 'fb 5/29/2024 16:39:08'!
symbol

	^ #North! !


!classDefinition: #MarsRoverHeadingSouth category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'initialization' stamp: 'fb 5/29/2024 16:39:16'!
symbol

	^ #South! !


!classDefinition: #MarsRoverHeadingWest category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'initialization' stamp: 'fb 5/29/2024 16:39:24'!
symbol

	^ #West! !


!classDefinition: #MarsRoverObserver category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: 'suscribers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'broadcasting' stamp: 'fb 5/29/2024 16:03:25'!
broadcastHeadUpdate: aHead

	suscribers do: [:aSuscriber | aSuscriber notifyHeadUpdate: aHead].! !

!MarsRoverObserver methodsFor: 'broadcasting' stamp: 'fb 5/29/2024 15:48:44'!
broadcastPositionUpdate: aPosition

	suscribers do: [:aSuscriber | aSuscriber notifyPositionUpdate: aPosition].! !


!MarsRoverObserver methodsFor: 'suscribers' stamp: 'fb 5/29/2024 16:26:53'!
addSuscriber: aSuscriber

	suscribers add: aSuscriber.! !


!MarsRoverObserver methodsFor: 'initialization' stamp: 'fb 5/29/2024 15:37:55'!
initialize

	suscribers := OrderedCollection new.! !


!classDefinition: #MarsRoverTracker category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverTracker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTracker methodsFor: 'updates' stamp: 'fb 5/29/2024 16:51:51'!
notifyHeadUpdate: aHead

	self subclassResponsibility! !

!MarsRoverTracker methodsFor: 'updates' stamp: 'fb 5/29/2024 16:51:56'!
notifyPositionUpdate: aPosition

	self subclassResponsibility! !


!classDefinition: #Logger category: #'MarsRover-WithHeading'!
MarsRoverTracker subclass: #Logger
	instanceVariableNames: 'fullLog positionsLog headsLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Logger methodsFor: 'tracking' stamp: 'fb 5/29/2024 16:10:16'!
headsLog

	^headsLog! !

!Logger methodsFor: 'tracking' stamp: 'fb 5/29/2024 16:00:57'!
log

	^fullLog.! !

!Logger methodsFor: 'tracking' stamp: 'fb 5/29/2024 16:09:16'!
positionsLog

	^positionsLog! !


!Logger methodsFor: 'initialization' stamp: 'fb 5/29/2024 16:51:37'!
initializeFor: aMarsRover 
	
	fullLog  := OrderedCollection new.
	positionsLog := OrderedCollection new.
	headsLog := OrderedCollection new.
	
	aMarsRover addLogger: self.! !


!Logger methodsFor: 'updates' stamp: 'fb 5/29/2024 16:04:46'!
notifyHeadUpdate:aHead
	
	fullLog addLast: aHead.
	headsLog addLast: aHead.! !

!Logger methodsFor: 'updates' stamp: 'fb 5/29/2024 16:05:37'!
notifyPositionUpdate: aPosition
	
	fullLog addLast: aPosition.
	positionsLog addLast: aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Logger class' category: #'MarsRover-WithHeading'!
Logger class
	instanceVariableNames: ''!

!Logger class methodsFor: 'category-name' stamp: 'fb 5/27/2024 21:28:00'!
for: aMarsRover 
	^ self new initializeFor: aMarsRover ! !


!classDefinition: #Window category: #'MarsRover-WithHeading'!
MarsRoverTracker subclass: #Window
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'initialization' stamp: 'fb 5/29/2024 16:25:57'!
initializeFor: aMarsRover 

	aMarsRover addWindow: self.! !

!Window methodsFor: 'initialization' stamp: 'fb 5/29/2024 16:31:43'!
initializePosition: aPosition andHead: aHead

	position := aPosition.
	heading  := aHead.! !


!Window methodsFor: 'tracking' stamp: 'fb 5/29/2024 16:45:51'!
currentHead
	
	^ Set with: heading. ! !

!Window methodsFor: 'tracking' stamp: 'fb 5/29/2024 16:45:07'!
currentPosition
	
	^ Set with: position.! !

!Window methodsFor: 'tracking' stamp: 'fb 5/29/2024 16:37:10'!
currentState

	^Set with: position with: heading.! !


!Window methodsFor: 'updates' stamp: 'fb 5/29/2024 16:44:13'!
notifyHeadUpdate: aHead 

	heading := aHead.! !

!Window methodsFor: 'updates' stamp: 'fb 5/29/2024 16:42:28'!
notifyPositionUpdate: aPosition 
	
	position := aPosition ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Window class' category: #'MarsRover-WithHeading'!
Window class
	instanceVariableNames: ''!

!Window class methodsFor: 'instance creation' stamp: 'fb 5/29/2024 16:20:56'!
for: aMarsRover 

	^self new initializeFor: aMarsRover ! !
