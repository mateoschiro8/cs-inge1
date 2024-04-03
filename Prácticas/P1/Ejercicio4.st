!classDefinition: #I category: #Ejercicio4!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #Ejercicio4!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'MS 3/22/2024 13:50:16'!
* aMultiplicand
	^ aMultiplicand ! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 3/22/2024 13:46:45'!
+ anAdder
	^ anAdder next! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 4/3/2024 11:08:31'!
- aSustrahend
	self error: 'No permitido'! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 4/3/2024 11:07:20'!
/ aDividend
	aDividend = I
		ifTrue:[^I] 
		ifFalse:[self error: 'No permitido'].! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 4/3/2024 11:02:27'!
> unNumero

	^ false! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 4/3/2024 11:12:35'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No permitido'! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 4/3/2024 11:10:40'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^ 'No permitido'! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 3/25/2024 21:48:30'!
leRestaA: numeroAlQueLeResta
	^numeroAlQueLeResta previous! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 3/22/2024 13:43:47'!
next
	^ II ! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 3/25/2024 21:32:52'!
previous
	self error: 'No permitido'! !


!classDefinition: #II category: #Ejercicio4!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #Ejercicio4!
II class
	instanceVariableNames: 'previo'!

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/25/2024 21:59:53'!
* aMultiplicand
	| suma |
	suma := aMultiplicand . 
	suma := suma + (self previous * aMultiplicand).
	^ suma! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 4/3/2024 10:26:54'!
+ anAdder

	^ self previous + anAdder next! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/25/2024 21:48:22'!
- aSustrahend
	^ aSustrahend leRestaA: self ! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 4/3/2024 11:04:40'!
/ aDividend
	| cociente |
	aDividend = self
		ifTrue: [^I].
		
	aDividend = I
		ifTrue:[^self].
		
	aDividend > self
		ifFalse: [cociente := I + ((self - aDividend)/aDividend)]
		ifTrue: [self error: 'No permitido'].
	 	
	^cociente! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 4/3/2024 11:02:18'!
> unNumero

	 unNumero = I
		ifTrue:[^true]
		ifFalse:[^self previous > unNumero previous]! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 4/3/2024 11:12:48'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No permitido'! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/22/2024 13:44:53'!
establecerPrevio: numeroPrevio
	previo := numeroPrevio! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/25/2024 21:48:01'!
leRestaA: numeroAlQueLeResta
	^ numeroAlQueLeResta previous - self previous ! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 4/3/2024 11:39:31'!
nameOfNext

	(self name endsWith: 'DCCCXCIX') ifTrue: [^(self name withoutSuffix:'DCCCXCIX'), 'CM'].

	(self name endsWith: 'CMXCIX') ifTrue: [^(self name withoutSuffix:'CMXCIX'), 'M'].


	(self name endsWith: 'CCCXCIX') ifTrue: [^(self name withoutSuffix:'CCCXCI'), 'CD'].

	(self name endsWith: 'CDXCIX') ifTrue: [^(self name withoutSuffix:'CDXCIX'), 'D'].


	(self name endsWith: 'LXXXIX') ifTrue: [^(self name withoutSuffix:'LXXXIX'), 'XC'].

	(self name endsWith: 'XCIX') ifTrue: [^(self name withoutSuffix:'XCIX'), 'C'].


	(self name endsWith: 'XXXIX') ifTrue: [^(self name withoutSuffix:'XXXIX'), 'XL'].
	
	(self name endsWith: 'XLIX') ifTrue: [^(self name withoutSuffix:'XLIX'), 'L'].
	 
	
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix:'VIII'), 'IX'].
	
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix:'IX'), 'X'].
	

	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix:'III'), 'IV'].
	
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix:'IV'), 'V'].
	

	
	^ self name, 'I'! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 4/3/2024 11:26:05'!
next
	| nuevo |
	nuevo := II createChildNamed: self nameOfNext.
	nuevo establecerPrevio: self .
	^ nuevo! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/22/2024 13:44:18'!
previous
	^ previo ! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'MS 4/3/2024 11:55:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := I.! !


!classDefinition: #III category: #Ejercicio4!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #Ejercicio4!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'MS 4/3/2024 11:55:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := II.! !


!classDefinition: #IV category: #Ejercicio4!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: #Ejercicio4!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'MS 4/3/2024 11:55:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := III.! !


!classDefinition: #V category: #Ejercicio4!
II subclass: #V
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'V class' category: #Ejercicio4!
V class
	instanceVariableNames: ''!

!V class methodsFor: '--** private fileout/in **--' stamp: 'MS 4/3/2024 11:55:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := IV.! !


!classDefinition: #VI category: #Ejercicio4!
II subclass: #VI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VI class' category: #Ejercicio4!
VI class
	instanceVariableNames: ''!

!VI class methodsFor: '--** private fileout/in **--' stamp: 'MS 4/3/2024 11:55:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := V.! !


!classDefinition: #VII category: #Ejercicio4!
II subclass: #VII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VII class' category: #Ejercicio4!
VII class
	instanceVariableNames: ''!

!VII class methodsFor: '--** private fileout/in **--' stamp: 'MS 4/3/2024 11:55:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := VI.! !


!classDefinition: #VIII category: #Ejercicio4!
II subclass: #VIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VIII class' category: #Ejercicio4!
VIII class
	instanceVariableNames: ''!

!VIII class methodsFor: '--** private fileout/in **--' stamp: 'MS 4/3/2024 11:55:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := VII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!
V initializeAfterFileIn!
VI initializeAfterFileIn!
VII initializeAfterFileIn!
VIII initializeAfterFileIn!