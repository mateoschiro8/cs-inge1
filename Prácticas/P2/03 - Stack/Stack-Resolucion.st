!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'tests catedra' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'tests catedra' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'tests catedra' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'tests catedra' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'tests catedra' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'tests catedra' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'tests catedra' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'tests catedra' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'tests catedra' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'tests catedra' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'tests catedra' stamp: 'fb 4/24/2024 12:27:29'!
test11CanNotPushElementsIntoStackOfCapacity0

	| stack |
	
	stack := OOStack ofSize: 0.
	
	self
		should: [ stack push: 'something'.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Limited stackFullErrorDescription ]
		! !



!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing methods' stamp: 'fb 4/24/2024 11:34:18'!
assertThat: anExpectedRes isEqualTo: aRes and: aStack isEqualTo: aPreviousStack

	self assert: anExpectedRes = aRes.
	self assert: aStack = aPreviousStack.! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fb 4/24/2024 11:30:54'!
test01UnElementoConPrefijo

	| stack prefix element expectedRes res sentenceFinder |
	
	stack := OOStack new.
	
	element := 'boca de mi corazon'.
	prefix := 'boca'.
	
	sentenceFinder  := SentenceFinderByPrefix new.
	expectedRes := OrderedCollection with: element.
	
	stack push: element.
	res := sentenceFinder findSentencesThatBeginWith: prefix InStack: stack.
	
	self assert: expectedRes = res
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fb 4/24/2024 11:30:54'!
test02StackVacio

	| stack prefix expectedRes res sentenceFinder |
	
	stack := OOStack new.
	
	sentenceFinder  := SentenceFinderByPrefix new.
	expectedRes := OrderedCollection ofSize: 0.
	prefix := 'boca'.
	
	res := sentenceFinder findSentencesThatBeginWith: prefix InStack: stack.
	
	self assert: expectedRes = res
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fb 4/24/2024 11:37:49'!
test03MasDeUnElementoConPrefijo

	| stack prefix element1 element2 expectedRes res sentenceFinder previousStack |
	
	stack := OOStack new.
	
	element1 := 'boca de mi corazon'.
	element2 := 'bocabocaboca'.
	prefix := 'boca'.
	
	sentenceFinder  := SentenceFinderByPrefix new.
	expectedRes := OrderedCollection with: element2.
	expectedRes addLast: element1.
	
	stack push: element1.
	stack push: element2.
	previousStack := stack.
	res := sentenceFinder findSentencesThatBeginWith: prefix InStack: stack.
	
	self assertThat: expectedRes isEqualTo: res and: stack isEqualTo: previousStack .

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fb 4/24/2024 11:42:32'!
test04SeComportaDeManeraCaseSensitive

	| stack prefix element1 element2 expectedRes res sentenceFinder previousStack |
	
	stack := OOStack new.
	
	element1 := 'boca de mi corazon'.
	element2 := 'bocabocaboca'.
	prefix := 'Boca'.
	
	sentenceFinder  := SentenceFinderByPrefix new.
	expectedRes := OrderedCollection ofSize: 0.
	
	stack push: element1.
	stack push: element2.
	previousStack := stack.
	res := sentenceFinder findSentencesThatBeginWith: prefix InStack: stack.
	
	self assertThat: expectedRes isEqualTo: res and: stack isEqualTo: previousStack .
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fb 4/24/2024 11:37:38'!
test05MasDeUnElementoConPrefijoYElementosSinPrefijo

	| stack prefix element1 element2 element3 element4 expectedRes res sentenceFinder previousStack |
	
	stack := OOStack new.
	
	element1 := 'boca de mi corazon'.
	element2 := 'bocabocaboca'.
	element3 := 'ferrocarril oeste'.
	element4 := 'CFK'.
	prefix := 'boca'.
	
	sentenceFinder  := SentenceFinderByPrefix new.
	expectedRes := OrderedCollection with: element2.
	expectedRes addLast: element1.
	
	stack push: element1.
	stack push: element3.
	stack push: element2.
	stack push: element4.
	previousStack := stack.
	res := sentenceFinder findSentencesThatBeginWith: prefix InStack: stack.
	
	self assertThat: expectedRes isEqualTo: res and: stack isEqualTo: previousStack .

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'fb 4/24/2024 11:43:10'!
test06NingunElementoTieneElPrefijo

	| stack prefix element1 element2 expectedRes res sentenceFinder previousStack |
	
	stack := OOStack new.
	
	element1 := 'boca de mi corazon'.
	element2 := 'bocabocaboca'.
	prefix := 'gimnasiaYEsgrima'.
	
	sentenceFinder  := SentenceFinderByPrefix new.
	expectedRes := OrderedCollection ofSize: 0.
	
	stack push: element1.
	stack push: element2.
	previousStack := stack.
	res := sentenceFinder findSentencesThatBeginWith: prefix InStack: stack.
	
	self assertThat: expectedRes isEqualTo: res and: stack isEqualTo: previousStack .
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'state updates' stamp: 'fb 4/24/2024 12:11:05'!
addItemToCollection: anItem

	self subclassResponsibility! !

!OOStack methodsFor: 'state updates' stamp: 'fb 4/23/2024 00:15:19'!
status

	^OOStackState currentState: self.
! !


!OOStack methodsFor: 'internal messages' stamp: 'fb 4/24/2024 12:05:49'!
popElement

	self subclassResponsibility! !

!OOStack methodsFor: 'internal messages' stamp: 'fb 4/24/2024 12:06:22'!
topElement

	self subclassResponsibility! !


!OOStack methodsFor: 'operations' stamp: 'fb 4/24/2024 12:05:33'!
isEmpty

	self subclassResponsibility! !

!OOStack methodsFor: 'operations' stamp: 'fb 4/24/2024 12:05:45'!
pop

	self subclassResponsibility! !

!OOStack methodsFor: 'operations' stamp: 'fb 4/24/2024 12:05:51'!
push: anItem

	self subclassResponsibility! !

!OOStack methodsFor: 'operations' stamp: 'fb 4/24/2024 12:06:03'!
size

	self subclassResponsibility! !

!OOStack methodsFor: 'operations' stamp: 'fb 4/24/2024 12:06:14'!
top

	self subclassResponsibility! !


!OOStack methodsFor: 'error raising' stamp: 'fb 4/22/2024 12:19:27'!
raiseEmptyStackError

	^self error:self class stackEmptyErrorDescription! !


!OOStack methodsFor: 'initialization' stamp: 'fb 4/24/2024 12:09:49'!
initialize
	
	^ Unlimited new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'fb 4/24/2024 12:30:11'!
ofSize: aSize

	| temp |
	
	temp := Limited new.
	^ temp initializeOfSize: aSize! !

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #Limited category: #'Stack-Exercise'!
OOStack subclass: #Limited
	instanceVariableNames: 'itemCollection capacity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Limited methodsFor: 'operations' stamp: 'fb 4/24/2024 12:05:33'!
isEmpty
	
	^ itemCollection size = 0! !

!Limited methodsFor: 'operations' stamp: 'fb 4/24/2024 12:05:45'!
pop

	^self status popIfItsPossible: self.! !

!Limited methodsFor: 'operations' stamp: 'fb 4/24/2024 12:05:51'!
push: anItem
	
	self status push: anItem into: self ! !

!Limited methodsFor: 'operations' stamp: 'fb 4/24/2024 12:06:03'!
size

	^ itemCollection size! !

!Limited methodsFor: 'operations' stamp: 'fb 4/24/2024 12:06:14'!
top

	^self status topIfItsPossible: self.! !


!Limited methodsFor: 'internal messages' stamp: 'fb 4/24/2024 12:05:49'!
popElement

	^itemCollection removeLast! !

!Limited methodsFor: 'internal messages' stamp: 'fb 4/24/2024 12:06:22'!
topElement

	^itemCollection at: itemCollection size ! !


!Limited methodsFor: 'initialization' stamp: 'fb 4/24/2024 12:16:54'!
initializeOfSize: aSize

	capacity := aSize.

	! !


!Limited methodsFor: 'state updates' stamp: 'fb 4/24/2024 12:11:05'!
addItemToCollection: anItem

	itemCollection addLast: anItem! !

!Limited methodsFor: 'state updates' stamp: 'fb 4/24/2024 12:17:23'!
isFilled

	^ self size = capacity! !


!Limited methodsFor: 'error raising' stamp: 'fb 4/24/2024 12:23:51'!
raiseFullStackError

	^self error:self class stackFullErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Limited class' category: #'Stack-Exercise'!
Limited class
	instanceVariableNames: ''!

!Limited class methodsFor: 'error descriptions' stamp: 'fb 4/24/2024 12:24:37'!
stackFullErrorDescription
	
	^ 'stack is full!!!!!!'! !


!classDefinition: #Unlimited category: #'Stack-Exercise'!
OOStack subclass: #Unlimited
	instanceVariableNames: 'itemCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Unlimited methodsFor: 'initialization' stamp: 'fb 4/24/2024 12:08:47'!
initialize
	
	itemCollection := OrderedCollection ofSize: 0.
	^self.! !


!Unlimited methodsFor: 'operations' stamp: 'fb 4/24/2024 12:05:33'!
isEmpty
	
	^ itemCollection size = 0! !

!Unlimited methodsFor: 'operations' stamp: 'fb 4/24/2024 12:05:45'!
pop

	^self status popIfItsPossible: self.! !

!Unlimited methodsFor: 'operations' stamp: 'fb 4/24/2024 12:05:51'!
push: anItem
	
	self status push: anItem into: self ! !

!Unlimited methodsFor: 'operations' stamp: 'fb 4/24/2024 12:06:03'!
size

	^ itemCollection size! !

!Unlimited methodsFor: 'operations' stamp: 'fb 4/24/2024 12:06:14'!
top

	^self status topIfItsPossible: self.! !


!Unlimited methodsFor: 'internal messages' stamp: 'fb 4/24/2024 12:05:49'!
popElement

	^itemCollection removeLast! !

!Unlimited methodsFor: 'internal messages' stamp: 'fb 4/24/2024 12:06:22'!
topElement

	^itemCollection at: itemCollection size ! !


!Unlimited methodsFor: 'state updates' stamp: 'fb 4/24/2024 12:11:05'!
addItemToCollection: anItem

	itemCollection addLast: anItem! !

!Unlimited methodsFor: 'state updates' stamp: 'fb 4/24/2024 12:20:51'!
isFilled

	^false! !


!classDefinition: #OOStackState category: #'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'as yet unclassified' stamp: 'fb 4/22/2024 12:37:26'!
currentState: anOOStack
	
	^(OOStackState allSubclasses select: [:aSubclass | aSubclass isCurrentStateOf: anOOStack]) new.! !

!OOStackState methodsFor: 'as yet unclassified' stamp: 'fb 4/21/2024 19:46:25'!
popIfItsPossible: anOOStack

	self subclassResponsibility! !

!OOStackState methodsFor: 'as yet unclassified' stamp: 'fb 4/21/2024 19:21:16'!
pushItemInto: anOOStack

	self subclassResponsibility! !

!OOStackState methodsFor: 'as yet unclassified' stamp: 'fb 4/21/2024 19:46:43'!
topIfItsPossible: anOOStack

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: #'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'state' stamp: 'fb 4/22/2024 12:37:26'!
currentState: anOOStack
	
	^(OOStackState allSubclasses select: [:aSubclass | aSubclass isCurrentStateOf: anOOStack]) first new.! !


!classDefinition: #Empty category: #'Stack-Exercise'!
OOStackState subclass: #Empty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Empty methodsFor: 'as yet unclassified' stamp: 'fb 4/21/2024 19:46:25'!
popIfItsPossible: anOOStack

	anOOStack raiseEmptyStackError! !

!Empty methodsFor: 'as yet unclassified' stamp: 'fb 4/23/2024 00:17:27'!
push: anItem into: anOOStack

	anOOStack addItemToCollection: anItem.
! !

!Empty methodsFor: 'as yet unclassified' stamp: 'fb 4/21/2024 19:46:43'!
topIfItsPossible: anOOStack

	anOOStack raiseEmptyStackError! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Empty class' category: #'Stack-Exercise'!
Empty class
	instanceVariableNames: ''!

!Empty class methodsFor: 'state' stamp: 'fb 4/22/2024 12:37:25'!
isCurrentStateOf: anOOStack

	^ anOOStack size = 0! !


!classDefinition: #Filled category: #'Stack-Exercise'!
OOStackState subclass: #Filled
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Filled methodsFor: 'as yet unclassified' stamp: 'fb 4/24/2024 12:18:37'!
popIfItsPossible: anOOStack
	
	^anOOStack popElement.
	
! !

!Filled methodsFor: 'as yet unclassified' stamp: 'fb 4/24/2024 12:19:11'!
push: anItem into: anOOStack

	anOOStack raiseStackFullError! !

!Filled methodsFor: 'as yet unclassified' stamp: 'fb 4/24/2024 12:18:43'!
topIfItsPossible: anOOStack

	^anOOStack topElement! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Filled class' category: #'Stack-Exercise'!
Filled class
	instanceVariableNames: ''!

!Filled class methodsFor: 'as yet unclassified' stamp: 'fb 4/24/2024 12:17:51'!
isCurrentStateOf: anOOStack

	^anOOStack isFilled ! !


!classDefinition: #NotEmpty category: #'Stack-Exercise'!
OOStackState subclass: #NotEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmpty methodsFor: 'as yet unclassified' stamp: 'fb 4/23/2024 00:17:49'!
popIfItsPossible: anOOStack
	
	^anOOStack popElement.
	
! !

!NotEmpty methodsFor: 'as yet unclassified' stamp: 'fb 4/22/2024 12:28:01'!
push: anItem into: anOOStack

	anOOStack addItemToCollection: anItem.! !

!NotEmpty methodsFor: 'as yet unclassified' stamp: 'fb 4/22/2024 12:27:48'!
topIfItsPossible: anOOStack

	^anOOStack topElement! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmpty class' category: #'Stack-Exercise'!
NotEmpty class
	instanceVariableNames: ''!

!NotEmpty class methodsFor: 'state' stamp: 'fb 4/22/2024 12:37:26'!
isCurrentStateOf: anOOStack

	^ anOOStack size > 0! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'elementsFoundInStackWithPrefixCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'fb 4/24/2024 11:05:08'!
initialize

	elementsFoundInStackWithPrefixCollection  := OrderedCollection ofSize: 0.! !


!SentenceFinderByPrefix methodsFor: 'methods' stamp: 'fb 4/24/2024 11:31:34'!
findSentencesThatBeginWith: aPrefix InStack: aStack
		
	"devuelve una OrderedCollection con los elementos que tengan como prefijo aPrefix en el orden que se poppean del stack, o sea digamos, 
	en orden inverso al que fueron pusheados. - Felipe y Mateo, un saludo"	
		
	| poppedElement |
		
	aStack isEmpty
		ifTrue:[^OrderedCollection ofSize: 0.].
	
	poppedElement := aStack pop.
	
	(poppedElement beginsWith: aPrefix)
		ifTrue:[elementsFoundInStackWithPrefixCollection addLast: poppedElement] .
	
	"recursion"	
	self findSentencesThatBeginWith: aPrefix InStack: aStack.
		
	aStack push: poppedElement.
	
	^elementsFoundInStackWithPrefixCollection 
	
	
	
	"
	findAppearancesOf: aPrefix InStack: aStack
		
	| element res |
		
	aStack isEmpty
		ifTrue:[^OrderedCollection ofSize: 0].
	
	element := aStack pop.
	
	(element beginsWith: aPrefix)
		ifTrue:[ res  := (self findAppearancesOf: aPrefix InStack: aStack) addLast: element].
		
	(element beginsWith: aPrefix)
		ifFalse: [res  := (self findAppearancesOf: aPrefix InStack: aStack)].
		
	aStack push: element.
	
	^res
	
	"
	
	
	! !
