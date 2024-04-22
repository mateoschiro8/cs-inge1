!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
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

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
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

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'itemCollection status'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'state updates' stamp: 'fb 4/21/2024 19:25:46'!
addItemToCollection: anItem

	itemCollection addLast: anItem! !

!OOStack methodsFor: 'state updates' stamp: 'fb 4/22/2024 12:37:57'!
updateState

	status := OOStackState currentState: self.! !


!OOStack methodsFor: 'internal messages' stamp: 'fb 4/21/2024 19:31:02'!
popElement

	^itemCollection removeLast! !

!OOStack methodsFor: 'internal messages' stamp: 'fb 4/21/2024 19:32:07'!
topElement

	^itemCollection at: itemCollection size ! !


!OOStack methodsFor: 'operations' stamp: 'fb 4/21/2024 19:00:42'!
isEmpty
	
	^ itemCollection size = 0! !

!OOStack methodsFor: 'operations' stamp: 'fb 4/21/2024 19:46:25'!
pop

	^status popIfItsPossible: self.! !

!OOStack methodsFor: 'operations' stamp: 'fb 4/21/2024 19:27:44'!
push: anItem
	
	status push: anItem into: self ! !

!OOStack methodsFor: 'operations' stamp: 'fb 4/21/2024 19:02:10'!
size

	^ itemCollection size! !

!OOStack methodsFor: 'operations' stamp: 'fb 4/21/2024 19:46:43'!
top

	^status topIfItsPossible: self.! !


!OOStack methodsFor: 'error raising' stamp: 'fb 4/22/2024 12:19:27'!
raiseEmptyStackError

	^self error:self class stackEmptyErrorDescription! !


!OOStack methodsFor: 'initialization' stamp: 'fb 4/21/2024 19:27:05'!
initialize
	
	itemCollection := OrderedCollection ofSize: 0.
	status := Empty new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


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

!Empty methodsFor: 'as yet unclassified' stamp: 'fb 4/22/2024 12:37:57'!
push: anItem into: anOOStack

	anOOStack addItemToCollection: anItem.
	anOOStack updateState.! !

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


!classDefinition: #NotEmpty category: #'Stack-Exercise'!
OOStackState subclass: #NotEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmpty methodsFor: 'as yet unclassified' stamp: 'fb 4/22/2024 12:37:57'!
popIfItsPossible: anOOStack
	
	| element |
	
	element := anOOStack popElement.
	
	anOOStack updateState.
	
	^element.! !

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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
