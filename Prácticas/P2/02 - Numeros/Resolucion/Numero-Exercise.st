!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value enterOo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'MS 4/15/2024 11:30:43'!
* aMultiplier 

	(aMultiplier isKindOf: Entero)
			ifTrue: [^self multiplicarEnteroConEntero: aMultiplier].
	
	(aMultiplier isKindOf: Fraccion)		
			ifTrue: [ ^self multiplicarEnteroConFraccion: aMultiplier]

	"(aMultiplier isKindOf: Entero)
			ifTrue: [^self class with: value * aMultiplier integerValue].
	
	(aMultiplier isKindOf: Fraccion)		
			ifTrue: [   | newNumerator newDenominator |
					
					newNumerator := (self * aMultiplier numerator).
					newDenominator := aMultiplier denominator.
				
					^ newNumerator / newDenominator ]."! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MS 4/15/2024 11:19:32'!
+ anAdder 
		
	(anAdder isKindOf: Entero)
			ifTrue: [^self sumarEnteroConEntero: anAdder].
	
	(anAdder isKindOf: Fraccion)		
			ifTrue: [^self sumarEnteroConFraccion: anAdder ]. 
	
	" (anAdder isKindOf: Entero)
			ifTrue: [^self class with: value + anAdder integerValue].
	
	(anAdder isKindOf: Fraccion)		
			ifTrue: [   | newNumerator newDenominator |
					
					newNumerator := (self * anAdder denominator + anAdder numerator).
					newDenominator := anAdder denominator.
				
					^ newNumerator / newDenominator ]. "! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MS 4/15/2024 11:29:51'!
- aSubtrahend 
	
	(aSubtrahend isKindOf: Entero)
			ifTrue: [^ self restarEnteroConEntero: aSubtrahend ].
	
	(aSubtrahend isKindOf: Fraccion)		
			ifTrue: [ ^ self restarEnteroConFraccion: aSubtrahend  ].
	
	"(aSubtrahend isKindOf: Entero)
			ifTrue: [^ self class with: value - aSubtrahend integerValue.].
	
	(aSubtrahend isKindOf: Fraccion)		
			ifTrue: [   | newNumerator newDenominator |
										
					newNumerator := (self * (aSubtrahend denominator) - (aSubtrahend numerator)).
					newDenominator := aSubtrahend denominator.

					^ newNumerator / newDenominator  ]."! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MS 4/15/2024 11:38:40'!
/ aDivisor 
	
	(aDivisor isKindOf: Entero)
			ifTrue: [^ self dividirEnteroConEntero: aDivisor ].
	
	(aDivisor isKindOf: Fraccion)		
			ifTrue: [ ^ self dividirEnteroConFraccion: aDivisor ]
	
	"(aDivisor isKindOf: Entero)
			ifTrue: [^Fraccion with: self over: aDivisor].
	
	(aDivisor isKindOf: Fraccion)		
			ifTrue: [   | newNumerator newDenominator |
					
					newNumerator := (self * aDivisor denominator).
					newDenominator := aDivisor numerator.
				
					^ Fraccion with: newNumerator over: newDenominator ]."! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MS 4/15/2024 12:00:02'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	self isNegative ifTrue: [self error: Entero negativeFibonacciErrorDescription ].	
	(self isZero or: [self isOne]) ifTrue: [^one].
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'MS 4/12/2024 16:34:52'!
initalizeWith: aValue 
	
	value := aValue.
	enterOo := EnteroConEntero new! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:35:56'!
dividirEnteroConEntero: anIntegerDivisor
	
	^Fraccion with: self over: anIntegerDivisor

	! !

!Entero methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:36:57'!
dividirEnteroConFraccion: aFraccionDivisor
	
	| newNumerator newDenominator |
					
	newNumerator := (self * aFraccionDivisor denominator).
	newDenominator := aFraccionDivisor numerator.

	^ Fraccion with: newNumerator over: newDenominator 

	! !

!Entero methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:28:15'!
multiplicarEnteroConEntero: anIntegerMultiplier
	
	^self class with: value * anIntegerMultiplier integerValue

	! !

!Entero methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:28:46'!
multiplicarEnteroConFraccion: aFraccionMultiplier
	
	| newNumerator newDenominator |
					
	newNumerator := (self * aFraccionMultiplier numerator).
	newDenominator := aFraccionMultiplier denominator.

	^ newNumerator / newDenominator

	! !

!Entero methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:26:47'!
restarEnteroConEntero: anIntegerSubtrahend 
	
	^ self class with: value - anIntegerSubtrahend integerValue.
	

	! !

!Entero methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:27:10'!
restarEnteroConFraccion: anIntegerSubtrahend 
	
	| newNumerator newDenominator |
					
	newNumerator := (self * (anIntegerSubtrahend denominator) - (anIntegerSubtrahend numerator)).
	newDenominator := anIntegerSubtrahend denominator.

	^ newNumerator / newDenominator

	! !

!Entero methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:19:37'!
sumarEnteroConEntero: anIntegerAdder 
	
	^self class with: value + anIntegerAdder integerValue
	

	! !

!Entero methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:19:24'!
sumarEnteroConFraccion: aFraccionAdder 
	
	| newNumerator newDenominator |
					
	newNumerator := (self * aFraccionAdder denominator + aFraccionAdder numerator).
	newDenominator := aFraccionAdder denominator.

	^ newNumerator / newDenominator
	

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'HernanWilkinson 5/7/2016 22:53'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initalizeWith: aValue! !


!classDefinition: #One category: #'Numero-Exercise'!
Entero subclass: #One
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!One methodsFor: 'as yet unclassified' stamp: 'MS 4/15/2024 11:54:54'!
fibonacci

	^ 1! !


!classDefinition: #Zero category: #'Numero-Exercise'!
Entero subclass: #Zero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Zero methodsFor: 'as yet unclassified' stamp: 'MS 4/15/2024 11:55:00'!
fibonacci

	^ 1! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 4/15/2024 11:33:12'!
* aMultiplier 
	
	(aMultiplier isKindOf: Entero)
			ifTrue: [ ^ self multiplicarFraccionConEntero: aMultiplier ].
	
	(aMultiplier isKindOf: Fraccion)		
			ifTrue: [  ^ self multiplicarFraccionConFraccion: aMultiplier ].
			
	" (aMultiplier isKindOf: Entero)
			ifTrue: [		| newNumerator newDenominator |
					
					newNumerator := (numerator * aMultiplier).
					newDenominator := denominator.
				
					^ newNumerator / newDenominator ].
	
	(aMultiplier isKindOf: Fraccion)		
			ifTrue: [   | newNumerator newDenominator |
					
					newNumerator := (numerator * aMultiplier numerator).
					newDenominator := (denominator * aMultiplier denominator).
				
					^ newNumerator / newDenominator ]. "! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 4/15/2024 11:22:57'!
+ anAdder 
	
	(anAdder isKindOf: Entero)
			ifTrue: [^ self sumarFraccionConEntero: anAdder].
	
	(anAdder isKindOf: Fraccion)		
			ifTrue: [^ self sumarFraccionConEntero: anAdder ] 
		
	"(anAdder isKindOf: Entero)
			
			ifTrue: [^(denominator * anAdder + numerator) / denominator].
	
	(anAdder isKindOf: Fraccion)		
			ifTrue: [   | newNumerator newDenominator |
					
					newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
					newDenominator := denominator * anAdder denominator.
					
					^newNumerator / newDenominator ] "! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 4/15/2024 11:26:09'!
- aSubtrahend 

	(aSubtrahend isKindOf: Entero)
			ifTrue: [ ^ self restarFraccionConEntero: aSubtrahend ].
	
	(aSubtrahend isKindOf: Fraccion)		
			ifTrue: [ ^ self restarFraccionConFraccion: aSubtrahend ]
		
	" (aSubtrahend isKindOf: Entero)
			ifTrue: [| newNumerator newDenominator |
					
					newNumerator := (numerator - (aSubtrahend * denominator)).
					newDenominator := denominator.
				
					^ newNumerator / newDenominator].
	
	(aSubtrahend isKindOf: Fraccion)		
			ifTrue: [   | newNumerator newDenominator |
	
					newNumerator := (numerator * aSubtrahend denominator) - (denominator * aSubtrahend numerator).
					newDenominator := denominator * aSubtrahend denominator.
					
					^newNumerator / newDenominator ]. "
	
	
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MS 4/15/2024 11:40:31'!
/ aDivisor 
			
	(aDivisor isKindOf: Entero)
			ifTrue: [^self dividirFraccionConEntero: aDivisor].
	
	(aDivisor isKindOf: Fraccion)		
			ifTrue: [^self dividirFraccionConFraccion: aDivisor]
			
	"(aDivisor isKindOf: Entero)
			ifTrue: [^Fraccion with: numerator over: aDivisor * denominator].
	
	(aDivisor isKindOf: Fraccion)		
			ifTrue: [   | newNumerator newDenominator |
					
					newNumerator := (numerator * aDivisor denominator).
					newDenominator := (denominator * aDivisor numerator).
				
					^ Fraccion with: newNumerator over: newDenominator ]."! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:39:13'!
dividirFraccionConEntero: anIntegerDivisor 
	
	^Fraccion with: numerator over: anIntegerDivisor * denominator! !

!Fraccion methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:39:43'!
dividirFraccionConFraccion: aFraccionDivisor 
	
	| newNumerator newDenominator |
					
	newNumerator := (numerator * aFraccionDivisor denominator).
	newDenominator := (denominator * aFraccionDivisor numerator).

	^ Fraccion with: newNumerator over: newDenominator! !

!Fraccion methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:31:24'!
multiplicarFraccionConEntero: anIntegerMultiplier 
	
	| newNumerator newDenominator |
					
	newNumerator := (numerator * anIntegerMultiplier).
	newDenominator := denominator.

	^ newNumerator / newDenominator
	! !

!Fraccion methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:32:06'!
multiplicarFraccionConFraccion: aFraccionMultiplier 
	
	 | newNumerator newDenominator |
					
	newNumerator := (numerator * aFraccionMultiplier numerator).
	newDenominator := (denominator * aFraccionMultiplier denominator).

	^ newNumerator / newDenominator	! !

!Fraccion methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:24:19'!
restarFraccionConEntero: anIntegerSubtrahend 
	
	| newNumerator newDenominator |
	
	newNumerator := (numerator - (anIntegerSubtrahend * denominator)).
	newDenominator := denominator.

	^ newNumerator / newDenominator
	
	! !

!Fraccion methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:25:10'!
restarFraccionConFraccion: aFraccionSubtrahend 
	
	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraccionSubtrahend denominator) - (denominator * aFraccionSubtrahend numerator).
	newDenominator := denominator * aFraccionSubtrahend denominator.
	
	^newNumerator / newDenominator
	
	! !

!Fraccion methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:20:24'!
sumarFraccionConEntero: anIntegerAdder 
	
	^(denominator * anIntegerAdder + numerator) / denominator.
	
	! !

!Fraccion methodsFor: 'arithmetic operations methods' stamp: 'MS 4/15/2024 11:21:24'!
sumarFraccionConFraccion: aFraccionAdder 
	
	| newNumerator newDenominator |
					
	newNumerator := (numerator * aFraccionAdder denominator) + (denominator * aFraccionAdder numerator).
	newDenominator := denominator * aFraccionAdder denominator.
	
	^newNumerator / newDenominator .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !


!classDefinition: #Operaciones category: #'Numero-Exercise'!
Object subclass: #Operaciones
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!


!classDefinition: #EnteroS category: #'Numero-Exercise'!
Operaciones subclass: #EnteroS
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroS methodsFor: 'as yet unclassified' stamp: 'MS 4/12/2024 16:27:04'!
add: anAdder to: aNumber

	self subclassResponsibility ! !


!classDefinition: #EnteroConEntero category: #'Numero-Exercise'!
EnteroS subclass: #EnteroConEntero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroConEntero methodsFor: 'as yet unclassified' stamp: 'MS 4/12/2024 16:25:23'!
add: anAdder to: anInteger

	^ Entero with: (anInteger integerValue + anAdder integerValue)! !


!classDefinition: #EnteroConFraccion category: #'Numero-Exercise'!
EnteroS subclass: #EnteroConFraccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!


!EnteroConFraccion methodsFor: 'as yet unclassified' stamp: 'MS 4/12/2024 16:26:28'!
add: aFraction to: anInteger

	 | newNumerator newDenominator |
					
	newNumerator := (anInteger * aFraction denominator + aFraction numerator).
	newDenominator := aFraction denominator.

	^ newNumerator / newDenominator! !


!classDefinition: #FraccionS category: #'Numero-Exercise'!
Operaciones subclass: #FraccionS
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!


!classDefinition: #FraccionConEntero category: #'Numero-Exercise'!
FraccionS subclass: #FraccionConEntero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!


!classDefinition: #FraccionConFraccion category: #'Numero-Exercise'!
FraccionS subclass: #FraccionConFraccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!
