!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'fb 4/9/2024 11:54:57'!
checkThat: aCustomerBook hasActive: aNumberOfActiveCustomers andSuspended: aNumberOfSuspendedCustomers andTotal: aNumberOfCustomers

	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fb 4/8/2024 21:21:22'!
doing:anAction shouldNotTakeMoreThan: numberOfMilliseconds 

	| millisecondsBeforeRunning  millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	anAction value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (numberOfMilliseconds * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fb 4/9/2024 11:15:27'!
doing: anAction throws: anError thatAsserts: assert1 and: assert2

	"preguntar si se puede poner para que se puedan pasar una cantidad de asserts no definida, o sea, and:and:and ... "

	[ anAction value.
	self fail ]
		on: anError 
		do:  [ :anErrorParameter | 
            			self assert: (assert1 value: anErrorParameter).
           			self assert: (assert2 value: anErrorParameter). ]
		 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fb 4/8/2024 21:20:45'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook millisecondsBeforeRunning millisecondsAfterRunning |
	
	customerBook := CustomerBook new.
	
	self doing:[customerBook addCustomerNamed: 'John Lennon'.] shouldNotTakeMoreThan: 50! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fb 4/8/2024 21:23:17'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	self doing:[customerBook removeCustomerNamed: 'Paul McCartney'.] shouldNotTakeMoreThan: 100
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fb 4/9/2024 11:07:15'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook anAction assert1 assert2 |
			
	customerBook := CustomerBook new.
	
	anAction := 	[ customerBook addCustomerNamed: ''.].
	assert1 := [:anErrorParameter | anErrorParameter messageText = CustomerBook customerCanNotBeEmptyErrorMessage.].
	assert2 := [:anErrorParameter | customerBook isEmpty]. 
	
	self doing: anAction throws: Error thatAsserts: assert1 and: assert2
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fb 4/9/2024 11:13:58'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon anAction assert1 assert2 |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	anAction := [customerBook removeCustomerNamed: 'Paul McCartney'.].
	assert1 := [:anErrorParameter | customerBook numberOfCustomers = 1.].
	assert2 := [:anErrorParameter | (customerBook includesCustomerNamed: johnLennon).].

	self doing: anAction throws: NotFound thatAsserts: assert1 and: assert2 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fb 4/9/2024 11:55:11'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self checkThat: customerBook hasActive: 0 andSuspended: 1 andTotal: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fb 4/9/2024 11:55:24'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self checkThat: customerBook hasActive: 0 andSuspended: 0 andTotal: 0.

	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fb 4/9/2024 11:17:06'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon anAction assert1 assert2|
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	anAction := [customerBook suspendCustomerNamed: 'George Harrison'.].
	assert1 := [:anErrorParameter | customerBook numberOfCustomers = 1.].
	assert2 := [:anErrorParameter | (customerBook includesCustomerNamed: johnLennon).].
	
	self doing: anAction throws: CantSuspend thatAsserts: assert1 and: assert2
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'fb 4/9/2024 11:18:17'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon anAction assert1 assert2 |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	anAction := [customerBook suspendCustomerNamed: johnLennon.].
	assert1 := [:anErrorParameter |  customerBook numberOfCustomers = 1.].
	assert2 := [:anErrorParameter | (customerBook includesCustomerNamed: johnLennon).].
	
	self doing: anAction throws: CantSuspend thatAsserts: assert1 and: assert2.


! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBookTest class' category: #'CodigoRepetido-Ejercicio'!
CustomerBookTest class
	instanceVariableNames: 'test03CanNotAddACustomerWithEmptyName'!


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'fb 4/9/2024 12:00:09'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName)  ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'fb 4/9/2024 12:04:56'!
removeACustomer: aCustomerName from: aCustomersArray

1 to: aCustomersArray size do: 
    [ :index |
        aCustomerName = (aCustomersArray at: index)
            ifTrue: [
                aCustomersArray removeAt: index.
                ^ aCustomerName 
            ] 
    ].! !

!CustomerBook methodsFor: 'customer management' stamp: 'MS 4/12/2024 12:09:24'!
removeACustomer: aCustomerName from: aCustomersArray ifAbsentDo: anAction.

	1 to: aCustomersArray size do: 
	    [ :index |
	        aCustomerName = (aCustomersArray at: index)
	            ifTrue: [
	                aCustomersArray removeAt: index.
	                ^ aCustomerName 
	            ] 
	    ].

	anAction value.! !

!CustomerBook methodsFor: 'customer management' stamp: 'MS 4/12/2024 12:10:18'!
removeCustomerNamed: aName 
 
	self removeACustomer: aName from: active ifAbsentDo: [
		self removeACustomer: aName from: suspended ifAbsentDo:
			[^ NotFound signal.].].

	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
