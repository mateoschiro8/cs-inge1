!classDefinition: #FormulaOneTest category: '1c2022 - Resolucion'!
TestCase subclass: #FormulaOneTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 4/30/2022 18:38:56'!
test01SectorLengthMustBePositive

	self 
		should: [ Sector withTurboOf: 0 * kilometer.]
		raise: Error
		withMessageText: Sector lengthMustBePositiveErrorDescription! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:16:07'!
test02ACarCanNotBePlacedInAKilometerGreaterThanSectorLength

	| sector  outside car |
	
	sector _ Sector withTurboOf: 10 * kilometer.
	outside _ sector length + (1 * millimeter).
	car _ FormulaOneCar drivenBy: #Schumacher.
	
	self 
		should: [ sector put: car at: outside ] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Sector cannotPlacedCarErrorDescription equals: error messageText.
			self deny: (sector includes: car) ]	
! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:16:07'!
test03CarCannotActivateTurboInNonTurboSector

	| car sector |

	sector _ Sector withoutTurboOf: 10*kilometer.
	car _ FormulaOneCar drivenBy: #Schumacher.
	
	sector atStartPut: car.
	
	self should: [ car activateTurbo ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: Sector turboNotAllowedErrorDescription equals: error messageText.
			self deny: car isTurboActivated]
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:16:20'!
test04CarCannotActivateTurboWhenNoCarAhead

	| schumacher hamilton sector |
	
	sector _ Sector withTurboOf: 20 * kilometer.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.
	
	sector put: schumacher at: 12 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	self 
		should: [ hamilton activateTurbo]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:exception |
			self assert: Sector cannotActivateTurboWhenNoCarAheadErrorDescription equals: exception messageText. 
			self deny: hamilton isTurboActivated ]! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:16:26'!
test05CarCanActivateTurboWhenLessThanASecondBehindAnotherCar

	| schumacher hamilton sector |
	
	sector _ Sector withTurboOf: 24 * kilometer.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.
	
	schumacher speed: 300 * kilometer / hour.
	hamilton speed: 300 * kilometer / hour.
	
	sector put: schumacher at: 12.95 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	schumacher activateTurbo.
	
	self assert: schumacher isTurboActivated
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:16:35'!
test06CarCannotActivateTurboWhenMoreThanASecondBehindAnotherCar

	| schumacher hamilton sector |
	
	sector _ Sector withTurboOf: 24 * kilometer.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.
	
	schumacher speed: 300 * kilometer / hour.
	hamilton speed: 300 * kilometer / hour.
	
	sector put: schumacher at: 12.9 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	self should: [schumacher activateTurbo]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self 
				assert: Sector cannotActivateTurboWhenMoreThanASecondBehindAnotherCarErrorDescription 
				equals: error messageText.
			self deny: schumacher isTurboActivated]
			! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:16:40'!
test07TrackMustHaveSectors

	self
		should: [ Track withSectors: #() ]
		raise: Error
		withMessageText: Track mustHaveSectorsErrorDescription! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:16:46'!
test08TheLengthOfATrackShouldBeTheSumOfItsSectors

	| sectors track |
	
	sectors _ OrderedCollection 
		with: (Sector withTurboOf: 10 * kilometer)
		with: (Sector withoutTurboOf: 20 * kilometer).
	track _ Track withSectors: sectors.
	
	self assert: 30 * kilometer equals: 	track length! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:23:36'!
test09ACarCanNotBePlacedInAKilometerGreaterThanTrackLength

	| sectors track car outside |
	
	sectors _ OrderedCollection 
		with: (Sector withTurboOf: 10 * kilometer)
		with: (Sector withoutTurboOf: 20 * kilometer).
	
	track _ Track withSectors: sectors.
	outside _ track length + (1 * millimeter).
	car _ FormulaOneCar drivenBy: #Schumacher.
	
	self should: [ track put: car at: outside ] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Track cannotPlacedCarErrorDescription equals: error messageText.
			self deny: (track includes: car) ]	
! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:24:51'!
test10TrackShouldPlaceCarInKilometerWithinSector

	| sectors track car positionInTrack positionInSector2 |
	
	sectors _ OrderedCollection 
		with: (Sector withTurboOf: 10 * kilometer)
		with: (Sector withoutTurboOf: 20 * kilometer).
		
	positionInSector2 _ 5 * kilometer.
	positionInTrack _ sectors first length + positionInSector2.
	
	track _ Track withSectors: sectors.
	car _ FormulaOneCar drivenBy: #Schumacher.

	track put: car at: positionInTrack.
	
	self assert: sectors second equals: (track sectorOf: car).
	self assert: positionInTrack equals: (track positionOf: car).
	
	self deny: (sectors first includes: car).
	self assert: (sectors second includes: car).

! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:25:15'!
test11TrackShouldKnowCarsInRunning

	| sectors track car1 car2 |
	
	sectors _ OrderedCollection 
		with: (Sector withTurboOf: 10 * kilometer)
		with: (Sector withoutTurboOf: 20 * kilometer).
		
	track _ Track withSectors: sectors.
	car1 _ FormulaOneCar drivenBy: #Schumacher.
	car2 _ FormulaOneCar drivenBy: #Verstappen.

	track put: car1 at: 10 * kilometer.
	track put: car2 at: 30 * kilometer.
	
	self assert: (track includes: car1).
	self assert: (track includes: car2).
		
	self assert: (sectors first includes: car1).
	self assert: (sectors second includes: car2).

! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:25:37'!
test12CarCannotBeInMoreThanOneSectorAtATime

	| sectors track car |
	
	sectors _ OrderedCollection 
		with: (Sector withTurboOf: 10 * kilometer)
		with: (Sector withoutTurboOf: 20 * kilometer).
	
	track _ Track withSectors: sectors.
	car _ FormulaOneCar drivenBy: #Schumacher.

	track put: car at: 5 * kilometer.
	track put: car at: 15 * kilometer.
	
	self assert: sectors second equals: (track sectorOf: car).
	self deny: (sectors first includes: car).
	self assert: (sectors second includes: car)
! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:26:29'!
test13GrandPrixLengthShouldBeTrackLengthTimesNumberOfLaps

	| track grandPrix numberOfLaps |
	
	track _ Track withSectors: (OrderedCollection 
		with: (Sector withTurboOf: 10 * kilometer)
		with: (Sector withoutTurboOf: 20 * kilometer)).
	numberOfLaps _ 100.
	
	grandPrix _ GrandPrix on: track running: numberOfLaps.
	
	self assert: track length * numberOfLaps	 equals: grandPrix length
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:17:14'!
test14TwoCarsCanBeAtTheSameDistanceFromStart

	| grandPrix hamilton verstappen |
	
	grandPrix _ GrandPrix 
		on: (Track withSectors: (OrderedCollection with: (Sector withTurboOf: 10 * kilometer)))
		running: 100.
	
	verstappen _ FormulaOneCar drivenBy: #Verstappen.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.	
	
	grandPrix put: verstappen at: 5 * kilometer.
	grandPrix put: hamilton at: 5 * kilometer.
	
	self assert: 5 * kilometer equals: (grandPrix locationOf: verstappen). 
	self assert:  5 * kilometer equals: (grandPrix locationOf: hamilton). 
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:17:18'!
test15ACarStoppedShouldNotMoveAfterSomeTime

	| grandPrix verstappen |
	
	verstappen _ FormulaOneCar drivenBy: #Verstappen.
	verstappen speed: 0 * kilometer / hour.
	
	grandPrix _ GrandPrix 
		on: (Track withSectors: (OrderedCollection with: (Sector withTurboOf: 10 * kilometer)))
		running: 100
		with: (Set with: verstappen).
	
	grandPrix put: verstappen at: 5 * kilometer.
	grandPrix advance: 10 * minute.
	
	self assert: 5 * kilometer equals: (grandPrix locationOf: verstappen) 
	
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:27:57'!
test16ACarSpeedingShouldMoveAfterSomeTime

	| grandPrix verstappen sectors |
	
	verstappen _ FormulaOneCar drivenBy: #Verstappen.
	verstappen speed: 0* kilometer / hour.
	
	sectors _ OrderedCollection 
		with: (Sector withTurboOf: 10 * kilometer)
		with: (Sector withoutTurboOf: 20 * kilometer).
	
	grandPrix _ GrandPrix 
		on: (Track withSectors: sectors)
		running: 100
		with: (Set with: verstappen).
	
	grandPrix put: verstappen at: 0 * kilometer.
	verstappen speed: 300 * kilometer / hour.
	grandPrix advance: 1 * hour.
	
	self assert: 300 * kilometer equals: (grandPrix locationOf: verstappen). 
	
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:28:20'!
test17GrandPrixKnowsSectorOfCar

	| grandPrix verstappen sectors |
	
	verstappen _ FormulaOneCar drivenBy: #Verstappen.
	
	sectors _ OrderedCollection 
		with: (Sector withTurboOf: 10 * kilometer)
		with: (Sector withoutTurboOf: 20 * kilometer).
	
	grandPrix _ GrandPrix 
		on: (Track withSectors: sectors)
		running: 100
		with: (Set with: verstappen).
		
	grandPrix put: verstappen at: 5 * kilometer.
	
	self assert: 5 * kilometer equals: (grandPrix locationOf: verstappen). 
	self assert: sectors first equals: (grandPrix sectorOf: verstappen).
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:29:34'!
test18GrandPrixKnowsSectorOfCarAfterSomeTime

	| grandPrix verstappen sectors |
	
	verstappen _ FormulaOneCar drivenBy: #Verstappen.
	
	sectors _ OrderedCollection 
		with: (Sector withTurboOf: 10 * kilometer)
		with: (Sector withoutTurboOf: 20 * kilometer).
	
	grandPrix _ GrandPrix 
		on: (Track withSectors: sectors)
		running: 100
		with: (Set with: verstappen).
		
	grandPrix put: verstappen at: 0 * kilometer.
	
	verstappen speed: 5 * kilometer / hour. ":)"
	grandPrix advance: 1 * hour.
	
	self assert: 5 * kilometer equals: (grandPrix locationOf: verstappen). 
	self assert: sectors first equals: (grandPrix sectorOf: verstappen).
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:17:40'!
test19GrandPrixMovesCarsBetweenSectors

	| grandPrix verstappen sectorA sectorB |
	
	verstappen _ FormulaOneCar drivenBy: #Verstappen.
	sectorA _ Sector withTurboOf: 10 * kilometer.
	sectorB _ Sector withTurboOf: 30 * kilometer.
	
	grandPrix _ GrandPrix 
		on: (Track withSectors: (OrderedCollection with: sectorA with: sectorB))
		running: 100
		with: (Set new add: verstappen; yourself).
		
	grandPrix put: verstappen at: 5 * kilometer.

	self assert: 5 * kilometer equals: (grandPrix locationOf: verstappen). 
	self assert: sectorA equals: (grandPrix sectorOf: verstappen).
	
	verstappen speed: 15 * kilometer / hour.
	grandPrix advance: 1 * hour.
	
	self assert: 20 * kilometer equals: (grandPrix locationOf: verstappen). 
	self assert: sectorB equals: (grandPrix sectorOf: verstappen).
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 14:48:08'!
test20FirstTurboIncrementsSpeedByTwentyPercent

	| schumacher hamilton sector |
	
	sector _ Sector withTurboOf: 24 * kilometer.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.
	
	schumacher speed: 100 * kilometer / hour.
	hamilton speed: 100 * kilometer / hour.
	
	sector put: schumacher at: 12.99 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	schumacher activateTurbo.
	
	self assert: schumacher isTurboActivated.
	self assert: 120 * kilometer / hour equals: schumacher speed.! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 14:14:31'!
test21SecondTurboSpeedsByTenPercent

	| schumacher hamilton sector |
	
	sector _ Sector withTurboOf: 24 * kilometer.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.
	
	schumacher speed: 100 * kilometer / hour.
	hamilton speed: 100 * kilometer / hour.
	
	sector put: schumacher at: 12.99 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	schumacher activateTurbo; deactivateTurbo; activateTurbo.
	
	self assert: schumacher isTurboActivated.
	self assert: 110 * kilometer / hour equals: schumacher speed.! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 14:14:58'!
test22ThirdTurboSpeedsByFivePercent

	| schumacher hamilton sector |
	
	sector _ Sector withTurboOf: 24 * kilometer.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.
	
	schumacher speed: 100 * kilometer / hour.
	hamilton speed: 100 * kilometer / hour.
	
	sector put: schumacher at: 12.99 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	schumacher activateTurbo; deactivateTurbo; activateTurbo; deactivateTurbo; activateTurbo.
	
	self assert: schumacher isTurboActivated.
	self assert: 105 * kilometer / hour equals: schumacher speed.! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 14:19:06'!
test23AfterThridTurbo_TurboIsExhausted

	| schumacher hamilton sector |
	
	sector _ Sector withTurboOf: 24 * kilometer.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.
	
	schumacher speed: 100 * kilometer / hour.
	hamilton speed: 100 * kilometer / hour.
	
	sector put: schumacher at: 12.99 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	schumacher activateTurbo; deactivateTurbo; activateTurbo; deactivateTurbo; activateTurbo; deactivateTurbo; activateTurbo.	
	
	self assert: schumacher isTurboActivated.
	self assert: 100 * kilometer / hour equals: schumacher speed.! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 14:24:24'!
test24CanNotActivateTurboWhenTurboIsActivated

	| schumacher hamilton sector |
	
	sector _ Sector withTurboOf: 24 * kilometer.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.
	
	schumacher speed: 100 * kilometer / hour.
	hamilton speed: 100 * kilometer / hour.
	
	sector put: schumacher at: 12.99 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	schumacher activateTurbo.
	
	self 
		should: [ schumacher activateTurbo ]
		raise: Error - MessageNotUnderstood 
		withMessageText: schumacher turboAlreadyActivatedErrorDescription
	
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 14:24:59'!
test25CanNotDeactivateTurboWhenIsDeactivated

	| schumacher hamilton sector |
	
	sector _ Sector withTurboOf: 24 * kilometer.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.
	
	schumacher speed: 100 * kilometer / hour.
	hamilton speed: 100 * kilometer / hour.
	
	sector put: schumacher at: 12.99 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	self 
		should: [ schumacher deactivateTurbo ]
		raise: Error - MessageNotUnderstood 
		withMessageText: schumacher turboAlreadydeActivatedErrorDescription
	
	! !


!classDefinition: #EstadoTurbo category: '1c2022 - Resolucion'!
Object subclass: #EstadoTurbo
	instanceVariableNames: 'usosRestantes'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!EstadoTurbo methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 12:14:13'!
activarTurboA: unAuto enSector: unSector conUsos: cantUsosActuales 

	self subclassResponsibility! !

!EstadoTurbo methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 11:50:46'!
desactivarTurboDe: unAuto 

	self subclassResponsibility! !

!EstadoTurbo methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 11:10:21'!
estaActivado

	self subclassResponsibility! !

!EstadoTurbo methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 11:44:36'!
establecerTurboConUsos: unaCantidadDeUsos

	usosRestantes := TurboVecesUsado initializeConCantidadDeUsos: unaCantidadDeUsos! !

!EstadoTurbo methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 11:38:19'!
initializeActivadoConUsos: unaCantidadDeUsos

	^ Activado new establecerTurboConUsos: unaCantidadDeUsos. 	 ! !

!EstadoTurbo methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 11:38:27'!
initializeDesactivadoConUsos: unaCantidadDeUsos

	^ NoActivado new establecerTurboConUsos: unaCantidadDeUsos. 	! !

!EstadoTurbo methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 12:02:38'!
velocidadActualDe: unAuto

	usosRestantes setearVelocidadA: unAuto.
	^ unAuto speed! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoTurbo class' category: '1c2022 - Resolucion'!
EstadoTurbo class
	instanceVariableNames: ''!

!EstadoTurbo class methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 11:36:57'!
initializeActivadoConUsos: unaCantidadDeUsos

	^ self new initializeActivadoConUsos: unaCantidadDeUsos ! !

!EstadoTurbo class methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 11:21:10'!
initializeDesactivadoConUsos: unaCantidadDeUsos

	^ self new initializeDesactivadoConUsos: unaCantidadDeUsos ! !


!classDefinition: #Activado category: '1c2022 - Resolucion'!
EstadoTurbo subclass: #Activado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!Activado methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 12:14:13'!
activarTurboA: unAuto enSector: unSector conUsos: cantUsosActuales  

	self error: unAuto turboAlreadyActivatedErrorDescription
	! !

!Activado methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 11:50:46'!
desactivarTurboDe: unAuto 

	unAuto canDeactivateTurbo ! !

!Activado methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 11:10:28'!
estaActivado

	^ true! !


!classDefinition: #NoActivado category: '1c2022 - Resolucion'!
EstadoTurbo subclass: #NoActivado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!NoActivado methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 12:14:20'!
activarTurboA: unAuto enSector: unSector conUsos: cantUsosActuales  
	
	unSector activateTurboTo: unAuto.
	usosRestantes := TurboVecesUsado initializeConCantidadDeUsos: cantUsosActuales.
	usosRestantes setearVelocidadA: unAuto! !

!NoActivado methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 11:51:28'!
desactivarTurboDe: unAuto 

	self error: unAuto turboAlreadydeActivatedErrorDescription ! !

!NoActivado methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 11:10:37'!
estaActivado

	^ false! !


!classDefinition: #FormulaOneCar category: '1c2022 - Resolucion'!
Object subclass: #FormulaOneCar
	instanceVariableNames: 'grandPrix driver speed turboActivated traveledDistance currentSector turboActivations estadoTurbo initialSpeed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!FormulaOneCar methodsFor: 'initialization' stamp: 'MS 4/29/2024 11:25:45'!
initializeDrivenBy: aDriver 

	driver := aDriver.
	turboActivated := false.
	turboActivations := 0.
	speed := 0*kilometer/hour.
	traveledDistance := 0.
	
	estadoTurbo := EstadoTurbo new initializeDesactivadoConUsos: 0. 
	! !

!FormulaOneCar methodsFor: 'initialization' stamp: 'FRT 5/1/2022 11:26:28'!
runningInGrandPrix: aGrandPrix
	
	grandPrix _ aGrandPrix! !


!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 4/30/2022 19:15:07'!
advance: aDistance

	traveledDistance _ traveledDistance + aDistance! !

!FormulaOneCar methodsFor: 'moving' stamp: 'FRT 4/30/2022 16:33:07'!
atSector: aSector

	currentSector _ aSector.! !

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 4/30/2022 19:15:19'!
traveledDistance

	^ traveledDistance! !

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 4/30/2022 19:15:31'!
traveledDistance: aDistance

	traveledDistance _ aDistance! !


!FormulaOneCar methodsFor: 'turbo' stamp: 'MS 4/29/2024 12:23:52'!
activateTurbo

	turboActivations := turboActivations + 1.
	estadoTurbo activarTurboA: self enSector: currentSector conUsos: turboActivations 
! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'MS 4/29/2024 12:15:25'!
activateTurboInSectorWithTurbo
	
	estadoTurbo := EstadoTurbo initializeActivadoConUsos: turboActivations ! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'MS 4/29/2024 12:18:25'!
canDeactivateTurbo
	
	estadoTurbo := EstadoTurbo initializeDesactivadoConUsos: turboActivations.
	speed := initialSpeed ! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'MS 4/29/2024 11:50:46'!
deactivateTurbo
	
	estadoTurbo desactivarTurboDe: self ! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'HAW 5/2/2022 14:25:13'!
turboAlreadydeActivatedErrorDescription
	
	^'Turbo is already deactivated'! !


!FormulaOneCar methodsFor: 'testing' stamp: 'MS 4/29/2024 11:10:08'!
isTurboActivated
	
	^ estadoTurbo estaActivado! !

!FormulaOneCar methodsFor: 'testing' stamp: 'HAW 5/2/2022 14:23:06'!
turboAlreadyActivatedErrorDescription
	
	^'Turbo already activated'! !


!FormulaOneCar methodsFor: 'speed' stamp: 'MS 4/29/2024 12:05:42'!
dosActivacionesSpeed

	speed := speed * 11 / 10! !

!FormulaOneCar methodsFor: 'speed' stamp: 'MS 4/29/2024 12:05:46'!
normalSpeed
! !

!FormulaOneCar methodsFor: 'speed' stamp: 'MS 4/29/2024 12:04:30'!
speed

	"^ estadoTurbo setearVelocidadA: self"

	"turboActivated ifTrue: [
		turboActivations = 1 ifTrue: [ ^ speed * 12 / 10 ].
		turboActivations = 2 ifTrue: [ ^ speed * 11 / 10 ].
		turboActivations = 3 ifTrue: [ ^ speed * 105 / 100 ].
	]."

	^speed! !

!FormulaOneCar methodsFor: 'speed' stamp: 'MS 4/29/2024 12:18:11'!
speed: newSpeed

	speed := newSpeed.
	initialSpeed := newSpeed
	! !

!FormulaOneCar methodsFor: 'speed' stamp: 'MS 4/29/2024 12:05:53'!
tresActivacionesSpeed

	speed := speed * 105 / 100! !

!FormulaOneCar methodsFor: 'speed' stamp: 'MS 4/29/2024 12:06:01'!
unaActivacionSpeed

	speed := speed * 12 / 10 ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FormulaOneCar class' category: '1c2022 - Resolucion'!
FormulaOneCar class
	instanceVariableNames: ''!

!FormulaOneCar class methodsFor: 'instance creation' stamp: 'HAW 4/30/2022 18:44:15'!
drivenBy: aDriver 

	^self new initializeDrivenBy: aDriver ! !


!classDefinition: #GrandPrix category: '1c2022 - Resolucion'!
Object subclass: #GrandPrix
	instanceVariableNames: 'track numberOfLaps'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!GrandPrix methodsFor: 'initialization' stamp: 'FRT 5/1/2022 11:26:39'!
initializeWithTrack: aTrack andNumberOfLaps: aNumberOfLaps andCars: aCollectionOfCars

	track _ aTrack.
	numberOfLaps _ aNumberOfLaps.
	aCollectionOfCars do: [ :car | car runningInGrandPrix: self ].
! !


!GrandPrix methodsFor: 'car position' stamp: 'FRT 4/30/2022 22:23:59'!
locationOf: aCar

	^ aCar traveledDistance.	! !

!GrandPrix methodsFor: 'car position' stamp: 'HAW 4/30/2022 19:15:32'!
put: aCar at: aDistance

	| distanceInTrack |
	
	aCar traveledDistance: aDistance.
	
	distanceInTrack _ aDistance \\ track length.
	track put: aCar at: distanceInTrack.
	! !

!GrandPrix methodsFor: 'car position' stamp: 'FRT 4/30/2022 15:38:16'!
sectorOf: aCar 

	^ track sectorOf: aCar.! !


!GrandPrix methodsFor: 'length' stamp: 'HAW 4/30/2022 18:43:17'!
length

	^ track length * numberOfLaps! !


!GrandPrix methodsFor: 'simulation' stamp: 'FRT 5/1/2022 09:06:07'!
advance: aTimeLapse
	
	| ix cars |
	
	cars _ track cars asOrderedCollection.
	ix _ 1.
	[ix <= cars size] whileTrue: [ | car |
		car _ cars at: ix.
		self relocate: car after: aTimeLapse.
		ix _ ix + 1.
	]
! !

!GrandPrix methodsFor: 'simulation' stamp: 'HAW 5/1/2022 17:35:43'!
relocate: aCar after: aTimeLapse 

	| distanceMoved distanceInTrack |
	
	distanceMoved _ aCar speed * aTimeLapse.
	aCar advance: distanceMoved.
	
	distanceInTrack _ aCar traveledDistance \\ track length.
	track put: aCar at: distanceInTrack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GrandPrix class' category: '1c2022 - Resolucion'!
GrandPrix class
	instanceVariableNames: ''!

!GrandPrix class methodsFor: 'instance creation' stamp: 'HAW 4/30/2022 19:36:05'!
on: aTrack running: aNumberOfLaps 

	^self on: aTrack running: aNumberOfLaps with: #()! !

!GrandPrix class methodsFor: 'instance creation' stamp: 'HAW 4/30/2022 19:36:16'!
on: aTrack running: aNumberOfLaps with: aCollectionOfCars

	^self new initializeWithTrack: aTrack andNumberOfLaps: aNumberOfLaps andCars: aCollectionOfCars! !


!GrandPrix class methodsFor: 'error message' stamp: 'ARM 4/28/2022 15:09:05'!
distanceOutSideRaceTrackLengthErrorMessage

	^'Distance outside Race Track length'! !

!GrandPrix class methodsFor: 'error message' stamp: 'FRT 5/1/2022 12:24:57'!
turboNotAllowedWithRainTiresErrorMessage

	^ 'Turbo not allowed with rain tires'! !


!classDefinition: #Sector category: '1c2022 - Resolucion'!
Object subclass: #Sector
	instanceVariableNames: 'cars length withTurbo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!Sector methodsFor: 'initialization' stamp: 'FRT 5/1/2022 10:02:21'!
initializeOf: aLength 

	cars _ Dictionary new.
	length _ aLength.! !

!Sector methodsFor: 'initialization' stamp: 'FRT 5/1/2022 09:59:49'!
withTurbo: aBoolean
 
	withTurbo _ aBoolean.
! !


!Sector methodsFor: 'car position' stamp: 'FRT 5/1/2022 14:13:55'!
assertValidPosition: aPosition

	length < aPosition ifTrue: [ self error: self class cannotPlacedCarErrorDescription ]! !

!Sector methodsFor: 'car position' stamp: 'HAW 5/1/2022 16:59:05'!
atStartPut: aCar
 
	self put: aCar at: 0*kilometer! !

!Sector methodsFor: 'car position' stamp: 'FRT 4/30/2022 09:23:35'!
positionOf: aCar
 
	^ cars at: aCar.
! !

!Sector methodsFor: 'car position' stamp: 'FRT 5/1/2022 14:13:55'!
put: aCar at: aPosition
 
	self assertValidPosition: aPosition.
	
	cars at: aCar put: aPosition.
	aCar atSector: self.! !

!Sector methodsFor: 'car position' stamp: 'FRT 4/30/2022 15:04:40'!
remove: aCar
 
	cars removeKey: aCar ifAbsent: [].
! !


!Sector methodsFor: 'accessing' stamp: 'FRT 4/30/2022 22:08:51'!
cars
	
	^ cars keys! !

!Sector methodsFor: 'accessing' stamp: 'HAW 5/2/2022 14:26:16'!
length

	^length! !


!Sector methodsFor: 'testing' stamp: 'HAW 5/1/2022 16:54:33'!
includes: aCar

	^ cars includesKey: aCar! !


!Sector methodsFor: 'turbo' stamp: 'HAW 5/2/2022 14:21:14'!
activateTurboTo: aCarToActivateTurboTo

	| positionOfCarAhead |

	withTurbo ifFalse: [	self error: Sector turboNotAllowedErrorDescription].
	
	positionOfCarAhead _ self 
		positionOfCarAheadOf: aCarToActivateTurboTo 
		ifNone: [self error: Sector cannotActivateTurboWhenNoCarAheadErrorDescription ].
		
	self 
		assertDriverIsOneSecondOrLess: aCarToActivateTurboTo
		ofDriverAt: positionOfCarAhead.

	aCarToActivateTurboTo activateTurboInSectorWithTurbo
! !

!Sector methodsFor: 'turbo' stamp: 'HAW 5/2/2022 14:07:54'!
assertDriverIsOneSecondOrLess: aCarToActivateTurboTo ofDriverAt: positionOfCarAhead

	| carAhead |
	
	carAhead _ self carAtPosition: positionOfCarAhead.
	
	((positionOfCarAhead / carAhead speed) -
	((cars at: aCarToActivateTurboTo) / aCarToActivateTurboTo speed)) < (1 * second)
		ifFalse: [self error: Sector cannotActivateTurboWhenMoreThanASecondBehindAnotherCarErrorDescription ].! !

!Sector methodsFor: 'turbo' stamp: 'HAW 5/2/2022 14:06:52'!
carAtPosition: positionOfDriver

	^cars keyAtValue: positionOfDriver! !

!Sector methodsFor: 'turbo' stamp: 'HAW 5/2/2022 14:08:13'!
positionOfCarAheadOf: aCarToActiveTurboTo ifNone: alternativeClosure

	| sortedPositions carToActivateTurboToPosition |
	
	carToActivateTurboToPosition _ cars at: aCarToActiveTurboTo.
	sortedPositions _ cars asSortedCollection remove: carToActivateTurboToPosition; yourself.
	 
	^ sortedPositions 
		detect: [:aPosition | aPosition > carToActivateTurboToPosition ]
		ifNone: alternativeClosure ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sector class' category: '1c2022 - Resolucion'!
Sector class
	instanceVariableNames: ''!

!Sector class methodsFor: 'instance creation' stamp: 'HAW 5/2/2022 14:05:32'!
withTurboOf: aLength 

	aLength strictlyPositive ifFalse: [ self error: self lengthMustBePositiveErrorDescription ]	.

	^ self new initializeOf: aLength; withTurbo: true; yourself ! !

!Sector class methodsFor: 'instance creation' stamp: 'HAW 5/2/2022 14:05:47'!
withoutTurboOf: aLength 
	
	aLength strictlyPositive ifFalse: [ self error: self lengthMustBePositiveErrorDescription ]	.
		
	^ self new initializeOf: aLength; withTurbo: false; yourself ! !


!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 20:24:41'!
cannotActivateTurboWhenMoreThanASecondBehindAnotherCarErrorDescription
	
	^ 'Cannot activate Turbo when opponent is more than 1 second ahead'! !

!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 20:13:07'!
cannotActivateTurboWhenNoCarAheadErrorDescription
	
	^ 'Cannot activate Turbo without opponent ahead'! !

!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 10:08:26'!
cannotPlacedCarErrorDescription

	^ 'Driver can not be placed outside section'! !

!Sector class methodsFor: 'error message' stamp: 'HAW 4/30/2022 17:05:20'!
lengthMustBePositiveErrorDescription

	^ 'Length must be positive'! !

!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 09:54:45'!
turboNotAllowedErrorDescription
	
	^ 'Turbo not allowed in this Sector'! !


!classDefinition: #Track category: '1c2022 - Resolucion'!
Object subclass: #Track
	instanceVariableNames: 'sectors driversDistanceFromBeginning'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!Track methodsFor: 'initialization' stamp: 'HAW 4/30/2022 17:06:50'!
initializeWithSectors: aSectors

	sectors _ aSectors copy.! !


!Track methodsFor: 'car position' stamp: 'HAW 5/2/2022 14:10:18'!
carNotFoundErrorDescription

	^ 'Car not found'! !

!Track methodsFor: 'car position' stamp: 'HAW 5/2/2022 14:09:03'!
positionOf: aCar
	| accumulatedLength ix sector |
	
	ix _ 1.
	sector _ (sectors at: ix).
	accumulatedLength _ 0 * kilometer.

	[sector includes: aCar] whileFalse: [
		accumulatedLength _ accumulatedLength + sector length.
		ix _ ix + 1.
		sector _ (sectors at: ix).
	].

	^ accumulatedLength + (sector positionOf: aCar).! !

!Track methodsFor: 'car position' stamp: 'HAW 5/2/2022 14:26:38'!
put: aCar at: aPosition

	| ix sector acc |
	
	aPosition > self length ifTrue: [ self error: self class cannotPlacedCarErrorDescription ].

	self remove: aCar.

	ix _ 1.
	sector _ sectors at: ix. 
	acc _ 0 * kilometer.

	[aPosition > (acc +  sector length)] whileTrue: [
		acc _ acc + sector length.
		ix _ ix + 1.
		sector _ sectors at: ix.
	].

	sector put: aCar at: aPosition - acc.! !

!Track methodsFor: 'car position' stamp: 'FRT 4/30/2022 15:15:27'!
remove: aCar
	
	| currentSector |
	
	currentSector _ self sectorOf: aCar ifNone: [ ^ self ].
	currentSector remove: aCar.
	! !

!Track methodsFor: 'car position' stamp: 'HAW 5/2/2022 14:10:18'!
sectorOf: aCar
	
	^self sectorOf: aCar ifNone: [ self error: self carNotFoundErrorDescription ]! !

!Track methodsFor: 'car position' stamp: 'HAW 5/2/2022 14:09:47'!
sectorOf: aCar ifNone: aBlock

	 | ix |
	
	ix _ 1.
	[ix <= sectors size] whileTrue: [ | sector |
		sector _	sectors at: ix.
		(sector includes: aCar) ifTrue: [ ^ sector ].
		ix _ ix + 1.
	].

	^ aBlock value.! !


!Track methodsFor: 'accessing' stamp: 'FRT 5/1/2022 09:10:09'!
cars
	| allCars ix |
	
	allCars _ Set new.
	ix _ 1.
	[ix <= sectors size] whileTrue: [ | s |
		s _ sectors at: ix.
		allCars addAll: s cars.
		ix _ ix + 1.
	].

	^ allCars
	! !

!Track methodsFor: 'accessing' stamp: 'FRT 5/1/2022 09:31:32'!
length

	| acc ix |

	acc _ 0 * kilometer.
	ix _ 1.
	
	[ix <= sectors size] whileTrue: [ | sector |
		sector _ sectors at: ix.
		acc _ acc + sector length.
		ix _ ix + 1.		
	].

	^ acc.
! !


!Track methodsFor: 'testing' stamp: 'FRT 5/1/2022 09:26:52'!
includes: aCar
	"Returns if any of the sectors includes aCar"
	
	| inc ix sector |
	inc _ false.
	ix _ 1.
	
	(sectors size = 0) ifTrue: [ ^ inc ].
	
	sector _ sectors at: ix.
	(sector includes: aCar) 
		ifTrue: [ inc _ true]
		ifFalse: [
			ix _ ix +1.
			[ix <= sectors size] whileTrue: [ | s |
				s _ sectors at: ix.
				(s includes: aCar) ifTrue: [ ^ true ].
				ix _ ix + 1
			]	
		]. 
	^ inc
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Track class' category: '1c2022 - Resolucion'!
Track class
	instanceVariableNames: ''!

!Track class methodsFor: 'instance creation' stamp: 'HAW 4/30/2022 17:10:08'!
withSectors: sectors

	sectors isEmpty ifTrue: [ self error: self mustHaveSectorsErrorDescription ].
	
	^ self new initializeWithSectors: sectors! !


!Track class methodsFor: 'error messages' stamp: 'FRT 4/29/2022 18:22:32'!
cannotPlacedCarErrorDescription

	^ 'Car cannot be placed in track'! !

!Track class methodsFor: 'error messages' stamp: 'HAW 4/30/2022 17:09:27'!
mustHaveSectorsErrorDescription

	^'Track must have sectors'! !


!classDefinition: #TurboVecesUsado category: '1c2022 - Resolucion'!
Object subclass: #TurboVecesUsado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!TurboVecesUsado methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 12:00:52'!
setearVelocidadA: unAuto

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurboVecesUsado class' category: '1c2022 - Resolucion'!
TurboVecesUsado class
	instanceVariableNames: ''!

!TurboVecesUsado class methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 10:56:39'!
fueUsadoTantasVeces: unaCantidadDeUsos

	self subclassResponsibility! !

!TurboVecesUsado class methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 12:23:12'!
initializeConCantidadDeUsos: unaCantidadDeUsos

	^ (self subclasses detect: [ :posibleEstado | posibleEstado fueUsadoTantasVeces: unaCantidadDeUsos ] ifNone: Cero0VecesUsado) new
	
	! !


!classDefinition: #Cero0VecesUsado category: '1c2022 - Resolucion'!
TurboVecesUsado subclass: #Cero0VecesUsado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!Cero0VecesUsado methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 12:06:59'!
setearVelocidadA: unAuto

	unAuto normalSpeed ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero0VecesUsado class' category: '1c2022 - Resolucion'!
Cero0VecesUsado class
	instanceVariableNames: ''!

!Cero0VecesUsado class methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 10:56:39'!
fueUsadoTantasVeces: unaCantidadDeUsos
	
	^ unaCantidadDeUsos = 0! !


!classDefinition: #Dos2VecesUsado category: '1c2022 - Resolucion'!
TurboVecesUsado subclass: #Dos2VecesUsado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!Dos2VecesUsado methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 12:06:55'!
setearVelocidadA: unAuto

	unAuto dosActivacionesSpeed ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Dos2VecesUsado class' category: '1c2022 - Resolucion'!
Dos2VecesUsado class
	instanceVariableNames: ''!

!Dos2VecesUsado class methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 10:56:39'!
fueUsadoTantasVeces: unaCantidadDeUsos

	^ unaCantidadDeUsos = 2! !


!classDefinition: #Tres3VecesUsado category: '1c2022 - Resolucion'!
TurboVecesUsado subclass: #Tres3VecesUsado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!Tres3VecesUsado methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 12:06:46'!
setearVelocidadA: unAuto

	unAuto tresActivacionesSpeed ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tres3VecesUsado class' category: '1c2022 - Resolucion'!
Tres3VecesUsado class
	instanceVariableNames: ''!

!Tres3VecesUsado class methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 10:56:39'!
fueUsadoTantasVeces: unaCantidadDeUsos

	^ unaCantidadDeUsos = 3! !


!classDefinition: #Una1VecesUsado category: '1c2022 - Resolucion'!
TurboVecesUsado subclass: #Una1VecesUsado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2022 - Resolucion'!

!Una1VecesUsado methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 12:06:51'!
setearVelocidadA: unAuto

	unAuto unaActivacionSpeed ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Una1VecesUsado class' category: '1c2022 - Resolucion'!
Una1VecesUsado class
	instanceVariableNames: ''!

!Una1VecesUsado class methodsFor: 'as yet unclassified' stamp: 'MS 4/29/2024 10:56:39'!
fueUsadoTantasVeces: unaCantidadDeUsos

	^ unaCantidadDeUsos = 1! !
