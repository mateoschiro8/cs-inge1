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

!I class methodsFor: 'as yet unclassified' stamp: 'MS 3/22/2024 13:48:33'!
- aSustrahend
	self error: 'No permitido'! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 3/22/2024 14:05:04'!
/ aDividend
	self error: 'No permitido'! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 3/25/2024 21:48:30'!
leRestaA: numeroAlQueLeResta
	^numeroAlQueLeResta previous! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 3/25/2024 21:50:13'!
loMultiplicaA: numeroAMultiplicar
	^ numeroAMultiplicar ! !

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

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/22/2024 13:47:10'!
+ anAdder
	^ self previous + anAdder next! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/25/2024 21:48:22'!
- aSustrahend
	^ aSustrahend leRestaA: self ! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/22/2024 14:29:19'!
/ aDividend
	| divisor dividendo cociente |
	divisor := self.
	cociente  := I.
	[divisor = I] 
		whileFalse: [divisor := divisor - aDividend . cociente := cociente next]. 
	^ cociente
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/22/2024 13:44:53'!
establecerPrevio: numeroPrevio
	previo := numeroPrevio! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/25/2024 21:48:01'!
leRestaA: numeroAlQueLeResta
	^ numeroAlQueLeResta previous - self previous ! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/25/2024 21:51:03'!
loMultiplicaA: numeroAMultiplicar
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/22/2024 13:45:18'!
next
	| nuevo |
	nuevo := II createChildNamed: self name , 'I' .
	nuevo establecerPrevio: self .
	^ nuevo! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 3/22/2024 13:44:18'!
previous
	^ previo ! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'MS 3/25/2024 22:00:07'!
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

!III class methodsFor: '--** private fileout/in **--' stamp: 'MS 3/25/2024 22:00:07'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := II.! !


!classDefinition: #IIII category: #Ejercicio4!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #Ejercicio4!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'MS 3/25/2024 22:00:07'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := III.! !


!classDefinition: #IIIII category: #Ejercicio4!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #Ejercicio4!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'MS 3/25/2024 22:00:07'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := IIII.! !


!classDefinition: #IIIIII category: #Ejercicio4!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: #Ejercicio4!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'MS 3/25/2024 22:00:07'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previo := IIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!