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

!CashierTest methodsFor: 'testing' stamp: 'MS 6/6/2024 11:41:43'!
test02CartWithOneItemChecksOutCorrectly

	| cashier cart creditCard |
	
	cart := (Cart acceptingItemsOf: self defaultItemList) add: 'Crimen y Castigo'.
	creditCard := self validCreditCard.
	cashier := Cashier forCart: cart withCreditCard: creditCard usingPrices: self defaultPriceList andMerchant: MerchantSimulator acceptingAllCards.
	
	self assert: cashier checkout equals: 200.! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/6/2024 11:41:18'!
test03CartWithManyItemsChecksOutCorrectly

	| cashier cart creditCard |
	
	cart := self cartWith2ItemsAndDefaultPrices .
	creditCard := self validCreditCard.
	cashier := Cashier forCart: cart withCreditCard: creditCard usingPrices: self defaultPriceList andMerchant: MerchantSimulator acceptingAllCards.
	
	self assert: cashier checkout equals: 350.! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/6/2024 11:41:03'!
test04CanNotCheckoutWithCardThatDoesNotHave16Digits

	| cart |
	
	cart := self cartWith2ItemsAndDefaultPrices.
	
	self 
		should: [ Cashier forCart: cart 
						withCreditCard: self invalidCreditCardWrongNumberSize
						usingPrices: self defaultPriceList 
						andMerchant: MerchantSimulator acceptingAllCards.]		
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard wrongCreditCardNumberErrorMessage.]
	

	
	! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/6/2024 11:40:57'!
test05CanNotCheckoutWithCardThatDoesNotHave3DigitsInCVV

	| cart |
	
	cart := self cartWith2ItemsAndDefaultPrices.
	
	self 
		should: [ Cashier forCart: cart 
						withCreditCard: self invalidCreditCardWrongCVVSize
						usingPrices: self defaultPriceList 
						andMerchant: MerchantSimulator acceptingAllCards.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard wrongCreditCardCVVErrorMessage.]
	

	
	! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/6/2024 11:45:40'!
test06CanNotCheckoutWithExpiredCard

	| cart creditCard |
	
	cart := self cartWith2ItemsAndDefaultPrices.
	creditCard := self expiredCreditCard.
	
	self 
		should: [ Cashier forCart: cart withCreditCard: creditCard usingPrices: self defaultPriceList andMerchant: MerchantSimulator acceptingAllCards.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCardErrorMessage.]
	

	
	! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/6/2024 11:40:43'!
test07CanNotCheckoutWithCardWithoutEnoughFounds

	| cart creditCard cashier |
	
	cart := self cartWith2ItemsAndDefaultPrices.
	creditCard := self validCreditCard.
	cashier := Cashier forCart: cart withCreditCard: creditCard usingPrices: self defaultPriceList andMerchant: MerchantSimulator rejectingAllCards.
	
	self 
		should: [ cashier checkout ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier notEnoughFoundsInCardErrorMessage.]
	

	
	! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/6/2024 11:57:51'!
test08CanNotCheckoutWithCardWithWrongNameSize

	| cart |
	
	cart := self cartWith2ItemsAndDefaultPrices.
	
	self 
		should: [ Cashier forCart: cart 
						withCreditCard: self invalidCreditCardWrongNameSize
						usingPrices: self defaultPriceList 
						andMerchant: MerchantSimulator acceptingAllCards.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard wrongOwnerSizeErrorMessage .]
	

	
	! !

!CashierTest methodsFor: 'testing' stamp: 'MS 6/6/2024 12:10:16'!
test09CanNotCheckoutTransactionWithMoreThan15Digits

	| cart cashier |
	
	cart := (Cart acceptingItemsOf: self expensiveItemList) add: 'Un libro muy caro'; add: 'La gota que rebalsó el cajero'.
	cashier := Cashier forCart: cart 
					withCreditCard: self validCreditCard 
					usingPrices: self expensivePriceList 
					andMerchant: MerchantSimulator acceptingAllCards.
	self 
		should: [ cashier checkout ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier transactionAmountLimitExceededErrorMessage .]
	

	
	! !


!CashierTest methodsFor: 'support' stamp: 'MS 6/6/2024 11:40:32'!
cartWith2ItemsAndDefaultPrices.

	^ (Cart acceptingItemsOf: self defaultItemList) add: 'Crimen y Castigo'; add: 'El Codigo Da Vinci'.
	
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

!CashierTest methodsFor: 'support' stamp: 'MS 6/6/2024 12:01:59'!
expensiveItemList

	^ self expensivePriceList keys! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/6/2024 12:01:45'!
expensivePriceList

	^ (Dictionary new) 
		at: 'Un libro muy caro' put: 999999999999999; 
		at: 'La gota que rebalsó el cajero' put: 10;
		yourself.! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/6/2024 11:55:59'!
expiredCreditCard
	
	^ CreditCard withOwner: 'Martin Palermo' andNumber: '5258234112539034' andCVV: '472' andExpirationDate: self previousMonthDate.

	
! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/6/2024 11:55:59'!
invalidCreditCardWrongCVVSize
					
	^ CreditCard withOwner: 'Martin Palermo' andNumber: '5258234112539034' andCVV: '472432' andExpirationDate: self nextMonthDate .
! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/6/2024 11:57:35'!
invalidCreditCardWrongNameSize
					
	^ CreditCard withOwner: 'Martin Martin Martin Martin Martin Martin Martin Marteeeeeen'  andNumber: '5258234112539034' andCVV: '472' andExpirationDate: self nextMonthDate .
! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/6/2024 11:55:59'!
invalidCreditCardWrongNumberSize

	^ CreditCard withOwner: 'Martin Palermo' andNumber: '525823423423423112539034' andCVV: '472' andExpirationDate: self nextMonthDate.! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/6/2024 11:27:34'!
nextMonthDate

	| today nextMonth year |
	
	today := Date today.
	nextMonth := today monthIndex + 1.
	year := today year yearNumber.
	
	nextMonth = 13
		ifTrue: [nextMonth  := 1. year := year + 1. ].
	
	^ Date newDay: 1 month: (Date nameOfMonth: nextMonth) year: year! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/6/2024 11:28:14'!
previousMonthDate

	| today previousMonth year |
	
	today := Date today.
	previousMonth := today monthIndex - 1.
	year := today year yearNumber.
	
	previousMonth = 0
		ifTrue: [previousMonth  := 12. year := year - 1. ].
	
	^ Date newDay: 1 month: (Date nameOfMonth: previousMonth) year: year.! !

!CashierTest methodsFor: 'support' stamp: 'MS 6/6/2024 11:55:59'!
validCreditCard

	^ CreditCard withOwner: 'Martin Palermo' andNumber: '5258234112539034' andCVV: '472' andExpirationDate: self nextMonthDate.
	
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

!Cashier methodsFor: 'items' stamp: 'MS 6/6/2024 12:08:53'!
assertTransactionAmountLimitIsNotExceeded
	
	totalAmount < 1000000000000000
		ifFalse: [self error: self class transactionAmountLimitExceededErrorMessage.]! !

!Cashier methodsFor: 'items' stamp: 'MS 6/6/2024 12:23:25'!
checkout
	
	cart itemsDo: [:anItem | self addToTotalAmount: anItem ].
	
	self assertTransactionAmountLimitIsNotExceeded.
	
	" self truncateTotalAmountToKeepTwoDecimals. "
	
	(merchant processCard: creditCard for: totalAmount)
		ifFalse: [self error: self class notEnoughFoundsInCardErrorMessage].
	
	^ totalAmount ! !

!Cashier methodsFor: 'items' stamp: 'MS 6/6/2024 12:17:44'!
truncateTotalAmountToKeepTwoDecimals.
	
	totalAmount := totalAmount * 10.
	totalAmount := totalAmount asFloat.
	totalAmount truncated.
	totalAmount := totalAmount / 10.! !


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

!Cashier class methodsFor: 'instance creation' stamp: 'fb 6/3/2024 21:25:52'!
assertCartIsNotEmpty: aCart

	aCart isEmpty
		ifTrue: [self error: self emptyCartErrorMessage]. ! !

!Cashier class methodsFor: 'instance creation' stamp: 'MS 6/6/2024 11:20:53'!
assertIsNotExpired: aCreditCard

	aCreditCard isExpired
		ifTrue: [self error: self expiredCardErrorMessage]! !

!Cashier class methodsFor: 'instance creation' stamp: 'MS 6/6/2024 11:24:17'!
forCart: aCart withCreditCard: aCreditCard usingPrices: aPriceList andMerchant: aMerchant

	self assertCartIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard.
	
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

!Cashier class methodsFor: 'error descriptions' stamp: 'MS 6/6/2024 12:05:43'!
transactionAmountLimitExceededErrorMessage

	^ 'El monto de la transaccion es demasiado grande' ! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number cvv expirationDate creditCardNumber cVV owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'MS 6/6/2024 11:55:44'!
initializeWithOwner: anOwner andNumber: aCreditCardNumber andCVV: aCVV andExpirationDate: anExpirationDate 
	
	owner := anOwner.
	creditCardNumber := aCreditCardNumber.
	cVV := aCVV.
	expirationDate := anExpirationDate.! !


!CreditCard methodsFor: 'status' stamp: 'MS 6/6/2024 11:19:18'!
isExpired
	
	^ (expirationDate < Date today) | (expirationDate = Date today)
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'MS 6/6/2024 11:55:59'!
withOwner: anOwner andNumber: aCreditCardNumber andCVV: aCVV andExpirationDate: anExpirationDate 
	
	self assertNameHasCorrectSize: anOwner.
	self assertNumberHasCorrectSize: aCreditCardNumber.
	self assertCVVHasCorrectSize: aCVV. 
	
	^self new initializeWithOwner: anOwner andNumber: aCreditCardNumber andCVV: aCVV andExpirationDate: anExpirationDate ! !


!CreditCard class methodsFor: 'assertions' stamp: 'MS 6/6/2024 11:22:47'!
assertCVVHasCorrectSize: aCreditCardCVV.
	
	^ aCreditCardCVV size = 3
		ifFalse: [self error: self wrongCreditCardCVVErrorMessage.]
	 
		
		! !

!CreditCard class methodsFor: 'assertions' stamp: 'MS 6/6/2024 11:53:45'!
assertNameHasCorrectSize: anOwner.
	
	anOwner size <= 30
		ifFalse: [self error: self wrongOwnerSizeErrorMessage.]! !

!CreditCard class methodsFor: 'assertions' stamp: 'MS 6/6/2024 11:22:37'!
assertNumberHasCorrectSize: aCreditCardNumber

	^ aCreditCardNumber size = 16
		ifFalse: [self error: self wrongCreditCardNumberErrorMessage.]! !


!CreditCard class methodsFor: 'error messages' stamp: 'MS 6/6/2024 12:06:02'!
wrongCreditCardCVVErrorMessage
	
	^ 'El codigo de la tarjeta de credito es incorrecto'! !

!CreditCard class methodsFor: 'error messages' stamp: 'MS 6/6/2024 12:05:56'!
wrongCreditCardNumberErrorMessage
	
	^ 'El numero de la tarjeta de credito es incorrecto'! !

!CreditCard class methodsFor: 'error messages' stamp: 'MS 6/6/2024 11:54:35'!
wrongOwnerSizeErrorMessage

	^ 'El nombre del dueño es demasiado largo'! !


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
