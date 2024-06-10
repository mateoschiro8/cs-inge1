!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosInterfaceTest category: #TusLibros!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'MS 6/6/2024 21:44:48'!
test01NewCartBeginsEmpty

	| tusLibrosInterface cartID |
	
	tusLibrosInterface := TusLibrosInterface withClientsAuthenticator: self authSimulatorAcceptingAllClients 
										andCatalog: StoreTestObjectsFactory new defaultCatalog.

	cartID := tusLibrosInterface createCartFor: self clientID authenticatingWithPassword: self clientPassword.
	
	self assert: (tusLibrosInterface listItemsForCart: cartID) isEmpty.
	 ! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'MS 6/10/2024 11:10:57'!
test02CanNotCreateCartForInvalidClient

	| tusLibrosInterface |
	
	tusLibrosInterface := TusLibrosInterface withClientsAuthenticator: self authSimulatorRejectingAllClients 
										andCatalog: StoreTestObjectsFactory new defaultCatalog.
										
	 self 
		should: [tusLibrosInterface createCartFor: self clientID authenticatingWithPassword: self clientPassword. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosInterface wrongClientAuthenticationDataErrorMessage. ]! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'MS 6/10/2024 11:15:20'!
test03AddingItemsToCartListsCorrectly

	| tusLibrosInterface cartID objectFactory anItem |
	
	objectFactory := StoreTestObjectsFactory new.
	
	tusLibrosInterface := TusLibrosInterface withClientsAuthenticator: self authSimulatorAcceptingAllClients 
										andCatalog: objectFactory defaultCatalog.
										
	cartID := tusLibrosInterface createCartFor: self clientID authenticatingWithPassword: self clientPassword.
	
	anItem := objectFactory itemSellByTheStore.
	
	tusLibrosInterface add: 3 of: anItem toCart: cartID.
	
	self assert: (tusLibrosInterface listItemsForCart: cartID) equals: (OrderedCollection with: anItem with: anItem with: anItem).! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'MS 6/10/2024 11:24:55'!
test04CanNotAddItemsToInvalidCartID

	| tusLibrosInterface objectFactory anItem |
	
	objectFactory := StoreTestObjectsFactory new.
	
	tusLibrosInterface := TusLibrosInterface withClientsAuthenticator: self authSimulatorAcceptingAllClients 
										andCatalog: objectFactory defaultCatalog.
	
	anItem := objectFactory itemSellByTheStore.
	
	self 
		should: [	tusLibrosInterface add: 3 of: anItem toCart: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosInterface  invalidCartIDErrorMessage. ]! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'MS 6/10/2024 11:28:30'!
test05CanNotListItemsToInvalidCartID

	| tusLibrosInterface objectFactory |
	
	objectFactory := StoreTestObjectsFactory new.
	
	tusLibrosInterface := TusLibrosInterface withClientsAuthenticator: self authSimulatorAcceptingAllClients 
										andCatalog: objectFactory defaultCatalog.
	
	self 
		should: [tusLibrosInterface listItemsForCart: 5]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosInterface  invalidCartIDErrorMessage. ]! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'MS 6/10/2024 11:47:05'!
test06CanNotCheckOutInvalidCartID

	| tusLibrosInterface objectFactory creditCard |
	
	objectFactory := StoreTestObjectsFactory new.
	
	tusLibrosInterface := TusLibrosInterface withClientsAuthenticator: self authSimulatorAcceptingAllClients 
										andCatalog: objectFactory defaultCatalog.
	
	creditCard := objectFactory notExpiredCreditCard. 
	
	self 
		should: [tusLibrosInterface checkOutCart: 5 withCreditCard: creditCard]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosInterface  invalidCartIDErrorMessage. ]! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'MS 6/10/2024 12:40:00'!
test07CheckingOutAddsSaleToClientPurchases

	| tusLibrosInterface objectFactory creditCard anItem cartID sale |
	
	objectFactory := StoreTestObjectsFactory new.
	
	tusLibrosInterface := TusLibrosInterface withClientsAuthenticator: self authSimulatorAcceptingAllClients 
										andCatalog: objectFactory defaultCatalog.
	
	creditCard := objectFactory notExpiredCreditCard. 
	cartID := tusLibrosInterface createCartFor: self clientID authenticatingWithPassword: self clientPassword.
	anItem := objectFactory itemSellByTheStore.
	
	tusLibrosInterface add: 3 of: anItem toCart: cartID.
	
	sale := tusLibrosInterface checkOutCart: cartID withCreditCard: creditCard.
	
	self assert: (tusLibrosInterface listIPurchasesForClient: self clientID) equals: (OrderedCollection with: sale).! !

!TusLibrosInterfaceTest methodsFor: 'testing' stamp: 'MS 6/10/2024 13:05:51'!
test08CheckingOutDifferentSalesAddsThemToClientPurchases

	| tusLibrosInterface objectFactory creditCard anItem cartID sale1 sale2 |
	
	objectFactory := StoreTestObjectsFactory new.
	
	tusLibrosInterface := TusLibrosInterface withClientsAuthenticator: self authSimulatorAcceptingAllClients 
										andCatalog: objectFactory defaultCatalog.
	
	creditCard := objectFactory notExpiredCreditCard. 
	cartID := tusLibrosInterface createCartFor: self clientID authenticatingWithPassword: self clientPassword.
	anItem := objectFactory itemSellByTheStore.
	
	tusLibrosInterface add: 3 of: anItem toCart: cartID.
	sale1 := tusLibrosInterface checkOutCart: cartID withCreditCard: creditCard.
	
	tusLibrosInterface add: 2 of: anItem toCart: cartID.
	sale2 := tusLibrosInterface checkOutCart: cartID withCreditCard: creditCard.
	
	self assert: (tusLibrosInterface listIPurchasesForClient: self clientID) equals: (OrderedCollection with: sale1 with: sale2).! !


!TusLibrosInterfaceTest methodsFor: 'support' stamp: 'MS 6/6/2024 21:22:54'!
authSimulatorAcceptingAllClients
	
	^ AuthSimulator acceptingAllClients 


	 ! !

!TusLibrosInterfaceTest methodsFor: 'support' stamp: 'MS 6/6/2024 21:13:47'!
authSimulatorRejectingAllClients
	
	^ AuthSimulator rejectingAllClients! !

!TusLibrosInterfaceTest methodsFor: 'support' stamp: 'MS 6/6/2024 21:04:53'!
clientID
	
	^ '04e98vyn50w98'! !

!TusLibrosInterfaceTest methodsFor: 'support' stamp: 'MS 6/6/2024 21:05:20'!
clientPassword
	
	^ 'Una-contraseña-muy-segura'! !


!classDefinition: #AuthSimulator category: #TusLibros!
Object subclass: #AuthSimulator
	instanceVariableNames: 'clientsAreValid'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthSimulator methodsFor: 'initialization' stamp: 'MS 6/6/2024 21:25:57'!
initializeAcceptingAllClients
	
	clientsAreValid := true.! !

!AuthSimulator methodsFor: 'initialization' stamp: 'MS 6/6/2024 21:25:53'!
initializeRejectingAllClients
	
	clientsAreValid := false.! !


!AuthSimulator methodsFor: 'authentication' stamp: 'MS 6/6/2024 21:26:19'!
isValidClient: aClientID withPassword: aClientPassword 
	
	^ clientsAreValid! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AuthSimulator class' category: #TusLibros!
AuthSimulator class
	instanceVariableNames: ''!

!AuthSimulator class methodsFor: 'instance creation' stamp: 'MS 6/6/2024 21:23:14'!
acceptingAllClients

	^self new initializeAcceptingAllClients! !

!AuthSimulator class methodsFor: 'instance creation' stamp: 'MS 6/6/2024 21:15:00'!
rejectingAllClients
	
	^self new initializeRejectingAllClients! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'MS 6/10/2024 11:12:06'!
addItemsToList: itemsList 
	
	items do: [:anItem | itemsList add: anItem].
	! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'MS 6/10/2024 11:57:33'!
createSale
	
	| saleItems |

	saleItems := OrderedCollection new.
	cart addItemsToList: saleItems.

	^ Sale of: total withItemsList: saleItems.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'MS 6/10/2024 12:38:33'!
registerSale

	| sale |

	sale := self createSale.

	salesBook add: sale.
	
	^ sale! !


!Cashier methodsFor: 'checkout' stamp: 'MS 6/10/2024 12:38:50'!
checkOut

	self calculateTotal.
	self debitTotal.

	^ self registerSale! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number cvv name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'initialization' stamp: 'MS 6/10/2024 11:43:49'!
initializeExpiringOn: aMonth withNumber: aCardNumber andCVV: aCVV andName: aName
	
	expiration := aMonth.
	number := aCardNumber.
	cvv := aCVV.
	name := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'MS 6/10/2024 11:42:36'!
assertIsValidCVV: aCVV

	aCVV size = 3
		ifFalse: [self error: self wrongSizeCVVErrorMessage]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'MS 6/10/2024 11:42:14'!
assertIsValidNumber: aCardNumber

	aCardNumber size = 16
		ifFalse: [self error: self wrongSizeCardNumberErrorMessage]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'MS 6/10/2024 11:41:36'!
expiringOn: aMonth withNumber: aCardNumber andCVV: aCVV andName: aName    
	
	self assertIsValidNumber: aCardNumber.
	self assertIsValidCVV: aCVV.
	
	^self new initializeExpiringOn: aMonth withNumber: aCardNumber andCVV: aCVV andName: aName! !

!CreditCard class methodsFor: 'instance creation' stamp: 'MS 6/10/2024 11:43:01'!
wrongSizeCVVErrorMessage

	^ 'El CVV de la tarjeta es de tamaño incorrecto'! !

!CreditCard class methodsFor: 'instance creation' stamp: 'MS 6/10/2024 11:43:19'!
wrongSizeCardNumberErrorMessage

	^ 'El numero de la tarjeta es de tamaño incorrecto'! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total itemsList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'MS 6/10/2024 11:56:39'!
initializeTotal: aTotal withItemsList: aListOfItems 

	total := aTotal.
	itemsList := aListOfItems. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'MS 6/10/2024 11:55:31'!
of: aTotal withItemsList: aListOfItems 

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal withItemsList: aListOfItems  ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MS 6/10/2024 11:44:54'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) withNumber: '1234123412341234' andCVV: '123' andName: 'Obama'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MS 6/10/2024 11:44:58'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) withNumber: '1234123412341234' andCVV: '123' andName: 'Obama'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TusLibrosInterface category: #TusLibros!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'clientsAuthenticator carts objectFactory firstFreeCartID debitBehavior merchantProcessor clientForCart purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'cart interface' stamp: 'MS 6/10/2024 11:29:30'!
add: aQuantity of: anItem toCart: aCartID 

	(carts at: aCartID ifAbsent: [self error: self class invalidCartIDErrorMessage]) 
		add: aQuantity of: anItem! !

!TusLibrosInterface methodsFor: 'cart interface' stamp: 'MS 6/10/2024 12:31:39'!
createCartFor: aClientID authenticatingWithPassword: aClientPassword 
	
	| newCart newCartID |
	
	(clientsAuthenticator isValidClient: aClientID withPassword: aClientPassword)
		ifFalse: [self error: self class wrongClientAuthenticationDataErrorMessage].
	
	newCart := objectFactory createCart. 
	carts at: firstFreeCartID put: newCart. 
	newCartID := firstFreeCartID.
	firstFreeCartID := firstFreeCartID + 1.
	
	clientForCart at: newCartID put: aClientID.
	
	purchases at: aClientID put: OrderedCollection new. 
	
	^ newCartID
	! !

!TusLibrosInterface methodsFor: 'cart interface' stamp: 'MS 6/10/2024 11:29:22'!
listItemsForCart: aCartID 
	
	| itemsList cart |
	
	itemsList := OrderedCollection new.
	
	cart := carts at: aCartID ifAbsent: [self error: self class invalidCartIDErrorMessage]. 
	
	cart addItemsToList: itemsList.
	
	^ itemsList. ! !


!TusLibrosInterface methodsFor: 'initialization' stamp: 'MS 6/10/2024 12:29:59'!
initializeWithClientsAuthenticator: aClientsAuthenticator andCatalog: aCatalog  
	
	clientsAuthenticator := aClientsAuthenticator.
	carts := Dictionary new.
	clientForCart := Dictionary new. 
	purchases := Dictionary new.
	objectFactory := StoreTestObjectsFactory new.
	firstFreeCartID := 1.
	debitBehavior := [ :anAmount :aCreditCard | ].
	merchantProcessor := self.! !


!TusLibrosInterface methodsFor: 'check out' stamp: 'MS 6/10/2024 12:39:22'!
checkOutCart: aCartID withCreditCard: aCreditCard

	| cart cashier aClientID aClientPurchasesList |

	cart :=	carts at: aCartID ifAbsent: [self error: self class invalidCartIDErrorMessage].
	
	aClientID := clientForCart at: aCartID. 
	aClientPurchasesList := purchases at: aClientID. 
	
	cashier := Cashier toCheckout: cart charging: aCreditCard throught: merchantProcessor on: (objectFactory today) registeringOn: aClientPurchasesList.
	
	^ cashier checkOut. ! !


!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 6/10/2024 12:12:50'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 6/10/2024 12:32:08'!
listIPurchasesForClient: aClientID
	
	^ purchases at: aClientID! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: #TusLibros!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'MS 6/6/2024 21:43:47'!
withClientsAuthenticator: aClientsAuthenticator andCatalog: aCatalog  

	^self new initializeWithClientsAuthenticator: aClientsAuthenticator andCatalog: aCatalog! !


!TusLibrosInterface class methodsFor: 'error messages' stamp: 'MS 6/10/2024 11:25:27'!
invalidCartIDErrorMessage
	
	^ 'El ID de carrito es invalido'! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'MS 6/6/2024 21:27:17'!
wrongClientAuthenticationDataErrorMessage
	
	^ 'Datos de autenticacion incorrectos'! !
