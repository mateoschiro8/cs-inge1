!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/8/2024 15:12:51'!
test01RoverApuntandoNorteSeMueveParaAdelanteCorrectamente

	| rover initialPosition finalPosition commands |
	
	initialPosition := 1@1.
	finalPosition := 1@2.
	
	rover := MarsRover inPosition: initialPosition facing: #N.

	commands := #(#f).
	
	rover executeCommands: commands. 
	
	self assert: finalPosition equals: rover position  ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/8/2024 15:13:21'!
test02RoverApuntandoSurSeMueveParaAdelanteCorrectamente

	| rover initialPosition finalPosition commands |
	
	initialPosition := 1@1.
	finalPosition := 1@0.
	
	rover := MarsRover inPosition: initialPosition facing: #S.

	commands := #(#f).
	
	rover executeCommands: commands. 
	
	self assert: finalPosition equals: rover position  ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/8/2024 15:16:05'!
test03RoverApuntandoEsteSeMueveParaAdelanteCorrectamente

	| rover initialPosition finalPosition commands |
	
	initialPosition := 1@1.
	finalPosition := 2@1.
	
	rover := MarsRover inPosition: initialPosition facing: #E.

	commands := #(#f).
	
	rover executeCommands: commands. 
	
	self assert: finalPosition equals: rover position  ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/8/2024 15:17:10'!
test04RoverApuntandoOesteSeMueveParaAdelanteCorrectamente

	| rover initialPosition finalPosition commands |
	
	initialPosition := 1@1.
	finalPosition := 0@1.
	
	rover := MarsRover inPosition: initialPosition facing: #O.

	commands := #(#f).
	
	rover executeCommands: commands. 
	
	self assert: finalPosition equals: rover position  ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/8/2024 15:18:35'!
test05RoverApuntandoNorteSeMueveParaAtrasCorrectamente

	| rover initialPosition finalPosition commands |
	
	initialPosition := 1@1.
	finalPosition := 1@0.
	
	rover := MarsRover inPosition: initialPosition facing: #N.

	commands := #(#b).
	
	rover executeCommands: commands. 
	
	self assert: finalPosition equals: rover position  ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/8/2024 15:21:28'!
test06RoverApuntandoSurSeMueveParaAtrasCorrectamente

	| rover initialPosition finalPosition commands |
	
	initialPosition := 1@1.
	finalPosition := 1@2.
	
	rover := MarsRover inPosition: initialPosition facing: #S.

	commands := #(#b).
	
	rover executeCommands: commands. 
	
	self assert: finalPosition equals: rover position  ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/8/2024 15:21:57'!
test07RoverApuntandoEsteSeMueveParaAtrasCorrectamente

	| rover initialPosition finalPosition commands |
	
	initialPosition := 1@1.
	finalPosition := 0@1.
	
	rover := MarsRover inPosition: initialPosition facing: #E.

	commands := #(#b).
	
	rover executeCommands: commands. 
	
	self assert: finalPosition equals: rover position  ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/8/2024 15:23:23'!
test08RoverApuntandoOesteSeMueveParaAtrasCorrectamente

	| rover initialPosition finalPosition commands |
	
	initialPosition := 1@1.
	finalPosition := 2@1.
	
	rover := MarsRover inPosition: initialPosition facing: #O.

	commands := #(#b).
	
	rover executeCommands: commands. 
	
	self assert: finalPosition equals: rover position  ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/8/2024 15:44:54'!
test09RoverRotaDerechaCorrectamente

	| rover initialOrientation finalOrientation commands |
	
	initialOrientation := #N.
	finalOrientation := #E.
	
	rover := MarsRover inPosition: 1@1 facing: initialOrientation.

	commands := #(#r).
	
	rover executeCommands: commands. 
	
	self assert: finalOrientation equals: rover orientation ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/8/2024 15:52:32'!
test10RoverRotaIzquierdaCorrectamente

	| rover initialOrientation finalOrientation commands |
	
	initialOrientation := #N.
	finalOrientation := #O.
	
	rover := MarsRover inPosition: 1@1 facing: initialOrientation.

	commands := #(#l).
	
	rover executeCommands: commands. 
	
	self assert: finalOrientation equals: rover orientation ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/8/2024 15:57:51'!
test11RoverRotaYAvanzaCorrectamente

	| rover initialPosition finalPosition initialOrientation finalOrientation commands |
	
	initialPosition := 1@1.
	initialOrientation := #N.
	
	finalPosition := 2@1.
	finalOrientation := #E.
	
	rover := MarsRover inPosition: initialPosition facing: initialOrientation.

	commands := #(#r #f).
	
	rover executeCommands: commands. 
	
	self assert: finalPosition equals: rover position. 
	self assert: finalOrientation equals: rover orientation ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/8/2024 16:02:31'!
test12ComandoErroneoDetieneEjecucion

	| rover initialPosition finalPosition initialOrientation finalOrientation commands |
	
	initialPosition := 1@1.
	initialOrientation := #N.
	
	finalPosition := 1@1.
	finalOrientation := #E.
	
	rover := MarsRover inPosition: initialPosition facing: initialOrientation.

	commands := #(#r #z #f).
	
	rover executeCommands: commands. 

	self assert: finalPosition equals: rover position. 
	self assert: finalOrientation equals: rover orientation ! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition currentState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'MS 5/8/2024 15:28:42'!
initializeInPosition: anInitialPosition facing: aCardinalPoint 
	
	currentPosition := anInitialPosition.
	currentState := MarsRoverState facing: aCardinalPoint 
	! !


!MarsRover methodsFor: 'status' stamp: 'MS 5/8/2024 15:47:04'!
orientation
	
	^ currentState cardinalPointFacing! !

!MarsRover methodsFor: 'status' stamp: 'MS 5/8/2024 15:10:59'!
position
	
	^ currentPosition ! !

!MarsRover methodsFor: 'status' stamp: 'MS 5/8/2024 15:51:50'!
updateStateToFace: aNewCardinalPointToFace

	currentState := MarsRoverState facing: aNewCardinalPointToFace ! !


!MarsRover methodsFor: 'command execution' stamp: 'MS 5/8/2024 16:13:22'!
executeCommands: aSequenceOfCommands 
	
	aSequenceOfCommands do: [ :aCommand | 
								aCommand = #f
									ifTrue: [ currentState moveRoverForwards: self. ].
								aCommand = #b
									ifTrue: [ currentState moveRoverBackwards: self. ].
								aCommand = #r
									ifTrue: [ currentState rotateRoverTowardsRight: self. ].
								aCommand = #l
									ifTrue: [ currentState rotateRoverTowardsLeft: self. ].
								(self isNotValid: aCommand) 
									ifTrue: [ ^ aCommand]
																				]! !

!MarsRover methodsFor: 'command execution' stamp: 'MS 5/8/2024 16:12:08'!
isNotValid: aCommand 

	^ ( (aCommand = #f) | (aCommand = #b) | (aCommand = #r) | (aCommand = #l)) not! !


!MarsRover methodsFor: 'movement' stamp: 'MS 5/8/2024 15:40:40'!
moveBackwardsFacingEste
	
	currentPosition := (currentPosition x - 1)@(currentPosition y)! !

!MarsRover methodsFor: 'movement' stamp: 'MS 5/8/2024 15:40:08'!
moveBackwardsFacingNorte
	
	currentPosition := (currentPosition x)@(currentPosition y - 1)! !

!MarsRover methodsFor: 'movement' stamp: 'MS 5/8/2024 15:40:56'!
moveBackwardsFacingOeste
	
	currentPosition := (currentPosition x + 1)@(currentPosition y)! !

!MarsRover methodsFor: 'movement' stamp: 'MS 5/8/2024 15:40:21'!
moveBackwardsFacingSur
	
	currentPosition := (currentPosition x)@(currentPosition y + 1)! !

!MarsRover methodsFor: 'movement' stamp: 'MS 5/8/2024 15:39:22'!
moveForwardsFacingEste

	currentPosition := (currentPosition x + 1)@(currentPosition y)! !

!MarsRover methodsFor: 'movement' stamp: 'MS 5/8/2024 15:38:44'!
moveForwardsFacingNorte
	
	currentPosition := (currentPosition x)@(currentPosition y + 1)! !

!MarsRover methodsFor: 'movement' stamp: 'MS 5/8/2024 15:39:37'!
moveForwardsFacingOeste
	
	currentPosition := (currentPosition x - 1)@(currentPosition y)! !

!MarsRover methodsFor: 'movement' stamp: 'MS 5/8/2024 15:39:06'!
moveForwardsFacingSur
	
	currentPosition := (currentPosition x)@(currentPosition y - 1)
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MS 5/8/2024 15:08:20'!
inPosition: anInitialPosition facing: aCardinalPoint 
		
	^self new initializeInPosition: anInitialPosition facing: aCardinalPoint ! !


!classDefinition: #MarsRoverState category: #MarsRover!
Object subclass: #MarsRoverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverState methodsFor: 'movement' stamp: 'MS 5/8/2024 15:32:20'!
moveRoverBackwards: aMarsRover

	self subclassResponsibility! !

!MarsRoverState methodsFor: 'movement' stamp: 'MS 5/8/2024 15:32:04'!
moveRoverForwards: aMarsRover

	self subclassResponsibility! !

!MarsRoverState methodsFor: 'movement' stamp: 'MS 5/8/2024 15:42:22'!
rotateRoverTowardsLeft: aMarsRover

	self subclassResponsibility! !

!MarsRoverState methodsFor: 'movement' stamp: 'MS 5/8/2024 15:42:25'!
rotateRoverTowardsRight: aMarsRover

	self subclassResponsibility! !


!MarsRoverState methodsFor: 'cardinal point' stamp: 'MS 5/8/2024 15:47:48'!
cardinalPointFacing

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverState class' category: #MarsRover!
MarsRoverState class
	instanceVariableNames: ''!

!MarsRoverState class methodsFor: 'instance creation' stamp: 'MS 5/8/2024 15:37:44'!
facing: aCardinalPoint 
	
	aCardinalPoint = #N
		ifTrue: [^RoverFacingNorte new].
	aCardinalPoint = #S
		ifTrue: [^RoverFacingSur new].
	aCardinalPoint = #E
		ifTrue: [^RoverFacingEste new].
	aCardinalPoint = #O
		ifTrue: [^RoverFacingOeste new].
	
	
	! !


!classDefinition: #RoverFacingEste category: #MarsRover!
MarsRoverState subclass: #RoverFacingEste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverFacingEste methodsFor: 'cardinal point' stamp: 'MS 5/8/2024 15:47:59'!
cardinalPointFacing
	
	^#E
	! !


!RoverFacingEste methodsFor: 'movement' stamp: 'MS 5/8/2024 15:32:55'!
moveRoverBackwards: aMarsRover

	aMarsRover moveBackwardsFacingEste! !

!RoverFacingEste methodsFor: 'movement' stamp: 'MS 5/8/2024 15:32:40'!
moveRoverForwards: aMarsRover

	aMarsRover moveForwardsFacingEste! !

!RoverFacingEste methodsFor: 'movement' stamp: 'MS 5/8/2024 15:53:13'!
rotateRoverTowardsLeft: aMarsRover

	aMarsRover updateStateToFace: #N! !

!RoverFacingEste methodsFor: 'movement' stamp: 'MS 5/8/2024 15:50:35'!
rotateRoverTowardsRight: aMarsRover

	aMarsRover updateStateToFace: #S! !


!classDefinition: #RoverFacingNorte category: #MarsRover!
MarsRoverState subclass: #RoverFacingNorte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverFacingNorte methodsFor: 'cardinal point' stamp: 'MS 5/8/2024 15:48:04'!
cardinalPointFacing
	
	^#N
	! !


!RoverFacingNorte methodsFor: 'movement' stamp: 'MS 5/8/2024 15:33:12'!
moveRoverBackwards: aMarsRover

	aMarsRover moveBackwardsFacingNorte! !

!RoverFacingNorte methodsFor: 'movement' stamp: 'MS 5/8/2024 15:33:24'!
moveRoverForwards: aMarsRover

	aMarsRover moveForwardsFacingNorte! !

!RoverFacingNorte methodsFor: 'movement' stamp: 'MS 5/8/2024 15:53:18'!
rotateRoverTowardsLeft: aMarsRover

	aMarsRover updateStateToFace: #O! !

!RoverFacingNorte methodsFor: 'movement' stamp: 'MS 5/8/2024 15:50:44'!
rotateRoverTowardsRight: aMarsRover

	aMarsRover updateStateToFace: #E! !


!classDefinition: #RoverFacingOeste category: #MarsRover!
MarsRoverState subclass: #RoverFacingOeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverFacingOeste methodsFor: 'cardinal point' stamp: 'MS 5/8/2024 15:48:08'!
cardinalPointFacing
	
	^#O
	! !


!RoverFacingOeste methodsFor: 'movement' stamp: 'MS 5/8/2024 15:33:41'!
moveRoverBackwards: aMarsRover

	aMarsRover moveBackwardsFacingOeste! !

!RoverFacingOeste methodsFor: 'movement' stamp: 'MS 5/8/2024 15:33:53'!
moveRoverForwards: aMarsRover

	aMarsRover moveForwardsFacingOeste! !

!RoverFacingOeste methodsFor: 'movement' stamp: 'MS 5/8/2024 15:53:23'!
rotateRoverTowardsLeft: aMarsRover

	aMarsRover updateStateToFace: #S! !

!RoverFacingOeste methodsFor: 'movement' stamp: 'MS 5/8/2024 15:50:49'!
rotateRoverTowardsRight: aMarsRover
	
	aMarsRover updateStateToFace: #N! !


!classDefinition: #RoverFacingSur category: #MarsRover!
MarsRoverState subclass: #RoverFacingSur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverFacingSur methodsFor: 'cardinal point' stamp: 'MS 5/8/2024 15:48:16'!
cardinalPointFacing

	^#S
	
	! !


!RoverFacingSur methodsFor: 'movement' stamp: 'MS 5/8/2024 15:34:10'!
moveRoverBackwards: aMarsRover

	aMarsRover moveBackwardsFacingSur! !

!RoverFacingSur methodsFor: 'movement' stamp: 'MS 5/8/2024 15:34:23'!
moveRoverForwards: aMarsRover

	aMarsRover moveForwardsFacingSur! !

!RoverFacingSur methodsFor: 'movement' stamp: 'MS 5/8/2024 15:53:52'!
rotateRoverTowardsLeft: aMarsRover

	aMarsRover updateStateToFace: #E! !

!RoverFacingSur methodsFor: 'movement' stamp: 'MS 5/8/2024 15:50:56'!
rotateRoverTowardsRight: aMarsRover

	aMarsRover updateStateToFace: #O! !
