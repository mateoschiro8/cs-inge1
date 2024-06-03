!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'testing' stamp: 'MS 5/31/2024 11:39:34'!
test01NewCartIsEmtpy

	| cart |
	
	cart := BooksCart new.
	
	self assert: cart isEmpty! !

!CartTest methodsFor: 'testing' stamp: 'MS 5/31/2024 11:55:04'!
test02AddingBookMakesCartNotEmpty

	| cart bookISBN |
	
	cart := BooksCart new.
	
	bookISBN := '978-3-16-148410-0' asSymbol.
	
	cart add: 1 of: bookISBN.
	
	self deny: cart isEmpty! !

!CartTest methodsFor: 'testing' stamp: 'MS 5/31/2024 11:55:14'!
test03CartWithOneBookListsCorrectly

	| cart bookISBN |
	
	cart := BooksCart new.
	
	bookISBN := '978-3-16-148410-0' asSymbol.
	
	cart add: 1 of: bookISBN.
	
	self assert: cart booksList equals: '|', bookISBN, '|1'! !

!CartTest methodsFor: 'testing' stamp: 'MS 5/31/2024 11:56:56'!
test04CartWithDifferentBooksAndQuantitiesListsCorrectly

	| cart bookISBN1 bookISBN2 |
	
	cart := BooksCart new.
	
	bookISBN1 := '978-3-16-148410-0' asSymbol.
	cart add: 1 of: bookISBN1.
	
	bookISBN2 := '123-3-73-216342-0' asSymbol.
	cart add: 3 of: bookISBN2.
	
	self assert: cart booksList equals: '|', bookISBN1, '|1', '|', bookISBN2, '|3'! !

!CartTest methodsFor: 'testing' stamp: 'MS 5/31/2024 12:02:49'!
test05CannotAddZeroOrNegativeQuantityOfABook

	| cart bookISBN |
	
	cart := BooksCart new.
	
	bookISBN := '978-3-16-148410-0' asSymbol.
	
	self 
		should: [ cart add: 0 of: bookISBN. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: BooksCart canNotAddZeroOrLessBooksErrorMessage equals: anError messageText.
			self assert: cart isEmpty.]
	! !

!CartTest methodsFor: 'testing' stamp: 'MS 5/31/2024 12:08:32'!
test06CartWithOneBookRemovesCorrectly

	| cart bookISBN |
	
	cart := BooksCart new.
	
	bookISBN := '978-3-16-148410-0' asSymbol.
	cart add: 1 of: bookISBN.

	cart remove: 1 of: bookISBN.
		
	self assert: cart booksList equals: ''.
	self assert: cart isEmpty ! !

!CartTest methodsFor: 'testing' stamp: 'MS 5/31/2024 12:14:13'!
test07RemovingLessThanTotalQuantityOfOneBookRemovesCorrectly

	| cart bookISBN |
	
	cart := BooksCart new.
	
	bookISBN := '978-3-16-148410-0' asSymbol.
	cart add: 3 of: bookISBN.
	
	cart remove: 2 of: bookISBN.
	
	self assert: cart booksList equals: '|', bookISBN, '|1'.! !

!CartTest methodsFor: 'testing' stamp: 'MS 5/31/2024 12:17:38'!
test08CannotRemoveMoreThanTotalQuantityOfOneBook

	| cart bookISBN |
	
	cart := BooksCart new.
	
	bookISBN := '978-3-16-148410-0' asSymbol.
	cart add: 3 of: bookISBN.
	
	self 
		should: [ cart remove: 4 of: bookISBN. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: BooksCart canNotRemoveMoreThanTotalErrorMessage equals: anError messageText.
			self assert: cart booksList equals: '|', bookISBN, '|3'.]! !

!CartTest methodsFor: 'testing' stamp: 'MS 5/31/2024 12:24:34'!
test09CannotRemoveBookThatDoesNotExist

	| cart bookISBN notExistingBookISBN |
	
	cart := BooksCart new.
	
	bookISBN := '978-3-16-148410-0' asSymbol.
	cart add: 3 of: bookISBN.	
	
	notExistingBookISBN := '111-1-11-111111-1' asSymbol.
	
	self 
		should: [ cart remove: 1 of: notExistingBookISBN. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: BooksCart canNotRemoveBookThatDoesNotExistErrorMessage equals: anError messageText.
			self assert: cart booksList equals: '|', bookISBN, '|3'.]! !


!classDefinition: #PublishingHouseTest category: #TusLibros!
TestCase subclass: #PublishingHouseTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PublishingHouseTest methodsFor: 'as yet unclassified' stamp: 'MS 6/3/2024 12:12:31'!
test01BookRepositoryAddsNewAvailableBookCorrectly

	| publisher newBook |
	
	publisher := PublishingHouse withIdentifier: 16. 

	newBook := 	'978-3-16-148410-0' asSymbol.
	publisher addNewAvailableBook: newBook.
	
	self assert: (publisher hasBookAvailable: newBook). ! !

!PublishingHouseTest methodsFor: 'as yet unclassified' stamp: 'MS 6/3/2024 12:12:13'!
test02BookRepositoryDoesNotHaveBookNotAdded

	| publisher newBook bookNotAdded |
	
	publisher := PublishingHouse withIdentifier: 16. 

	newBook := 	'978-3-16-148410-0' asSymbol.
	bookNotAdded := 	'978-9-48-009130-1' asSymbol.
	
	publisher addNewAvailableBook: newBook.
	
	self deny: (publisher hasBookAvailable: bookNotAdded). ! !

!PublishingHouseTest methodsFor: 'as yet unclassified' stamp: 'MS 6/3/2024 12:12:22'!
test03CanNotAddBookWithDifferentIdentifierThanPublisher

	| publisher newBook  |
	
	publisher := PublishingHouse withIdentifier: 16. 

	newBook := 	'978-3-36-148410-0' asSymbol.
	
	self 
		should: [ publisher addNewAvailableBook: newBook.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: PublishingHouse canNotAddBookNotAvailableInPublisherErrorMessage equals: anError messageText. 
			self deny: (publisher hasBookAvailable: newBook).]! !

!PublishingHouseTest methodsFor: 'as yet unclassified' stamp: 'MS 6/3/2024 12:17:51'!
test04CanNotInitializePublisherWithWrongSizeIdentifier

	self 
		should: [ PublishingHouse withIdentifier: 324.]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: PublishingHouse wrongSizeIdentifierErrorDescription equals: anError messageText.]! !

!PublishingHouseTest methodsFor: 'as yet unclassified' stamp: 'MS 6/3/2024 12:26:17'!
test05CanNotAddBookThatDoesNotBelongToPublisherToCart

	| publisher newBook aCart |
	
	publisher := PublishingHouse withIdentifier: 16. 

	aCart := BooksCart new. 

	newBook := 	'978-3-36-148410-0' asSymbol.
	
	self 
		should: [ publisher addBook: newBook toCart: aCart ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: PublishingHouse canNotAddBookNotAvailableInPublisherErrorMessage equals: anError messageText. 
			self assert: aCart isEmpty.]! !


!classDefinition: #BooksCart category: #TusLibros!
Object subclass: #BooksCart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BooksCart methodsFor: 'status' stamp: 'MS 5/31/2024 11:52:07'!
isEmpty
	
	^ books keys isEmpty. ! !


!BooksCart methodsFor: 'books' stamp: 'MS 5/31/2024 12:03:33'!
add: aQuantity of: aBook 
	
	self assertIsPositive: aQuantity.
	
	books at: aBook put: aQuantity! !

!BooksCart methodsFor: 'books' stamp: 'MS 5/31/2024 11:57:42'!
booksList
	
	| list |
	
	list := ''.	

	books keysAndValuesDo: [:aKey :aValue | list := (list, '|', aKey asString, '|', aValue asString)].
	
	^ list! !

!BooksCart methodsFor: 'books' stamp: 'MS 5/31/2024 12:27:52'!
ifNotAbsentGetCurrentQuantityOf: aBook

	^ books at: aBook 
		      ifAbsent: [self error: self class canNotRemoveBookThatDoesNotExistErrorMessage]! !

!BooksCart methodsFor: 'books' stamp: 'MS 5/31/2024 12:27:31'!
remove: aQuantity of: aBook 

	| actualQuantity newQuantity |
	
	actualQuantity := self ifNotAbsentGetCurrentQuantityOf: aBook. 
	newQuantity := actualQuantity - aQuantity. 
	
	self assertIsPositiveOrZero: newQuantity.
	
	(newQuantity = 0)
		ifTrue: [books removeKey: aBook]
		ifFalse: [books at: aBook put: newQuantity] 
	! !


!BooksCart methodsFor: 'initialization' stamp: 'MS 5/31/2024 11:42:30'!
initialize

	books := Dictionary new.! !


!BooksCart methodsFor: 'assertions' stamp: 'MS 5/31/2024 12:10:08'!
assertIsPositive: aQuantity

	(aQuantity > 0)
		ifFalse: [self error: self class canNotAddZeroOrLessBooksErrorMessage].! !

!BooksCart methodsFor: 'assertions' stamp: 'MS 5/31/2024 12:20:03'!
assertIsPositiveOrZero: aQuantity

	(aQuantity >= 0)
		ifFalse: [self error: self class canNotRemoveMoreThanTotalErrorMessage].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BooksCart class' category: #TusLibros!
BooksCart class
	instanceVariableNames: ''!

!BooksCart class methodsFor: 'error descriptions' stamp: 'MS 5/31/2024 12:04:41'!
canNotAddZeroOrLessBooksErrorMessage

	^ 'No se puede agregar una cantidad nula o negativa de libros'.! !

!BooksCart class methodsFor: 'error descriptions' stamp: 'MS 5/31/2024 12:22:00'!
canNotRemoveBookThatDoesNotExistErrorMessage

	^ 'No se puede eliminar un libro que no se encuentra en el carrito'! !

!BooksCart class methodsFor: 'error descriptions' stamp: 'MS 5/31/2024 12:17:58'!
canNotRemoveMoreThanTotalErrorMessage

	^ 'No se puede remover mas de la cantidad total de libros'! !


!classDefinition: #PublishingHouse category: #TusLibros!
Object subclass: #PublishingHouse
	instanceVariableNames: 'bookRepository identifier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PublishingHouse methodsFor: 'initialization' stamp: 'MS 6/3/2024 12:13:28'!
initializeWith: anIdentifier

	identifier := anIdentifier.
	bookRepository := Set new.! !


!PublishingHouse methodsFor: 'repository' stamp: 'MS 6/3/2024 12:01:42'!
addNewAvailableBook: aNewBook 
	
	self assertBooksISBNHasPublishersIdentifier: aNewBook.
	
	bookRepository add: aNewBook! !

!PublishingHouse methodsFor: 'repository' stamp: 'MS 6/3/2024 12:08:34'!
assertBooksISBNHasPublishersIdentifier: aNewBook
	
	| bookIdentifier | 
	
	bookIdentifier := aNewBook asString copyFrom: 7 to: 8.
	
	identifier = bookIdentifier
		ifFalse: [ self error: self class canNotAddBookNotAvailableInPublisherErrorMessage]
	
	"978-3-16-148410-0"
	
! !

!PublishingHouse methodsFor: 'repository' stamp: 'MS 6/3/2024 11:47:12'!
hasBookAvailable: aBook 

	^ bookRepository includes: aBook! !


!PublishingHouse methodsFor: 'business logic' stamp: 'MS 6/3/2024 12:26:04'!
addBook: newBook toCart: aCart 
	
	self assertBooksISBNHasPublishersIdentifier: newBook.
	
	aCart add: 1 of: newBook ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PublishingHouse class' category: #TusLibros!
PublishingHouse class
	instanceVariableNames: ''!

!PublishingHouse class methodsFor: 'as yet unclassified' stamp: 'MS 6/3/2024 12:14:20'!
assertIdentifierHasTwoDigits: anIdentifier.
	
	anIdentifier size = 2
		ifFalse: [self error: self wrongSizeIdentifierErrorDescription]! !

!PublishingHouse class methodsFor: 'as yet unclassified' stamp: 'MS 6/3/2024 12:07:08'!
canNotAddBookNotAvailableInPublisherErrorMessage

	^ 'No se puede agregar a la editorial un libro con un identificador distinto'! !

!PublishingHouse class methodsFor: 'as yet unclassified' stamp: 'MS 6/3/2024 12:14:44'!
withIdentifier: anIdentifier

	| identifier |
	
	identifier := anIdentifier asString.

	self assertIdentifierHasTwoDigits: identifier.
	
	^ self new initializeWith: identifier! !


!PublishingHouse class methodsFor: 'instance creation' stamp: 'MS 6/3/2024 12:19:16'!
wrongSizeIdentifierErrorDescription

	^ 'El identificador proporcionado no contiene dos digitos'! !
