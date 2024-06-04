!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'MS 6/4/2024 12:41:09'!
test01CanNotCheckOutEmptyCart

	| cart creditCard |
	
	cart := Cart acceptingItemsOf: self defaultItemList .
	creditCard := self validCreditCard.
	
	self 
		should: [ Cashier forCart: cart withCreditCard: creditCard usingPrices: self defaultPriceList andMerchant: MerchantSimulator acceptingAllCards]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartErrorMessage.]! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/4/2024 12:40:59'!
test02CartWithOneItemChecksOutCorrectly

	| cashier cart creditCard |
	
	cart := Cart acceptingItemsOf: self defaultItemList.
	creditCard := self validCreditCard.
	
	cart add: 'Crimen y Castigo'.
	
	cashier := Cashier forCart: cart withCreditCard: creditCard usingPrices: self defaultPriceList andMerchant: MerchantSimulator acceptingAllCards.
	
	self assert: cashier checkout equals: 200.! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/4/2024 12:41:24'!
test03CartWithManyItemsChecksOutCorrectly

	| cashier cart creditCard |
	
	cart := Cart acceptingItemsOf: self defaultItemList.
	creditCard := self validCreditCard.
	
	cart add: 'Crimen y Castigo'; add: 'El Codigo Da Vinci'.
	
	cashier := Cashier forCart: cart withCreditCard: creditCard usingPrices: self defaultPriceList andMerchant: MerchantSimulator acceptingAllCards.
	
	self assert: cashier checkout equals: 350.! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/4/2024 12:41:31'!
test04CanNotCheckoutWithCardThatDoesNotHave16Digits

	| cart creditCard |
	
	cart := Cart acceptingItemsOf: self defaultItemList.
	creditCard := self invalidCreditCardWrongNumberSize.
	
	cart add: 'Crimen y Castigo'; add: 'El Codigo Da Vinci'.
	
	self 
		should: [ Cashier forCart: cart withCreditCard: creditCard usingPrices: self defaultPriceList andMerchant: MerchantSimulator acceptingAllCards.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier wrongCreditCardNumberErrorMessage.]
	

	
	! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/4/2024 12:41:37'!
test05CanNotCheckoutWithCardThatDoesNotHave3DigitsInCVV

	| cart creditCard |
	
	cart := Cart acceptingItemsOf: self defaultItemList.
	creditCard := self invalidCreditCardWrongCVVSize.
	
	cart add: 'Crimen y Castigo'; add: 'El Codigo Da Vinci'.
	
	self 
		should: [ Cashier forCart: cart withCreditCard: creditCard usingPrices: self defaultPriceList andMerchant: MerchantSimulator acceptingAllCards.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier wrongCreditCardCVVErrorMessage.]
	

	
	! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/4/2024 12:41:40'!
test06CanNotCheckoutWithExpiredCard

	| cart creditCard |
	
	cart := Cart acceptingItemsOf: self defaultItemList.
	creditCard := self expiredCreditCard.
	
	cart add: 'Crimen y Castigo'; add: 'El Codigo Da Vinci'.
	
	self 
		should: [ Cashier forCart: cart withCreditCard: creditCard usingPrices: self defaultPriceList andMerchant: MerchantSimulator acceptingAllCards.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCardErrorMessage.]
	

	
	! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/4/2024 12:48:22'!
test07CanNotCheckoutWithCardWithoutEnoughFounds

	| cart creditCard cashier |
	
	cart := Cart acceptingItemsOf: self defaultItemList.
	creditCard := self validCreditCard.
	
	cart add: 'Crimen y Castigo'; add: 'El Codigo Da Vinci'.
	
	cashier := Cashier forCart: cart withCreditCard: creditCard usingPrices: self defaultPriceList andMerchant: MerchantSimulator rejectingAllCards.
	
	self 
		should: [ cashier checkout ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier notEnoughFoundsInCardErrorMessage.]
	

	
	! !


!CashierTest methodsFor: 'support' stamp: 'MS 6/4/2024 11:21:04'!
defaultItemList

	^ self defaultPriceList keys! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/4/2024 11:21:27'!
defaultPriceList

	^ (Dictionary new) 
		at: 'Crimen y Castigo' put: 200; 
		at: 'El Codigo Da Vinci' put: 150; 
		yourself.! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/4/2024 12:22:48'!
expiredCreditCard

	| today previousMonth year expirationDate |
	
	today := Date today.
	previousMonth := today monthIndex - 1.
	year := today year yearNumber.
	
	previousMonth = 0
		ifTrue: [previousMonth  := 12. year := year - 1. ].
	
	expirationDate := Date newDay: 1 month: (Date nameOfMonth: previousMonth) year: year.
	
	^ (Dictionary new) at: 'number' put: '5258234112539034'; 
					 at: 'cvv' put: '472';
					 at: 'expirationDate' put: expirationDate;
					 yourself.
	
! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/4/2024 11:49:05'!
invalidCreditCardWrongCVVSize

	^ (Dictionary new) at: 'number' put: '5258234112539034'; 
					 at: 'cvv' put: '472432';
					 at: 'expirationDate' put: '05/32';
					 yourself.
	
! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/4/2024 11:49:00'!
invalidCreditCardWrongNumberSize

	^ (Dictionary new) at: 'number' put: '234112539034'; 
					 at: 'cvv' put: '472';
					 at: 'expirationDate' put: '05/32';
					 yourself.
	
! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/4/2024 12:21:51'!
validCreditCard

	| today nextMonth year expirationDate |
	
	today := Date today.
	nextMonth := today monthIndex + 1.
	year := today year yearNumber.
	
	nextMonth = 13
		ifTrue: [nextMonth  := 1. year := year + 1. ].
	
	expirationDate := Date newDay: 1 month: (Date nameOfMonth: nextMonth) year: year.
	
	^ (Dictionary new) at: 'number' put: '5258234112539034'; 
					 at: 'cvv' put: '472';
					 at: 'expirationDate' put: expirationDate;
					 yourself.

	
! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !


!Cart methodsFor: 'as yet unclassified' stamp: 'MS 6/4/2024 11:15:08'!
itemsDo: aBlock

	items do: aBlock 

"[:anItem | self addToTotalAmount: anItem ]"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard priceList totalAmount merchant'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'items' stamp: 'MS 6/4/2024 12:46:10'!
checkout
	
	cart itemsDo: [:anItem | self addToTotalAmount: anItem ].
	
	(merchant processCard: creditCard for: totalAmount)
		ifFalse: [self error: self class notEnoughFoundsInCardErrorMessage].
	
	^ totalAmount ! !


!Cashier methodsFor: 'initialization' stamp: 'fb 6/3/2024 22:00:52'!
addToTotalAmount: anItem

	totalAmount := totalAmount + priceList at: anItem.! !

!Cashier methodsFor: 'initialization' stamp: 'MS 6/4/2024 12:36:56'!
initializeForCart: aCart withCreditCard: aCreditCard usingPrices: aPriceList and: aMerchant
	
	totalAmount := 0.
	cart := aCart.
	creditCard := aCreditCard.
	priceList := aPriceList.
	merchant := aMerchant.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'MS 6/4/2024 11:54:41'!
assertCVVHasCorrectSize: aCreditCard.
	
	^ (aCreditCard at: 'cvv') size = 3
		ifFalse: [self error: self wrongCreditCardCVVErrorMessage.]
	 
		
		! !

!Cashier class methodsFor: 'instance creation' stamp: 'fb 6/3/2024 21:25:52'!
assertCartIsNotEmpty: aCart

	aCart isEmpty
		ifTrue: [self error: self emptyCartErrorMessage]. ! !

!Cashier class methodsFor: 'instance creation' stamp: 'MS 6/4/2024 12:29:45'!
assertIsNotExpired: aCreditCard

	| creditCardExpirationDate |
	
	creditCardExpirationDate := aCreditCard at: 'expirationDate'.
	
	(creditCardExpirationDate < Date today) | (creditCardExpirationDate = Date today)
		ifTrue: [self error: self expiredCardErrorMessage]! !

!Cashier class methodsFor: 'instance creation' stamp: 'MS 6/4/2024 12:24:07'!
assertIsValidCard: aCreditCard.

	self assertNumberHasCorrectSize: aCreditCard.
	self assertCVVHasCorrectSize: aCreditCard.
	
	self assertIsNotExpired: aCreditCard.
	 
		
		! !

!Cashier class methodsFor: 'instance creation' stamp: 'MS 6/4/2024 11:53:53'!
assertNumberHasCorrectSize: aCreditCard

	^ (aCreditCard at: 'number') size = 16
		ifFalse: [self error: self wrongCreditCardNumberErrorMessage.]! !

!Cashier class methodsFor: 'instance creation' stamp: 'MS 6/4/2024 12:36:34'!
forCart: aCart withCreditCard: aCreditCard usingPrices: aPriceList andMerchant: aMerchant

	self assertCartIsNotEmpty: aCart.
	self assertIsValidCard: aCreditCard.

	^self new initializeForCart: aCart withCreditCard: aCreditCard usingPrices: aPriceList and: aMerchant! !


!Cashier class methodsFor: 'error descriptions' stamp: 'fb 6/3/2024 21:21:51'!
emptyCartErrorMessage
	
	^ 'No se puede hacer checkout a un carrito vacio.'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'MS 6/4/2024 12:23:28'!
expiredCardErrorMessage

	^ 'La tarjeta esta vencida'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'MS 6/4/2024 12:45:54'!
notEnoughFoundsInCardErrorMessage

	^ 'La tarjeta no tiene fondos suficientes'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'MS 6/4/2024 11:53:02'!
wrongCreditCardCVVErrorMessage
	
	^ 'El codigo de la tarjeta de crédito es incorrecto'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'MS 6/4/2024 11:45:44'!
wrongCreditCardNumberErrorMessage
	
	^ 'El numero de la tarjeta de crédito es incorrecto'! !


!classDefinition: #MerchantSimulator category: #TusLibros!
Object subclass: #MerchantSimulator
	instanceVariableNames: 'acceptAllCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantSimulator methodsFor: 'processing' stamp: 'MS 6/4/2024 12:47:01'!
processCard: aCard for: anAmount

	^ acceptAllCards ! !


!MerchantSimulator methodsFor: 'initialization' stamp: 'MS 6/4/2024 12:47:14'!
initializeAcceptingAllCards

	acceptAllCards := true.! !

!MerchantSimulator methodsFor: 'initialization' stamp: 'MS 6/4/2024 12:47:09'!
initializeRejectingAllCards

	acceptAllCards := false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantSimulator class' category: #TusLibros!
MerchantSimulator class
	instanceVariableNames: ''!

!MerchantSimulator class methodsFor: 'as yet unclassified' stamp: 'MS 6/4/2024 12:38:32'!
acceptingAllCards

	^ self new initializeAcceptingAllCards! !

!MerchantSimulator class methodsFor: 'as yet unclassified' stamp: 'MS 6/4/2024 12:37:53'!
rejectingAllCards

	^ self new initializeRejectingAllCards! !
