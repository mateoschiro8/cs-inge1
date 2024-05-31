!classDefinition: #PortfolioTest category: #'Portfolio 2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio 2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: #'Portfolio 2'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 12:28:09'!
test01EmptyReceptiveAccountSummaryReturnsBalance0

	| account expectedSummary|
	account := ReceptiveAccount new.
	
	expectedSummary := OrderedCollection with: 'Balance = 0'.
	
	self assert: account summary equals: expectedSummary. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 12:28:18'!
test02ReceptiveAccountWithDepositReportsCorrectly

	| account expectedSummary |
	account := ReceptiveAccount new.
	
	account register: (Deposit for: 100).
	
	expectedSummary := OrderedCollection with: 'Deposito por 100.' with: 'Balance = 100'.
	
	self assert: account summary equals: expectedSummary. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 12:28:23'!
test03ReceptiveAccountWithWithdrawReportsCorrectly

	| account expectedSummary |
	account := ReceptiveAccount new.
	
	account register: (Withdraw for: 50).
	
	expectedSummary := OrderedCollection with: 'Extraccion por 50.' with: 'Balance = -50'.
	
	self assert: account summary equals: expectedSummary. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 12:28:26'!
test04ReceptiveAccountsWithTransferReportCorrectly

	| account1 account2 expectedSummaryAccount1 expectedSummaryAccount2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer for: 20 from: account1 to: account2.
	
	expectedSummaryAccount1 := OrderedCollection with: 'Salida por transferencia de 20.' with: 'Balance = -20'.
	expectedSummaryAccount2 := OrderedCollection with: 'Entrada por transferencia de 20.' with: 'Balance = 20'.
	
	self assert: account1 summary equals: expectedSummaryAccount1. 
	self assert: account2 summary equals: expectedSummaryAccount2. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 12:28:31'!
test05ReceptiveAccountWithMoreThanOneMovementReportsCorrectly

	| account expectedSummary |
	account := ReceptiveAccount new.
	
	account register: (Deposit for: 100).
	account register: (Withdraw for: 40).
	
	expectedSummary := OrderedCollection with: 'Deposito por 100.' with: 'Extraccion por 40.' with: 'Balance = 60'.
	
	self assert: account summary equals: expectedSummary. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 12:30:36'!
test06EmptyPortfolioSummaryReturnsBalance0

	| portfolio expectedSummary|
	portfolio := Portfolio new.
	
	expectedSummary := OrderedCollection with: 'Balance = 0'.
	
	self assert: portfolio summary equals: expectedSummary. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 16:16:21'!
test07PortfolioWithOneAccountReportsCorrectly

	| account portfolio expectedSummary |
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	account register: (Deposit for: 100).
	expectedSummary := account summary.
	
	self assert: portfolio summary equals: expectedSummary. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 16:16:48'!
test08PortfolioWithMoreThanOneAccountReportsCorrectly

	| account1 account2 portfolio expectedSummary |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio with: account1 with: account2.
	
	account1 register: (Deposit for: 100).
	account2 register: (Withdraw for: 50).
	
	expectedSummary := account1 summaryWithoutBalance .
	expectedSummary addAll: account2 summaryWithoutBalance .
	expectedSummary addLast: 'Balance = ', (account1 balance + account2 balance) asString.
	
	self assert: portfolio summary equals: expectedSummary. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 16:54:20'!
test09PortfolioWithPortfolioReportsSummaryCorrectly

	| account1 account2 portfolio portfolioToAdd expectedSummary |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolioToAdd := Portfolio with: account1 with: account2.
	portfolio := Portfolio with: portfolioToAdd.
	
	account1 register: (Deposit for: 100).
	account2 register: (Withdraw for: 50).
	
	expectedSummary := account1 summaryWithoutBalance.
	expectedSummary addAll: account2 summaryWithoutBalance.
	expectedSummary addLast: 'Balance = ', (account1 balance + account2 balance) asString.
	
	self assert: portfolio summary equals: expectedSummary. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 16:31:34'!
test10EmptyReceptiveAccountTransferNetReturns0

	| account expectedNet|
	account := ReceptiveAccount new.
	
	expectedNet := 0.
	
	self assert: account transferNet equals: expectedNet. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 16:54:32'!
test11ReceptiveAccountWithMoreThanOneTransferReportsTransferNetCorrectly

	| account1 account2 expectedNetAccount1 expectedNetAccount2|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer for: 100 from: account1 to: account2.
	Transfer for: 30 from: account2 to: account1.
	
	expectedNetAccount1 := -70.
	expectedNetAccount2 := 70.
	
	self assert: account1 transferNet equals: expectedNetAccount1.
	self assert: account2 transferNet equals: expectedNetAccount2.
	 ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 16:54:42'!
test12ReceptiveAccountWithOneTransferReportsTransferNetCorrectly

	| account1 account2 expectedNetAccount1 expectedNetAccount2|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer for: 100 from: account1 to: account2.
	
	expectedNetAccount1 := -100.
	expectedNetAccount2 := 100.
	
	self assert: account1 transferNet equals: expectedNetAccount1.
	self assert: account2 transferNet equals: expectedNetAccount2.
	 ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 16:45:12'!
test13ReceptiveAccountWithNormalTransactionsAndNoTranfersTrasferNetReturns0

	| account expectedNet|
	account := ReceptiveAccount new.
	
	account register: (Deposit for: 100).
	account register: (Withdraw for: 40).
	
	expectedNet := 0.

	self assert: account transferNet equals: expectedNet.

	 ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 16:53:35'!
test14EmptyPortfolioTransferNetReturns0

	| portfolio expectedNet|
	portfolio := Portfolio new.
	
	expectedNet := 0.
	
	self assert: portfolio transferNet equals: expectedNet. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 16:58:05'!
test15PortfolioWithOneAccountThatHasATransferReportsTransferNetCorrectly

	| account1 account2 portfolio portfolioExpectedNet |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio with: account1.
	
	Transfer for: 50 from: account1 to: account2.
	portfolioExpectedNet := -50.

	self assert: portfolio transferNet equals: portfolioExpectedNet. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 17:01:29'!
test16PortfolioWithMoreThanOneAccountThatHasATransferReportsTransferNetCorrectly

	| account1 account2 portfolio portfolioExpectedNet |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio with: account1 with: account2.
	
	Transfer for: 50 from: account1 to: account2.
	portfolioExpectedNet := 0.

	self assert: portfolio transferNet equals: portfolioExpectedNet. ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 17:02:50'!
test17PortfolioWithPortfolioThatHasATransferReportsTransferNetCorrectly

	| account1 account2 portfolio portfolioToAdd portfolioExpectedNet |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	portfolioToAdd := Portfolio with: account1.
	portfolio := Portfolio with: portfolioToAdd.
	
	Transfer for: 50 from: account1 to: account2.
	portfolioExpectedNet := -50.

	self assert: portfolio transferNet equals: portfolioExpectedNet. ! !


!classDefinition: #TransferTest category: #'Portfolio 2'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fb 5/20/2024 19:53:52'!
test01TransferBetweenAccountsModifiesBothBalances

	|account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer for: 50 from: account1 to: account2.
	
	self assert: account1 balance equals: -50.
	self assert: account2 balance equals: 50.
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fb 5/20/2024 20:19:53'!
test02AccountsHaveRegisteredTransactions

	|account1 account2 transfer associatedWithdraw associatedDeposit|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer for: 50 from: account1 to: account2.
	
	associatedDeposit := transfer associatedDeposit. 
	associatedWithdraw := transfer associatedWithdraw. 
	
	self assert: (account1 hasRegistered: associatedWithdraw).
	self assert: (account2 hasRegistered: associatedDeposit).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fb 5/20/2024 20:34:41'!
test03TransferPartsKnowWhereTheyComeFrom

	|account1 account2 transfer withdraw deposit|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer for: 50 from: account1 to: account2.
	
	deposit := transfer associatedDeposit. 
	withdraw := transfer associatedWithdraw. 
	
	self assert: deposit associatedTransfer equals: transfer.
	self assert: withdraw associatedTransfer equals: transfer.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 11:51:53'!
test04ZeroTransferRaisesError

	|account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	
	self 
		should: [ Transfer for: 0 from: account1 to: account2.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer negativeOrZeroValueErrorDescription equals: anError messageText.]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 11:51:14'!
test05ShouldntBePossibleToTransferToSameAccount

	|account1 |
	
	account1 := ReceptiveAccount new.
	
	self 
		should: [ Transfer for: 50 from: account1 to: account1.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer accountsAreTheSameErrorDescription equals: anError messageText.]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fb 5/21/2024 11:52:00'!
test06NegativeTransferRaisesError

	|account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	
	self 
		should: [ Transfer for: -5 from: account1 to: account2.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer negativeOrZeroValueErrorDescription equals: anError messageText.]! !


!classDefinition: #Account category: #'Portfolio 2'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'fb 5/21/2024 12:31:31'!
summary

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'Portfolio 2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'fb 5/21/2024 16:14:58'!
summary
	|res|
	res := self summaryWithoutBalance.
	
	res addLast: 'Balance = ' , self balance asString.
	
	^ res! !

!Portfolio methodsFor: 'reports' stamp: 'fb 5/21/2024 16:15:53'!
summaryWithoutBalance

	|res|
	
	res := OrderedCollection new.
	
	accounts do: [:anAccount | res addAll: (anAccount summaryWithoutBalance)].
	
	^res! !

!Portfolio methodsFor: 'reports' stamp: 'fb 5/21/2024 16:59:23'!
transferNet

	^accounts sum: [ :anAccount | anAccount transferNet ] ifEmpty: [ 0 ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio 2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio 2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'fb 5/21/2024 16:14:58'!
summary
	
	|res|
	
	res := self summaryWithoutBalance.
	
	res addLast: ('Balance = ', self balance asString).
	
	^res
! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'fb 5/21/2024 12:19:42'!
summaryMessageFor: aTransaction
	
	(aTransaction isKindOf: NormalDeposit)
		ifTrue:[^'Deposito por ', aTransaction value asString , '.'].
		
	(aTransaction isKindOf: NormalWithdraw)
		ifTrue:[^'Extraccion por ', aTransaction value asString , '.'].
		
	(aTransaction isKindOf: TransferDeposit)
		ifTrue:[^'Entrada por transferencia de ', aTransaction value asString , '.'].
		
	(aTransaction isKindOf: TransferWithdraw)
		ifTrue:[^'Salida por transferencia de ', aTransaction value asString , '.'].
			
! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'fb 5/21/2024 16:14:58'!
summaryWithoutBalance

	|res|
	
	res := OrderedCollection new.
	
	transactions do: [:aTransaction | res addLast: (self summaryMessageFor: aTransaction)].
	
	^res! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'fb 5/21/2024 16:50:16'!
transferNet
	
	^transactions 
		inject: 0
		into: [ :currentTransferNet :transaction | transaction affectTransferNet: currentTransferNet] 
! !


!classDefinition: #AccountReport category: #'Portfolio 2'!
Object subclass: #AccountReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!


!classDefinition: #Summary category: #'Portfolio 2'!
AccountReport subclass: #Summary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Summary methodsFor: 'as yet unclassified' stamp: 'fb 5/27/2024 12:24:44'!
initializeFor: anAccount

	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Summary class' category: #'Portfolio 2'!
Summary class
	instanceVariableNames: ''!

!Summary class methodsFor: 'as yet unclassified' stamp: 'fb 5/27/2024 12:24:27'!
for: anAccount

	^self new initializeFor: anAccount! !


!classDefinition: #AccountTransaction category: #'Portfolio 2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!AccountTransaction methodsFor: 'value' stamp: 'fb 5/20/2024 21:01:25'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'fb 5/20/2024 21:01:49'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio 2'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio 2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio 2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'fb 5/20/2024 20:57:36'!
for: aValue

	^ NormalDeposit new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'fb 5/20/2024 21:15:34'!
forTransfer: aTransfer

	^ TransferDeposit new initializeFor: aTransfer! !


!classDefinition: #NormalDeposit category: #'Portfolio 2'!
Deposit subclass: #NormalDeposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!NormalDeposit methodsFor: 'balance' stamp: 'fb 5/20/2024 20:56:28'!
affectBalance: aBalance

	^aBalance + value ! !

!NormalDeposit methodsFor: 'balance' stamp: 'fb 5/21/2024 16:49:27'!
affectTransferNet: currentTransferNet

	^currentTransferNet ! !


!NormalDeposit methodsFor: 'initialization' stamp: 'fb 5/20/2024 20:57:18'!
initializeFor: aValue

	value := aValue ! !


!NormalDeposit methodsFor: 'value' stamp: 'fb 5/20/2024 20:57:25'!
value

	^ value! !


!classDefinition: #TransferDeposit category: #'Portfolio 2'!
Deposit subclass: #TransferDeposit
	instanceVariableNames: 'associatedTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!TransferDeposit methodsFor: 'initialization' stamp: 'fb 5/20/2024 21:00:22'!
initializeFor: aTransfer

	associatedTransfer  := aTransfer.! !


!TransferDeposit methodsFor: 'balance' stamp: 'fb 5/20/2024 21:06:14'!
affectBalance: aBalance

	^ aBalance + associatedTransfer value! !

!TransferDeposit methodsFor: 'balance' stamp: 'fb 5/21/2024 16:49:40'!
affectTransferNet: currentTransferNet

	^currentTransferNet + associatedTransfer value! !


!TransferDeposit methodsFor: 'associated transfer' stamp: 'fb 5/20/2024 21:13:06'!
associatedTransfer

	^associatedTransfer
! !


!TransferDeposit methodsFor: 'value' stamp: 'fb 5/20/2024 21:02:20'!
value

	^ associatedTransfer value.! !


!classDefinition: #Withdraw category: #'Portfolio 2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio 2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'fb 5/20/2024 21:08:37'!
for: aValue

	^ NormalWithdraw new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'fb 5/20/2024 21:15:34'!
forTransfer: aTransfer

	^ TransferWithdraw new initializeFor: aTransfer! !


!classDefinition: #NormalWithdraw category: #'Portfolio 2'!
Withdraw subclass: #NormalWithdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!NormalWithdraw methodsFor: 'balance' stamp: 'fb 5/20/2024 21:03:52'!
affectBalance: aBalance

	^aBalance - value! !


!NormalWithdraw methodsFor: 'initialization' stamp: 'fb 5/20/2024 21:04:12'!
initializeFor: aValue

	value := aValue ! !


!NormalWithdraw methodsFor: 'value' stamp: 'fb 5/21/2024 16:49:50'!
affectTransferNet: currentTransferNet

	^currentTransferNet ! !

!NormalWithdraw methodsFor: 'value' stamp: 'fb 5/20/2024 21:05:12'!
value

	^ value! !


!classDefinition: #TransferWithdraw category: #'Portfolio 2'!
Withdraw subclass: #TransferWithdraw
	instanceVariableNames: 'associatedTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!TransferWithdraw methodsFor: 'balance' stamp: 'fb 5/20/2024 21:06:24'!
affectBalance: aBalance

	^ aBalance - associatedTransfer value! !

!TransferWithdraw methodsFor: 'balance' stamp: 'fb 5/21/2024 16:49:56'!
affectTransferNet: currentTransferNet

	^currentTransferNet  - associatedTransfer value! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'fb 5/20/2024 21:06:54'!
initializeFor: aTransfer

	associatedTransfer  := aTransfer.! !


!TransferWithdraw methodsFor: 'associated transfer' stamp: 'fb 5/20/2024 21:04:05'!
associatedTransfer

	^associatedTransfer
! !


!TransferWithdraw methodsFor: 'value' stamp: 'fb 5/20/2024 21:07:12'!
value

	^associatedTransfer value! !


!classDefinition: #Transfer category: #'Portfolio 2'!
Object subclass: #Transfer
	instanceVariableNames: 'associatedDeposit associatedWithdraw value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'fb 5/20/2024 20:15:50'!
associatedDeposit
	
	^associatedDeposit.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'fb 5/20/2024 20:16:19'!
associatedWithdraw
	
	^ associatedWithdraw.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'fb 5/20/2024 21:15:34'!
initializeFor: aValue from: anOriginAccount to: aDestinationAccount
	
	value := aValue.
	associatedDeposit  := (Deposit  forTransfer: self).
	associatedWithdraw := (Withdraw forTransfer: self).
	anOriginAccount register: associatedWithdraw.
	aDestinationAccount register: associatedDeposit.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'fb 5/20/2024 21:02:53'!
value

	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio 2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'transactions' stamp: 'fb 5/21/2024 11:51:01'!
accountsAreTheSameErrorDescription

	 ^'COMO VAS A TRANSFERIR A LA MISMA CUENTA FLACO VOS ESTAS LOCO???????'! !

!Transfer class methodsFor: 'transactions' stamp: 'fb 5/21/2024 11:50:38'!
assertAccount: anOriginAccount isDifferentFrom: aDestinationAccount

	(anOriginAccount = aDestinationAccount)
		ifTrue:[self error: self accountsAreTheSameErrorDescription]! !

!Transfer class methodsFor: 'transactions' stamp: 'fb 5/20/2024 21:18:15'!
assertValueIsPositive: aValue

	aValue > 0 ifFalse: [self error: self negativeOrZeroValueErrorDescription].

	! !

!Transfer class methodsFor: 'transactions' stamp: 'fb 5/21/2024 11:49:17'!
for: aValue from: anOriginAccount to: aDestinationAccount 

	self assertValueIsPositive: aValue.
	self assertAccount: anOriginAccount isDifferentFrom: aDestinationAccount.
	
	^self new initializeFor: aValue from: anOriginAccount to: aDestinationAccount.! !

!Transfer class methodsFor: 'transactions' stamp: 'fb 5/20/2024 21:18:15'!
negativeOrZeroValueErrorDescription

	^ 'COMO VAS A TRANSFERIR POR 0 O NEGATIVO FLACO?????'! !
