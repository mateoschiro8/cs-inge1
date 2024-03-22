!classDefinition: #Falso category: #Ejercicio3!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #Ejercicio3!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:26:09'!
no
	^ Verdadero ! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:31:41'!
o: unBooleano
	^ unBooleano ! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:45:42'!
siFalso: unaAccionARealizarUIgnorar
	unaAccionARealizarUIgnorar value! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:44:56'!
siVerdadero: unaAccionARealizarUIgnorar
	! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:27:18'!
y: unBooleano
	^ Falso ! !


!classDefinition: #Verdadero category: #Ejercicio3!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #Ejercicio3!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:26:20'!
no
	^ Falso ! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:31:57'!
o: unBooleano
	^ Verdadero ! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:47:00'!
siFalso: unaunaAccionARealizarUIgnorar
	! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:46:49'!
siVerdadero: unaAccionARealizarUIgnorar
	unaAccionARealizarUIgnorar value! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'MS 3/18/2024 21:27:59'!
y: unBooleano
	^ unBooleano ! !


!classDefinition: #tests category: #Ejercicio3!
DenotativeObject subclass: #tests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'tests class' category: #Ejercicio3!
tests class
	instanceVariableNames: ''!

!tests class methodsFor: 'tests' stamp: 'MS 3/21/2024 20:44:21'!
test01
	Assert that: (Verdadero y: Falso) isEqualTo: Falso! !


!tests class methodsFor: 'tests' stamp: 'MS 3/21/2024 20:44:21'!
test01
	Assert that: (Verdadero y: Falso) isEqualTo: Falso! !
