!classDefinition: #PersistentSet category: #CustomerImporter!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
	session persist: newObject.
	
	^newObject! !


!PersistentSet methodsFor: 'private' stamp: 'HAW 6/18/2024 10:24:25'!
species

	^Set ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: #CustomerImporter!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportTest category: #CustomerImporter!
TestCase subclass: #ImportTest
	instanceVariableNames: 'dataBaseSession'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'test' stamp: 'MS 6/19/2024 13:37:24'!
assertDataForClient1IsCorrect

	| customer1 customer1address1 customer1address2 |
	
	customer1 := (dataBaseSession 
     		select: [ :aCustomer | aCustomer identificationType = 'D' and: [ aCustomer identificationNumber = '22333444' ]]
     		ofType: Customer) anyOne.
	
	self assertEqualityOfCustomer: customer1 forName: 'Pepe' forLastName: 'Sanchez'.
	
	customer1address1 := (customer1 addresses select: [ :anAddress | anAddress streetName = 'San Martin' ]) anyOne.
	self assertEqualityOfAddress: customer1address1 forStreetNumber: 3322 forTown: 'Olivos' forZipCode: 1636 forProvince: 'BsAs'.
	
	customer1address2 := (customer1 addresses select: [ :anAddress | anAddress streetName = 'Maipu' ]) anyOne.
	self assertEqualityOfAddress: customer1address2 forStreetNumber: 888 forTown: 'Florida' forZipCode: 1122 forProvince: 'Buenos Aires'! !

!ImportTest methodsFor: 'test' stamp: 'MS 6/19/2024 13:37:32'!
assertDataForClient2IsCorrect

	| customer2 customer2address1 |
	
	customer2 := (dataBaseSession 
     		select: [ :aCustomer | aCustomer identificationType = 'C' and: [ aCustomer identificationNumber = '23-25666777-9' ]]
     		ofType: Customer) anyOne.
	
	self assertEqualityOfCustomer: customer2 forName: 'Juan' forLastName: 'Perez'.
	
	customer2address1 := (customer2 addresses select: [ :anAddress | anAddress streetName = 'Alem' ]) anyOne.
	self assertEqualityOfAddress: customer2address1 forStreetNumber: 1122 forTown: 'CABA' forZipCode: 1001 forProvince: 'CABA'! !

!ImportTest methodsFor: 'test' stamp: 'MS 6/19/2024 13:27:15'!
assertEqualityOfAddress: aCustomerAddress forStreetNumber: aStreetNumber forTown: aTown forZipCode: aZipCode forProvince: aProvince

	self assert: aCustomerAddress streetNumber equals: aStreetNumber.
	self assert: aCustomerAddress town equals: aTown.
	self assert: aCustomerAddress zipCode equals: aZipCode.
	self assert: aCustomerAddress province equals: aProvince! !

!ImportTest methodsFor: 'test' stamp: 'MS 6/19/2024 13:37:24'!
assertEqualityOfCustomer: aCustomer forName: aFirstName forLastName: aLastName
	
	self assert: aCustomer firstName equals: aFirstName.
	self assert: aCustomer lastName equals: aLastName.
	! !

!ImportTest methodsFor: 'test' stamp: 'MS 6/24/2024 12:17:46'!
setUp
	
	dataBaseSession := (CustomerImporter new) sessionForImportedClients: (UniFileStream new open: 'input.txt' forWrite: false).
	dataBaseSession beginTransaction.! !

!ImportTest methodsFor: 'test' stamp: 'MS 6/19/2024 12:48:46'!
tearDown

	dataBaseSession commit.
	dataBaseSession close.! !

!ImportTest methodsFor: 'test' stamp: 'MS 6/19/2024 13:36:44'!
test01ClientsAreImportedCorrectly

	| customerSet |
	customerSet := 	dataBaseSession selectAllOfType: Customer.
	self assert: customerSet size = 2.

	self assertDataForClient1IsCorrect.
	self assertDataForClient2IsCorrect.! !

!ImportTest methodsFor: 'test' stamp: 'MS 6/24/2024 12:37:23'!
test02LinesWithInvalidFormatRaiseError

	self 
		should: [dataBaseSession := (CustomerImporter new) sessionForImportedClients: (UniFileStream new open: 'input-invalidFormat.txt' forWrite: false)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CustomerImporter invalidLineFormatErrorMessage]! !

!ImportTest methodsFor: 'test' stamp: 'MS 6/24/2024 12:43:52'!
test03WrongLineOrderRaisesError

	self 
		should: [dataBaseSession := (CustomerImporter new) sessionForImportedClients: (UniFileStream new open: 'input-wrongLineOrder.txt' forWrite: false)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CustomerImporter wrongLineOrderErrorMessage]! !


!classDefinition: #Address category: #CustomerImporter!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: #CustomerImporter!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:42'!
initialize

	super initialize.
	addresses := Set new.! !


!classDefinition: #CustomerImporter category: #CustomerImporter!
Object subclass: #CustomerImporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'evaluating' stamp: 'MS 6/24/2024 12:43:09'!
assertLineHasCorrectFormat: aLine

	^ (aLine beginsWith: 'C') | (aLine beginsWith: 'A')  
			ifFalse: [self error: self class invalidLineFormatErrorMessage]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MS 6/24/2024 11:59:48'!
processLine: aLine forAddressesFrom: aNewCustomer

	| addressData newAddress |
	
	addressData := aLine findTokens: $,.
	newAddress := Address new.
	aNewCustomer addAddress: newAddress.
	newAddress streetName: addressData second.
	newAddress streetNumber: addressData third asNumber .
	newAddress town: addressData fourth.
	newAddress zipCode: addressData fifth asNumber .
	newAddress province: addressData sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MS 6/24/2024 12:13:23'!
processLine: aLine inDataBaseSession: aDataBaseSession forDataFrom: aNewCustomer

	| customerData |
	customerData := aLine findTokens: $,.

	aNewCustomer firstName: customerData second.
	aNewCustomer lastName: customerData third.
	aNewCustomer identificationType: customerData fourth.
	aNewCustomer identificationNumber: customerData fifth.
	aDataBaseSession persist: aNewCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MS 6/24/2024 12:43:42'!
processLinesInSession: dataBaseSession onInputStream: anInputStream

	| line newCustomer |

	line := anInputStream nextLine.
	
	(line beginsWith: 'C')
		ifFalse: [self error: self class wrongLineOrderErrorMessage].
	
	[ line notNil ] whileTrue: [
		
		self assertLineHasCorrectFormat: line.
		
		(line beginsWith: 'C') ifTrue: [ 
			newCustomer := Customer new. 
			self processLine: line inDataBaseSession: dataBaseSession forDataFrom: newCustomer ].
		
		(line beginsWith: 'A') 
			ifTrue: [ self processLine: line forAddressesFrom: newCustomer ].
				
		line := anInputStream nextLine. ].
	! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MS 6/24/2024 12:18:04'!
sessionForImportedClients: anInputStream

	| dataBaseSession |
	
	dataBaseSession := DataBaseSession for: (Array with: Address with: Customer).
	dataBaseSession beginTransaction.

	self processLinesInSession: dataBaseSession onInputStream: anInputStream.
	
	dataBaseSession commit.
	anInputStream close. 
	
	^ dataBaseSession
		
! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: #CustomerImporter!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'Error messages' stamp: 'MS 6/24/2024 12:38:13'!
invalidLineFormatErrorMessage
	
	^ 'El formato de alguna linea es incorrecto'! !

!CustomerImporter class methodsFor: 'Error messages' stamp: 'MS 6/24/2024 12:44:12'!
wrongLineOrderErrorMessage
	
	^ 'El orden de las lineas es incorrecto'! !


!classDefinition: #DataBaseSession category: #CustomerImporter!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: #CustomerImporter!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
