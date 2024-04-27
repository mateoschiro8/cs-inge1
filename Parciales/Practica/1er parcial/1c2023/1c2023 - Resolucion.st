!classDefinition: #TestDePerforación category: '1c2023 - Resolucion'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2023 - Resolucion'!

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:58:53'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:58:58'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:02:52'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:59:05'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:59:09'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: CapaDeSuelo arenoso equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:02:45'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.	
			CapaDeSuelo tierra.
} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:03:00'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota ].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:43'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaDeSuelo concretoConResistencia: 5) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:48'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: (CapaDeSuelo concretoConResistencia: 4) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 4/27/2023 21:54:59'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			'Mica'.
			'Marmol'
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: {	'Mica'. 'Marmol'} equals: excavadora elementsInContainer
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/3/2023 22:34:18'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: excavadora elementsInContainer isEmpty
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:03:09'!
test12NoPuedePerforarSinMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
		
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: (CapaDeSuelo arenoso) equals: excavadora capaDeSueloInmediata ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 16:46:32'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso} .
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'MS 4/27/2024 18:14:50'!
test14PuedeContarLasCapasDeTipoArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 2 equals: (excavadora contarCapas: Arenoso).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'MS 4/27/2024 18:14:53'!
test15PuedeContarLasCapasDeTipoTierra

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 1 equals: (excavadora contarCapas: Tierra).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'MS 4/27/2024 18:14:55'!
test16PuedeContarLasCapasDeTipoConcreto

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 1 equals: (excavadora contarCapas: Concreto).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 17:10:17'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 0 equals: (excavadora calcularProfundidadDelSueloHasta: #Arenoso).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 17:10:45'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 2 equals: (excavadora calcularProfundidadDelSueloHasta: #Tierra).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 17:11:10'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: (excavadora calcularProfundidadDelSueloHasta: #Concreto).

	! !


!classDefinition: #CapaDeSuelo category: '1c2023 - Resolucion'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: 'altura tipo resistencia'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2023 - Resolucion'!

!CapaDeSuelo methodsFor: 'tipo' stamp: 'MS 4/27/2024 17:04:48'!
esArenoso

	self subclassResponsibility! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'MS 4/27/2024 17:04:57'!
esConcreto

	self subclassResponsibility! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'MS 4/27/2024 17:05:02'!
esTierra

	self subclassResponsibility! !


!CapaDeSuelo methodsFor: 'comparing' stamp: 'ARM 5/8/2023 13:10:22'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class) and: [ tipo = unaCapaDeSuelo tipo and: [resistencia = unaCapaDeSuelo resistencia]]! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'ARM 5/8/2023 13:10:22'!
hash

	^tipo hash + resistencia hash! !


!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
sinResistencia
	^resistencia = 0! !


!CapaDeSuelo methodsFor: 'accessing' stamp: 'FRT 5/5/2023 16:48:52'!
altura

	^ altura.! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'MS 4/27/2024 17:13:13'!
resistencia

	self subclassResponsibility! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:18:41'!
tipo

	^tipo! !


!CapaDeSuelo methodsFor: 'scan' stamp: 'MS 4/27/2024 17:09:34'!
scan

	self subclassResponsibility! !


!CapaDeSuelo methodsFor: 'golpes mecha' stamp: 'MS 4/27/2024 16:33:25'!
esGolpeadaConMechaDiamantePorPerforadora: unaPerforadora

	self subclassResponsibility! !

!CapaDeSuelo methodsFor: 'golpes mecha' stamp: 'MS 4/27/2024 16:33:21'!
esGolpeadaConMechaSoftPorPerforadora: unaPerforadora

	self subclassResponsibility! !

!CapaDeSuelo methodsFor: 'golpes mecha' stamp: 'MS 4/27/2024 16:33:15'!
esGolpeadaConMechaWidiaPorPerforadora: unaPerforadora

	self subclassResponsibility! !


!CapaDeSuelo methodsFor: 'setters' stamp: 'FRT 5/5/2023 16:07:55'!
setAltura: unaAltura

	altura := unaAltura! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSuelo class' category: '1c2023 - Resolucion'!
CapaDeSuelo class
	instanceVariableNames: ''!

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'MS 4/27/2024 16:35:14'!
arenoso

	^Arenoso new initializeArenoso ! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'MS 4/27/2024 16:35:23'!
concretoConResistencia: resistencia 

	^Concreto new initializeConcretoConResistencia: resistencia ! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'MS 4/27/2024 16:55:22'!
tierra

	^Tierra new initializeTierra! !


!classDefinition: #Arenoso category: '1c2023 - Resolucion'!
CapaDeSuelo subclass: #Arenoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2023 - Resolucion'!

!Arenoso methodsFor: 'golpes mecha' stamp: 'MS 4/27/2024 16:40:32'!
esGolpeadaConMechaDiamantePorPerforadora: unaPerforadora

	unaPerforadora seRompeMecha! !

!Arenoso methodsFor: 'golpes mecha' stamp: 'MS 4/27/2024 16:40:08'!
esGolpeadaConMechaSoftPorPerforadora: unaPerforadora

	unaPerforadora pasarAProximaCapa! !

!Arenoso methodsFor: 'golpes mecha' stamp: 'MS 4/27/2024 16:40:39'!
esGolpeadaConMechaWidiaPorPerforadora: unaPerforadora
	
	unaPerforadora pasarAProximaCapa ! !


!Arenoso methodsFor: 'initialization' stamp: 'MS 4/27/2024 18:09:33'!
initializeArenoso
	
	altura := 0.
	tipo := #Arenoso.
	! !


!Arenoso methodsFor: 'tipo' stamp: 'MS 4/27/2024 17:05:34'!
esArenoso

	^true! !

!Arenoso methodsFor: 'tipo' stamp: 'MS 4/27/2024 17:05:42'!
esConcreto

	^false! !

!Arenoso methodsFor: 'tipo' stamp: 'MS 4/27/2024 17:05:49'!
esTierra

	^false! !


!Arenoso methodsFor: 'scan' stamp: 'MS 4/27/2024 18:15:42'!
scan

        ^ 7  ! !


!Arenoso methodsFor: 'accessing' stamp: 'MS 4/27/2024 17:31:42'!
resistencia

	^ resistencia

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Arenoso class' category: '1c2023 - Resolucion'!
Arenoso class
	instanceVariableNames: ''!

!Arenoso class methodsFor: 'scan' stamp: 'MS 4/27/2024 18:14:33'!
scan

        ^ 7  ! !


!classDefinition: #Concreto category: '1c2023 - Resolucion'!
CapaDeSuelo subclass: #Concreto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2023 - Resolucion'!

!Concreto methodsFor: 'golpes mecha' stamp: 'MS 4/27/2024 16:52:12'!
esGolpeadaConMechaDiamantePorPerforadora: unaPerforadora

	unaPerforadora chequearResistenciaSuelo! !

!Concreto methodsFor: 'golpes mecha' stamp: 'MS 4/27/2024 16:44:17'!
esGolpeadaConMechaSoftPorPerforadora: unaPerforadora

	unaPerforadora seRompeMecha ! !

!Concreto methodsFor: 'golpes mecha' stamp: 'MS 4/27/2024 16:45:00'!
esGolpeadaConMechaWidiaPorPerforadora: unaPerforadora

	unaPerforadora chequearSiSeRompeMechaPorGolpes! !


!Concreto methodsFor: 'initialization' stamp: 'MS 4/27/2024 18:09:27'!
initializeConcretoConResistencia: resistenciaInicial 

	resistencia := resistenciaInicial.
	altura := 0.
	tipo := #Concreto! !


!Concreto methodsFor: 'bajar resistencia' stamp: 'MS 4/27/2024 16:51:41'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !


!Concreto methodsFor: 'tipo' stamp: 'MS 4/27/2024 17:06:18'!
esArenoso

	^false! !

!Concreto methodsFor: 'tipo' stamp: 'MS 4/27/2024 17:06:07'!
esConcreto

	^true! !

!Concreto methodsFor: 'tipo' stamp: 'MS 4/27/2024 17:06:21'!
esTierra

	^false! !


!Concreto methodsFor: 'accessing' stamp: 'MS 4/27/2024 17:13:20'!
resistencia

	^ resistencia.! !


!Concreto methodsFor: 'scan' stamp: 'MS 4/27/2024 18:15:50'!
scan

	^ 50. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Concreto class' category: '1c2023 - Resolucion'!
Concreto class
	instanceVariableNames: ''!

!Concreto class methodsFor: 'scan' stamp: 'MS 4/27/2024 18:14:38'!
scan

	^ 50. ! !


!classDefinition: #Tierra category: '1c2023 - Resolucion'!
CapaDeSuelo subclass: #Tierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2023 - Resolucion'!

!Tierra methodsFor: 'golpes mecha' stamp: 'MS 4/27/2024 16:43:48'!
esGolpeadaConMechaDiamantePorPerforadora: unaPerforadora

	unaPerforadora pasarAProximaCapa ! !

!Tierra methodsFor: 'golpes mecha' stamp: 'MS 4/27/2024 16:33:21'!
esGolpeadaConMechaSoftPorPerforadora: unaPerforadora! !

!Tierra methodsFor: 'golpes mecha' stamp: 'MS 4/27/2024 16:43:32'!
esGolpeadaConMechaWidiaPorPerforadora: unaPerforadora

	unaPerforadora chequearSiSeTransformaTierraEnArenoso! !


!Tierra methodsFor: 'initialization' stamp: 'MS 4/27/2024 18:09:23'!
initializeTierra
	
	altura := 0.
	tipo := #Tierra.
	! !


!Tierra methodsFor: 'tipo' stamp: 'MS 4/27/2024 17:06:24'!
esArenoso

	^false! !

!Tierra methodsFor: 'tipo' stamp: 'MS 4/27/2024 17:06:27'!
esConcreto

	^false! !

!Tierra methodsFor: 'tipo' stamp: 'MS 4/27/2024 17:06:12'!
esTierra

	^true! !


!Tierra methodsFor: 'scan' stamp: 'MS 4/27/2024 18:15:59'!
scan

	^ 10 ! !


!Tierra methodsFor: 'accessing' stamp: 'MS 4/27/2024 17:31:47'!
resistencia

	^ resistencia
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tierra class' category: '1c2023 - Resolucion'!
Tierra class
	instanceVariableNames: ''!

!Tierra class methodsFor: 'scan' stamp: 'MS 4/27/2024 18:14:42'!
scan

	^ 10 ! !


!classDefinition: #EstadoBrazoPerforador category: '1c2023 - Resolucion'!
Object subclass: #EstadoBrazoPerforador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2023 - Resolucion'!

!EstadoBrazoPerforador methodsFor: 'as yet unclassified' stamp: 'MS 4/27/2024 16:32:29'!
usarParaGolpear: capasDeSueloDebajo porPerforadora: unaPerforadora

	self subclassResponsibility! !


!classDefinition: #ConMecha category: '1c2023 - Resolucion'!
EstadoBrazoPerforador subclass: #ConMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2023 - Resolucion'!

!ConMecha methodsFor: 'as yet unclassified' stamp: 'MS 4/27/2024 16:32:30'!
usarParaGolpear: capasDeSueloDebajo porPerforadora: unaPerforadora

	self subclassResponsibility! !


!classDefinition: #MechaDiamante category: '1c2023 - Resolucion'!
ConMecha subclass: #MechaDiamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2023 - Resolucion'!

!MechaDiamante methodsFor: 'as yet unclassified' stamp: 'MS 4/27/2024 16:52:45'!
usarParaGolpear: capasDeSueloDebajo porPerforadora: unaPerforadora

	unaPerforadora golpearCapaActual.
	capasDeSueloDebajo first esGolpeadaConMechaDiamantePorPerforadora: unaPerforadora ! !


!classDefinition: #MechaSoft category: '1c2023 - Resolucion'!
ConMecha subclass: #MechaSoft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2023 - Resolucion'!

!MechaSoft methodsFor: 'as yet unclassified' stamp: 'MS 4/27/2024 16:52:52'!
usarParaGolpear: capasDeSueloDebajo porPerforadora: unaPerforadora

	unaPerforadora golpearCapaActual.
	capasDeSueloDebajo first esGolpeadaConMechaSoftPorPerforadora: unaPerforadora ! !


!classDefinition: #MechaWidia category: '1c2023 - Resolucion'!
ConMecha subclass: #MechaWidia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2023 - Resolucion'!

!MechaWidia methodsFor: 'as yet unclassified' stamp: 'MS 4/27/2024 16:52:58'!
usarParaGolpear: capasDeSueloDebajo porPerforadora: unaPerforadora

	unaPerforadora golpearCapaActual.
	capasDeSueloDebajo first esGolpeadaConMechaWidiaPorPerforadora: unaPerforadora! !


!classDefinition: #SinMecha category: '1c2023 - Resolucion'!
EstadoBrazoPerforador subclass: #SinMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2023 - Resolucion'!

!SinMecha methodsFor: 'as yet unclassified' stamp: 'MS 4/27/2024 16:32:30'!
usarParaGolpear: capasDeSueloDebajo porPerforadora: unaPerforadora

	unaPerforadora error: 'No puede perforar'! !


!classDefinition: #Perforadora category: '1c2023 - Resolucion'!
Object subclass: #Perforadora
	instanceVariableNames: 'tipoDeSuelo mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo container'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1c2023 - Resolucion'!

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 5/1/2023 20:07:29'!
pasarAProximaCapa
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self]. 
	(capasDeSueloDebajo first isKindOf: CapaDeSuelo) ifFalse:[
			container addAll: capasDeSueloDebajo.
		]! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 4/27/2023 20:46:30'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: CapaDeSuelo arenoso;
			yourself! !


!Perforadora methodsFor: 'excavation' stamp: 'MS 4/27/2024 18:09:58'!
darGolpeDeTaladro
		
	mechaPuesta usarParaGolpear: capasDeSueloDebajo porPerforadora: self.
		! !

!Perforadora methodsFor: 'excavation' stamp: 'MS 4/27/2024 16:17:41'!
golpearCapaActual

	^ vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1! !

!Perforadora methodsFor: 'excavation' stamp: 'MS 4/27/2024 17:35:08'!
seRompeMecha

	mechaPuesta := #Rota. 
	self error: 'Se rompió'! !


!Perforadora methodsFor: 'initialization' stamp: 'MS 4/27/2024 16:08:02'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	vecesQueGolpeoCapaActual := 0.
	container := OrderedCollection new.
	mechaPuesta := SinMecha new ! !


!Perforadora methodsFor: 'accessing' stamp: 'MS 4/27/2024 17:15:56'!
capaDeSueloInmediata

	^capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:20:54'!
conMechaRota

	^mechaPuesta = #Rota! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:12:20'!
elementsInContainer
	^container asArray! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:54:43'!
sinMecha

	^mechaPuesta = #SinMecha! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:17'!
sobreSueloArenoso
	^capasDeSueloDebajo first esArenoso! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:16:14'!
sobreSueloConcreto
	^capasDeSueloDebajo first esConcreto! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:58'!
sobreSueloTierra
	^capasDeSueloDebajo first esTierra! !


!Perforadora methodsFor: 'colocar mecha' stamp: 'MS 4/27/2024 16:07:29'!
ponerMechaDiamante
	mechaPuesta := MechaDiamante new! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'MS 4/27/2024 16:07:36'!
ponerMechaSoft
	mechaPuesta := MechaSoft new! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'MS 4/27/2024 16:07:42'!
ponerMechaWidia
	mechaPuesta := MechaWidia new! !


!Perforadora methodsFor: 'chequeos' stamp: 'MS 4/27/2024 16:51:22'!
chequearResistenciaSuelo

	vecesQueGolpeoCapaActual even ifTrue: [ capasDeSueloDebajo first bajaUnDecimoDeResistencia].
			capasDeSueloDebajo first sinResistencia ifTrue: [ self transformarCapaEnArenoso]! !

!Perforadora methodsFor: 'chequeos' stamp: 'MS 4/27/2024 16:44:46'!
chequearSiSeRompeMechaPorGolpes

	^ vecesQueGolpeoCapaActual = 3 ifTrue: [ self seRompeMecha ]! !

!Perforadora methodsFor: 'chequeos' stamp: 'MS 4/27/2024 16:42:49'!
chequearSiSeTransformaTierraEnArenoso

	^ vecesQueGolpeoCapaActual = 2 ifTrue: [ self transformarCapaEnArenoso ]! !


!Perforadora methodsFor: 'scan' stamp: 'MS 4/27/2024 18:10:29'!
calcularProfundidadDelSuelo
	
	^ capasDeSueloDebajo sum: [ :capaDeSuelo | capaDeSuelo altura]	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'FRT 5/5/2023 17:16:25'!
calcularProfundidadDelSueloHasta: tipoDeCapa
	
	| valor acc ix |
	
	valor := 0.
	tipoDeCapa = #Arenoso ifTrue: [ valor := 7 ].
	tipoDeCapa = #Tierra ifTrue: [ valor := 10 ].
	tipoDeCapa = #Concreto ifTrue: [ valor := 50].	
	
	acc := 0.
	ix := 1.
	
	[ix <= capasDeSueloDebajo size] whileTrue: [ | capa altura |
		capa := capasDeSueloDebajo at: ix.
		
		valor = capa scan ifTrue: [ ^ acc ].
		
		altura := capa altura.
		altura = nil ifTrue: [ altura := 0 ].
		acc := acc + altura.
		ix := ix + 1.		
	].

	^ acc.
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'MS 4/27/2024 18:12:24'!
contarCapas: tipoDeCapa
	
	"Cuenta las capas de tipo tipoDeCapa. Recordar que para identificar cada capa se utiliza el valor de scan que retorna. Por ej. un capa tipo Arenoso retorna 7 al scan"
	
	| tipoDeCapaScan |
	
	tipoDeCapaScan := tipoDeCapa scan.
	
	^ capasDeSueloDebajo count: [ :capaDeSuelo | capaDeSuelo scan = tipoDeCapaScan ]	

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: '1c2023 - Resolucion'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'ARM 4/27/2023 20:07:05'!
sobreSuelo: capasDeSueloAExcavar 

	^self new initializeSobreSuelo: capasDeSueloAExcavar ! !
