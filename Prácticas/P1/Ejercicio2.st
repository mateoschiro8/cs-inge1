!classDefinition: #Bill category: #Ejercicio2!
DenotativeObject subclass: #Bill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bill class' category: #Ejercicio2!
Bill class
	instanceVariableNames: 'energia'!

!Bill class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:21:53'!
caminar: unaCantidadDeKilometros
	energia := energia - ((3 + unaCantidadDeKilometros) * day) ! !

!Bill class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:18:34'!
comer: unaCantidadDeKilosDeCerebros
	energia := energia + ((unaCantidadDeKilosDeCerebros / 4) * day)! !

!Bill class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:20:11'!
energia
	^energia
	! !

!Bill class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:22:26'!
reset
	energia := (28 * day)! !


!Bill class methodsFor: '--** private fileout/in **--' stamp: 'MS 3/18/2024 21:58:28'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energia := (SimpleMeasure basicNew instVarAt: 1 put: 28; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'day'; instVarAt: 2 put: 'days'; instVarAt: 3 put: 'NO SIGN'; yourself); yourself).! !

Bill initializeAfterFileIn!