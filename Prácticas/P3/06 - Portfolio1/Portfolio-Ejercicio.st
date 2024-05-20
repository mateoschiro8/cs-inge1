!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MS 5/16/2024 11:29:27'!
test01PortfolioSinCuentasTieneBalanceCero

	| portfolio |
	

	portfolio := Portfolio new. 

	
	self assert: portfolio balance equals: 0! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MS 5/16/2024 12:17:25'!
test02PortfolioConUnaCuentaTieneElBalanceDeLaCuenta

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio new. 
	portfolio add: account.
	
	self assert: portfolio balance equals: account balance! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MS 5/16/2024 12:17:25'!
test03PortfolioConDosCuentasTieneElBalanceSumadoDeLasCuentas

	| portfolio account1 account2 |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount new.
	Withdraw register: 50 on: account2.
	
	portfolio := Portfolio new. 
	portfolio add: account1.
	portfolio add: account2.
		
	self assert: portfolio balance equals: (account1 balance + account2 balance)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MS 5/16/2024 12:41:38'!
test04NoSePuedeAgregarDosVecesLaMismaCuentaAPortfolio

	| portfolio account1 |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	
	portfolio := Portfolio new. 
	portfolio add: account1.
		 	
	self
	        should: [ portfolio add: account1. ]
	        raise: Error 
	        withExceptionDo: [ :anError |
	            self assert: anError messageText = Portfolio accountOrPortfolioAlreadyInPortfolioErrorDescription ]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MS 5/16/2024 12:17:25'!
test05PortfolioNoTieneTransaccionRegistrada

	| portfolio account1 account2 deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	deposit1 := Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount new.
	deposit2 := Deposit register: 80 on: account2.
	
	portfolio := Portfolio new. 
	portfolio add: account1.

	self deny: (portfolio hasRegistered: deposit2)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MS 5/16/2024 12:17:25'!
test06PortfolioTieneTransaccionRegistrada

	| portfolio account1 account2 deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	deposit1 := Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount new.
	deposit2 := Deposit register: 80 on: account2.
	
	portfolio := Portfolio new. 
	portfolio add: account1.
	portfolio add: account2.

	self assert: (portfolio hasRegistered: deposit2)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MS 5/16/2024 11:50:36'!
test07PortfolioVacioNoDevuelveTransacciones

	| portfolio |
		
	portfolio := Portfolio new. 

	self assert: (portfolio transactions isEmpty)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MS 5/16/2024 12:17:25'!
test08PortfolioDevuelveTransacciones

	| portfolio account1 account2 deposit1 deposit2 transactions |
	
	account1 := ReceptiveAccount new.
	deposit1 := Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount new.
	deposit2 := Deposit register: 80 on: account2.
	
	portfolio := Portfolio new. 
	portfolio add: account1.
	portfolio add: account2.

	transactions := Set with: deposit1 with: deposit2.

	self assert: (portfolio transactions) equals: transactions.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MS 5/16/2024 12:17:53'!
test09PortfolioConPortfolioTieneBalanceDelDeAdentro

	| portfolio1 portfolio2 account deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolio1 := Portfolio new. 
	
	portfolio2 := Portfolio new.
	portfolio2 add: account.
	
	portfolio1 add: portfolio2.

	self assert: (portfolio1 balance) equals: (portfolio2 balance).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MS 5/16/2024 12:20:44'!
test10PortfolioConPortfolioYCuentasTieneBalanceTotal

	| portfolio1 portfolio2 account1 account2 deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	deposit1 := Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount new.
	deposit2 := Deposit register: 80 on: account2.
	
	portfolio1 := Portfolio new. 
	portfolio1 add: account1.
	
	portfolio2 := Portfolio new. 
	portfolio2 add: account2.
	
	portfolio1 add: portfolio2.

	self assert: (portfolio1 balance) equals: (portfolio2 balance + account1 balance).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MS 5/16/2024 12:41:57'!
test11NoSePuedeAgregarCuentaAPortfolioQueYaLaContiene

	| portfolio1 portfolio2 account1 account2 deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	deposit1 := Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount new.
	deposit2 := Deposit register: 80 on: account2.
	
	portfolio1 := Portfolio new. 
	portfolio1 add: account1.
	
	portfolio2 := Portfolio new. 
	portfolio2 add: account2.
	
	portfolio1 add: portfolio2.
	
	self
	        should: [ portfolio1 add: account2. ]
	        raise: Error 
	        withExceptionDo: [ :anError |
	            self assert: anError messageText = Portfolio accountOrPortfolioAlreadyInPortfolioErrorDescription ]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MS 5/16/2024 20:47:15'!
test12NoSePuedeAgregarPortfolioAPortfolioQueYaContieneUnaDeSusCuentas

	| portfolio1 portfolio2 account deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolio1 := Portfolio new. 
	portfolio1 add: account.
	
	portfolio2 := Portfolio new. 
	portfolio2 add: account.
	
	self
	        should: [ portfolio1 add: portfolio2.]
	        raise: Error 
	        withExceptionDo: [ :anError |
	            self assert: anError messageText = Portfolio accountOrPortfolioAlreadyInPortfolioErrorDescription ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MS 5/16/2024 20:35:58'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'MS 5/16/2024 20:39:06'!
effectOnBalance: aPartialBalance

	self subclassResponsibility! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'MS 5/16/2024 20:39:16'!
effectOnBalance: aPartialBalance

	^ aPartialBalance + self value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'MS 5/16/2024 20:39:30'!
effectOnBalance: aPartialBalance

	^ aPartialBalance - self value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialEntity category: #'Portfolio-Ejercicio'!
Object subclass: #FinancialEntity
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialEntity methodsFor: 'balance' stamp: 'MS 5/16/2024 21:14:25'!
balance

	self subclassResponsibility! !

!FinancialEntity methodsFor: 'balance' stamp: 'MS 5/16/2024 21:14:42'!
isAlreadyIncludedIn: anAccountsAndPortfoliosSet

	self subclassResponsibility! !


!FinancialEntity methodsFor: 'testing' stamp: 'MS 5/16/2024 21:14:32'!
hasRegistered: aTransaction

	self subclassResponsibility! !


!FinancialEntity methodsFor: 'validations' stamp: 'MS 5/16/2024 21:14:36'!
checkIfIsAlreadyIncluded: anAccountOrPortfolio

	self subclassResponsibility! !


!FinancialEntity methodsFor: 'transactions' stamp: 'MS 5/16/2024 21:14:52'!
transactions

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialEntity subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'accounts' stamp: 'MS 5/16/2024 21:03:45'!
add: anAccountOrPortfolio
	
	self assertThatItIsntYetInPortfolio: anAccountOrPortfolio.
		
	accountsAndPortfolios add: anAccountOrPortfolio
		! !

!Portfolio methodsFor: 'accounts' stamp: 'MS 5/16/2024 21:15:43'!
assertThatItIsntYetInPortfolio: anAccountOrPortfolio

	^ (self checkIfIsAlreadyIncluded: anAccountOrPortfolio)
		ifTrue: [self error: self class accountOrPortfolioAlreadyInPortfolioErrorDescription]! !

!Portfolio methodsFor: 'accounts' stamp: 'MS 5/16/2024 21:00:01'!
checkIfIsAlreadyIncluded: anAccountOrPortfolio

	^ anAccountOrPortfolio isAlreadyIncludedIn: accountsAndPortfolios 
! !

!Portfolio methodsFor: 'accounts' stamp: 'MS 5/16/2024 12:16:15'!
hasRegistered: aTransaction
 
	^ accountsAndPortfolios inject: false into: [ :anAccum :anAccount | (anAccount hasRegistered: aTransaction) | anAccum ]
	! !

!Portfolio methodsFor: 'accounts' stamp: 'MS 5/16/2024 21:29:56'!
transactions
	
	^ accountsAndPortfolios inject: (Set new) into: [ :aTransactionsSet :anAccount | aTransactionsSet addAll: (anAccount transactions asSet); yourself]! !


!Portfolio methodsFor: 'initialization' stamp: 'MS 5/16/2024 12:16:15'!
initialize

	accountsAndPortfolios := Set new.! !


!Portfolio methodsFor: 'balance' stamp: 'MS 5/16/2024 12:18:22'!
balance
		
	^ accountsAndPortfolios sum: [:anAccountOrPortfolio | anAccountOrPortfolio balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'balance' stamp: 'MS 5/16/2024 21:00:01'!
isAlreadyIncludedIn: anAccountsAndPortfoliosSet 

	^ anAccountsAndPortfoliosSet inject: false into: [ :anAccum :currentAccountOrPortfolio | (self checkIfIsAlreadyIncluded: currentAccountOrPortfolio)  | anAccum]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'MS 5/16/2024 12:38:22'!
accountOrPortfolioAlreadyInPortfolioErrorDescription
	
	^ 'Esa cuenta o portfolio ya está agregada'! !



!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialEntity subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'MS 5/16/2024 21:13:33'!
balance

	^ transactions inject: 0 into: [ :balanceParcial :aTransaction | (aTransaction effectOnBalance: balanceParcial)] 

	
	! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'MS 5/16/2024 12:43:57'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'validations' stamp: 'MS 5/16/2024 21:00:01'!
checkIfIsAlreadyIncluded: anAccountOrPortfolio 
	
	^ self = anAccountOrPortfolio ! !

!ReceptiveAccount methodsFor: 'validations' stamp: 'MS 5/16/2024 21:00:01'!
isAlreadyIncludedIn: anAccountsAndPortfoliosSet 

	^ anAccountsAndPortfoliosSet inject: false into: [ :anAccum :currentAccountOrPortfolio | (currentAccountOrPortfolio checkIfIsAlreadyIncluded: self ) | anAccum]! !
