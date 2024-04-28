!classDefinition: #PenalesTest category: #'ISW1-2023-2C-Parcial-1'!
TestCase subclass: #PenalesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test01DelanteroNoPuedeApuntarHaciaAfueraDelPaloIzquierdo
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: -1@0 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test02DelanteroNoPuedeApuntarHaciaAfueraDelPaloDerecho
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 3@0 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test03DelanteroNoPuedeApuntarHaciaAbajoDelArco
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@-1 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test04DelanteroNoPuedeApuntarHaciaArribaDelTravesaño
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@3 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test05ArqueroNoPuedePasarseDelPaloIzquierdo
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: -1@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test06ArqueroNoPuedePasarseDelPaloDerecho
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 3@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test07ArqueroNoPuedeMeterseAbajoDeLaTierra
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@-1.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test08ArqueroNoPuedeSaltarPorEncimaDelTravesaño
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@3.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test09DireccionesDiferentesGolDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 0@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante
	"varXXXX es por VAR, de 'Video Assistant Referee'"! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test10MismasDireccionesInsuficienteFuerzaGolDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 10.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test11MismasDireccionesSuficienteFuerzaAtajaArquero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test12DelanteroQueTiraAColocarPierde50PorcFuerza
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"(delantero sacrificia potencia para ganar mayor precisión)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 50.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test13ArqueroQueEligeAntesDeTiroVsJabulaniAColocarSuma50PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que elige donde tirarse antes de un tiro a colocar de jabulani gana 50% de su fuerza extra..."
	"(el arquero llega más cómodo y aprovecha mejor su fuerza)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 34.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 51 equals: juegoPenales varFuerzaResultanteDeAtajada.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test14FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsJabulaniAColocar
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que elige adonde tirarse antes de un tiro a colocar de jabulani gana 50% de su fuerza extra..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 32.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 48 equals: juegoPenales varFuerzaResultanteDeAtajada.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test15ArqueroQueEsperaPorTiroYSeAdelantaVsJabulaniAColocarIgnoraAlturaTiro
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que espera y se adelanta ante un tiro de jabulani a colocar ignora la 2da coordenada (altura) al atajar..."	
	"(al adelanterse encara la pelota antes de que su elevación se transforme en un problema)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero  esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 50.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test16PelotaPlayeraUsadaAColocarLeHacePerder20PorcFuerzaExtraAlDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% de fuerza adicional al delantero que la use para colocar... (no importa el arquero)"
	"(no debería ser reglamentaria... al menos no es de trapo, nos responden)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 1.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@2 arqueroSeLanzaEnDirección: 1@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro! !

!PenalesTest methodsFor: 'tests' stamp: 'fb 4/26/2024 11:12:36'!
test17ArqueroQueEligeAntesDeTiroVsPlayeraAColocarSuma100PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% adicional de fuerza al delantero que la use para colocar... (no importa el arquero)"
	"Arquero que elige donde lanzarse antes de un remate de una pelota playera lenta a colocar, gana un 100% de su fuerza extra..."
	"(a quien madruga...)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 20.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeAtajada! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test18FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsPlayeraAColocar
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% adicional de fuerza al delantero que la use para colocar... (no importa el arquero)"
	"Arquero que elige donde lanzarse antes de un remate de una pelota playera lenta a colocar, gana un 100% de su fuerza extra..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 19.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 38 equals: juegoPenales varFuerzaResultanteDeAtajada! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test19ArqueroQueEsperaPorTiroYSeAdelantaVsPlayeraAColocarEsDescubiertoYPuntoParaDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Arquero que espera y se adelanta ante tiro con la lenta pelota playera, siempre es descubierto por el Árbitro, y el punto se le otorga al Delantero..."
	"(lo que servía de ventaja ante la Jabulani rápida, acá es tan obvio por lo que tarda en llegar la pelota al arco, que marchás preso...)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero  esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:52'!
test20DelanteroTiraAMatarAlAnguloInferiorIzquierdoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:47'!
test21DelanteroTiraAMatarAlAnguloSuperiorIzquierdoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:41'!
test22DelanteroTiraAMatarAlAnguloInferiorDerechoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@0 arqueroSeLanzaEnDirección: 2@0.
	
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:36'!
test23DelanteroTiraAMatarAlAnguloSuperiorDerechoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:29'!
test24DelanteroTiraAMatarNoAlAnguloMantieneDireccionTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@2 arqueroSeLanzaEnDirección: 1@1.

	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test25DelanteroTiraAMatarUsa100PorcFuerzaBase
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:150.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@0 arqueroSeLanzaEnDirección: 2@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 150 equals: juegoPenales varFuerzaResultanteDeTiro! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test26DelanteroTiraAMatarConJabulaniGana20PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando la jabulani rápida, el Delantero gana un 20% de fuerza extra... (no importa arquero)"
	"(Jabulani a matar es la elección de los guerreros Z)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 120.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 120 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test27FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsJabulaniAMatar
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando la jabulani rápida, el Delantero gana un 20% de fuerza extra... (no importa arquero)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 119.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 120 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test28ArqueroQueEligeAntesDeTiroVsJabulaniAMatarIgnoraAlturaTiro
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que elige donde tirarse antes de un tiro de jabulani a matar, ignora la 2da coordenada (altura) al atajar..."		
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test29ArqueroQueEsperaPorTiroYSeAdelantaVsJabulaniAMatarNuncaAtaja
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que espera a ver la dirección del remate de una pelota jabulani rápida a matar antes de lanzarse, nunca la ataja sin importar nada, siquiera que se adelantó..."	
	"(su poder era de más de 9000!! era impresionante, no podía moverme, sólo la ví pasar... f )"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@1 arqueroSeLanzaEnDirección: 1@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test30DelanteroQueNoPateaAlAnguloConPlayeraAMatarSuma2AAlturaDeDireccionPelotaAdentro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"(y voló.. y me hizo volar... y yo volé de él...  pero acá por la arbolada... y el voló.. y se estrelló por acá por la pared...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@0 arqueroSeLanzaEnDirección: 1@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test31DelanteroQueNoPateaAlAnguloConPlayeraAMatarSuma2AAlturaDeDireccionPelotaAfuera
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"(El caso auspiciado por el Pipita...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@1 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@3 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test32ArqueroQueEligeAntesDeTiroVsPlayeraAMatarAlAnguloIgnoraAnchoTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si el arquero elige donde tirarse antes del tiro a matar de la pelota playera, ignora la 1ra coordenada del remate (ancho) al atajar..."
	"(con agacharse, quedarse parado, o saltar le alcanza...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 18:39:22'!
test33ArqueroQueEligeAntesDeTiroVsPlayeraAMatarNoAlAnguloIgnoraAnchoTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"Si el arquero elige donde tirarse antes del tiro a matar de la pelota playera, ignora la 1ra coordenada del remate (ancho) al atajar..."
	"(con agacharse, quedarse parado, o saltar le alcanza...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@0 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test34ArqueroQueEsperaPorTiroYSeAdelantaVsPlayeraAMatarSiempreAtaja
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que espera y se adelanta ante una pelota playera lenta a matar, siempre la ataja sin importar nada..."	
	"(como la pelota es taaaan lentaaa, el arquero se puede ir a tomar un cafe, verse una serie, volver y aún atajar la pelota habiendose tirado a cualquier lado. Pero igual es más rapida que cuando se la tira a colocar, donde indefectiblemente el arbitro lo detecta...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 1.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !


!classDefinition: #Arquero category: #'ISW1-2023-2C-Parcial-1'!
Object subclass: #Arquero
	instanceVariableNames: 'fuerzaBase estrategia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!Arquero methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:44:38'!
atajaUnaJabulaniAColocarEnElJuego: instanciaPenales

	estrategia paraAtajarUnaJabulaniAColocarEnElJuego: instanciaPenales.! !

!Arquero methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:17:54'!
atajaUnaJabulaniAMatarEnElJuego: instanciaPenales

	estrategia paraAtajarUnaJabulaniAMatarEnElJuego: instanciaPenales.! !

!Arquero methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:44:27'!
atajaUnaPlayeraAColocarEnElJuego: instanciaPenales

	estrategia paraAtajarUnaPlayeraAColocarEnElJuego: instanciaPenales.! !

!Arquero methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:24:40'!
atajaUnaPlayeraAMatarEnElJuego: instanciaPenales

	estrategia paraAtajarUnaPlayeraAMatarEnElJuego: instanciaPenales.! !

!Arquero methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 10:48:38'!
estrategia

	^estrategia ! !

!Arquero methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 10:48:22'!
fuerzaBase

	^ fuerzaBase ! !

!Arquero methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 10:15:30'!
initializeWith: unaFuerzaBase andEstrategia: unaEstrategia

	fuerzaBase := unaFuerzaBase .
	estrategia := unaEstrategia .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Arquero class' category: #'ISW1-2023-2C-Parcial-1'!
Arquero class
	instanceVariableNames: ''!

!Arquero class methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:28:30'!
eligeDireccionAntesDeTiroSuFuerzaBaseEs: unaFuerzaBase

	^ self new initializeWith: unaFuerzaBase andEstrategia: (EligeDireccionAntesTiro new)! !

!Arquero class methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:28:35'!
esperaPorTiroYSeAdelantaSuFuerzaBaseEs: unaFuerzaBase

	^ self new initializeWith: unaFuerzaBase andEstrategia: (EsperaTiroYSeAdelanta new)! !


!classDefinition: #Delantero category: #'ISW1-2023-2C-Parcial-1'!
Object subclass: #Delantero
	instanceVariableNames: 'fuerzaBase estrategiaDeTiro'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!Delantero methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 10:36:27'!
estrategiaDeTiro

	^ estrategiaDeTiro copy! !

!Delantero methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 10:36:23'!
fuerzaBase

	^fuerzaBase copy! !

!Delantero methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 10:12:46'!
initializeWith: unaFuerzaBase andEstrategia: unaEstrategia

	fuerzaBase := unaFuerzaBase.
	estrategiaDeTiro := unaEstrategia .! !

!Delantero methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:15:28'!
remataCon: unaPelota alArquero: unArquero enElJuego: instanciaPenales

	estrategiaDeTiro con: unaPelota  alArquero: unArquero enElJuego: instanciaPenales ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Delantero class' category: #'ISW1-2023-2C-Parcial-1'!
Delantero class
	instanceVariableNames: ''!

!Delantero class methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:03:49'!
decideTirarAColocarSuFuerzaBaseEs: unaFuerzaBase

	^ self new initializeWith: unaFuerzaBase andEstrategia: (AColocar new)! !

!Delantero class methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:03:59'!
decideTirarAMatarSuFuerzaBaseEs: unaFuerzaBase

	^ self new initializeWith: unaFuerzaBase andEstrategia: (AMatar new)! !


!classDefinition: #EstrategiaDeAtajada category: #'ISW1-2023-2C-Parcial-1'!
Object subclass: #EstrategiaDeAtajada
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!EstrategiaDeAtajada methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:30:23'!
paraAtajarUnaJabulaniAColocarEnElJuego: instanciaPenales

	self subclassResponsibility! !

!EstrategiaDeAtajada methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:18:21'!
paraAtajarUnaJabulaniAMatarEnElJuego: instanciaPenales

	self subclassResponsibility! !

!EstrategiaDeAtajada methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:44:50'!
paraAtajarUnaPlayeraAColocarEnElJuego: instanciaPenales

	self subclassResponsibility! !

!EstrategiaDeAtajada methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:24:57'!
paraAtajarUnaPlayeraAMatarEnElJuego: instanciaPenales

	self subclassResponsibility! !


!classDefinition: #EligeDireccionAntesTiro category: #'ISW1-2023-2C-Parcial-1'!
EstrategiaDeAtajada subclass: #EligeDireccionAntesTiro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!EligeDireccionAntesTiro methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:43:13'!
paraAtajarUnaJabulaniAColocarEnElJuego: instanciaPenales

	instanciaPenales establecerFuerzaArqueroEligeDireccionContraJabulaniAColocar! !

!EligeDireccionAntesTiro methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:18:51'!
paraAtajarUnaJabulaniAMatarEnElJuego: instanciaPenales

	instanciaPenales establecerDireccionArqueroIgnoraAlturaRemate! !

!EligeDireccionAntesTiro methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:46:18'!
paraAtajarUnaPlayeraAColocarEnElJuego: instanciaPenales

	instanciaPenales establecerFuerzaArqueroEligeDireccionContraPlayeraAColocar.! !

!EligeDireccionAntesTiro methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:25:21'!
paraAtajarUnaPlayeraAMatarEnElJuego: instanciaPenales

	instanciaPenales establecerDireccionAtajadaIgnoraCoordenadaX.! !


!classDefinition: #EsperaTiroYSeAdelanta category: #'ISW1-2023-2C-Parcial-1'!
EstrategiaDeAtajada subclass: #EsperaTiroYSeAdelanta
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!EsperaTiroYSeAdelanta methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:39:27'!
paraAtajarUnaJabulaniAColocarEnElJuego: instanciaPenales

	instanciaPenales establecerDireccionArqueroIgnoraAlturaRemate.! !

!EsperaTiroYSeAdelanta methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:19:23'!
paraAtajarUnaJabulaniAMatarEnElJuego: instanciaPenales

	instanciaPenales sumarPuntoAlDelantero.! !

!EsperaTiroYSeAdelanta methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:09:22'!
paraAtajarUnaPlayeraAColocarEnElJuego: instanciaPenales

	instanciaPenales sumarPuntoAlDelantero ! !

!EsperaTiroYSeAdelanta methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:25:54'!
paraAtajarUnaPlayeraAMatarEnElJuego: instanciaPenales

	instanciaPenales sumarPuntoAlArquero.! !


!classDefinition: #EstrategiaDeTiro category: #'ISW1-2023-2C-Parcial-1'!
Object subclass: #EstrategiaDeTiro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!EstrategiaDeTiro methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:17:22'!
con: unaPelota alArquero: unArquero enElJuego: instanciaPenales

	self subclassResponsibility! !


!classDefinition: #AColocar category: #'ISW1-2023-2C-Parcial-1'!
EstrategiaDeTiro subclass: #AColocar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!AColocar methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:25:03'!
con: unaPelota  alArquero: unArquero enElJuego: instanciaPenales 

	instanciaPenales establecerFuerzaDelanteroPateaAColocar.
	
	unaPelota pateadaAColocarAlArcoDe: unArquero enElJuego: instanciaPenales.! !


!classDefinition: #AMatar category: #'ISW1-2023-2C-Parcial-1'!
EstrategiaDeTiro subclass: #AMatar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!AMatar methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:46:23'!
con: unaPelota  alArquero: unArquero enElJuego: instanciaPenales 

	unaPelota pateadaAMatarAlArcoDe: unArquero enElJuego: instanciaPenales.
	
	! !


!classDefinition: #Pelota category: #'ISW1-2023-2C-Parcial-1'!
Object subclass: #Pelota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!Pelota methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:25:24'!
pateadaAColocarAlArcoDe: unArquero enElJuego: instanciaPenales

	self subclassResponsibility! !

!Pelota methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:16:17'!
pateadaAMatarAlArcoDe: unArquero enElJuego: instanciaPenales

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pelota class' category: #'ISW1-2023-2C-Parcial-1'!
Pelota class
	instanceVariableNames: ''!

!Pelota class methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 10:13:51'!
jabulaniSudafricanaRapida

	^Jabulani new! !

!Pelota class methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 11:11:52'!
playeraLentaCostaAzul

	^ Playera new! !


!classDefinition: #Jabulani category: #'ISW1-2023-2C-Parcial-1'!
Pelota subclass: #Jabulani
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!Jabulani methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 12:42:58'!
pateadaAColocarAlArcoDe: unArquero enElJuego: instanciaPenales

	unArquero atajaUnaJabulaniAColocarEnElJuego: instanciaPenales.! !

!Jabulani methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:50:20'!
pateadaAMatarAlArcoDe: unArquero enElJuego: instanciaPenales
	
	instanciaPenales establecerDireccionDelanteroPateaAMatarJabulani.
	instanciaPenales establecerFuerzaDelanteroPateaUnaJabulaniAMatar.
	unArquero atajaUnaJabulaniAMatarEnElJuego: instanciaPenales.! !


!classDefinition: #Playera category: #'ISW1-2023-2C-Parcial-1'!
Pelota subclass: #Playera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!Playera methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:22:36'!
pateadaAColocarAlArcoDe: unArquero enElJuego: instanciaPenales

	instanciaPenales establecerFuerzaDelanteroPateaUnaPlayeraAColocar.
	unArquero atajaUnaPlayeraAColocarEnElJuego: instanciaPenales.! !

!Playera methodsFor: 'as yet unclassified' stamp: 'fb 4/26/2024 20:22:49'!
pateadaAMatarAlArcoDe: unArquero enElJuego: instanciaPenales

	instanciaPenales establecerDireccionDelanteroPateaAMatarPlayera.
	unArquero atajaUnaPlayeraAMatarEnElJuego: instanciaPenales.! !


!classDefinition: #Penales category: #'ISW1-2023-2C-Parcial-1'!
Object subclass: #Penales
	instanceVariableNames: 'delantero arquero puntajeDelantero puntajeArquero direccionRemateResultante direccionAtajadaResultante fuerzaResultanteDelantero fuerzaResultanteArquero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1'!

!Penales methodsFor: 'control del juego' stamp: 'fb 4/26/2024 20:54:08'!
arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: direccionTiro arqueroSeLanzaEnDirección: direccionArquero

	self chequearTiroEnRango: direccionTiro yAtajadaEnRango: direccionArquero.

	delantero remataCon: pelota alArquero: arquero enElJuego: self.
	
	self determinarResultadoDelPenalPateado.
	
! !

!Penales methodsFor: 'control del juego' stamp: 'fb 4/26/2024 20:54:21'!
determinarResultadoDelPenalPateado

	^ ((puntajeDelantero = 0) & (puntajeArquero = 0))
		ifTrue: [(direccionRemateResultante between: 0@0 and: 2@2)
			ifTrue:
				[direccionRemateResultante = direccionAtajadaResultante 
					ifFalse: [self sumarPuntoAlDelantero]
					ifTrue: [(fuerzaResultanteDelantero > fuerzaResultanteArquero)
								ifTrue:[self sumarPuntoAlDelantero]
								ifFalse: [self sumarPuntoAlArquero]].]
			ifFalse:[self sumarPuntoAlArquero]]! !


!Penales methodsFor: 'var' stamp: 'fb 4/26/2024 10:30:53'!
varDireccionRemateResultante

	^ direccionRemateResultante! !

!Penales methodsFor: 'var' stamp: 'fb 4/26/2024 10:57:03'!
varFuerzaResultanteDeAtajada

	^ fuerzaResultanteArquero ! !

!Penales methodsFor: 'var' stamp: 'fb 4/26/2024 10:55:20'!
varFuerzaResultanteDeTiro

	^ fuerzaResultanteDelantero ! !


!Penales methodsFor: 'puntajes' stamp: 'fb 4/26/2024 10:17:56'!
puntajeDeArquero

	^ puntajeArquero! !

!Penales methodsFor: 'puntajes' stamp: 'fb 4/26/2024 10:17:47'!
puntajeDeDelantero

	^ puntajeDelantero! !

!Penales methodsFor: 'puntajes' stamp: 'fb 4/26/2024 10:29:42'!
sumarPuntoAlArquero

	puntajeArquero := puntajeArquero + 1! !

!Penales methodsFor: 'puntajes' stamp: 'fb 4/26/2024 10:29:26'!
sumarPuntoAlDelantero

	puntajeDelantero := puntajeDelantero + 1! !


!Penales methodsFor: 'inicializacion' stamp: 'fb 4/26/2024 20:51:51'!
initializeWith: unDelantero andArquero: unArquero

	delantero := unDelantero.
	arquero := unArquero.
	puntajeDelantero := 0.
	puntajeArquero := 0.
	direccionRemateResultante := nil.
	direccionAtajadaResultante := nil.
	fuerzaResultanteDelantero := delantero fuerzaBase.
	fuerzaResultanteArquero := arquero fuerzaBase.! !


!Penales methodsFor: 'validaciones' stamp: 'fb 4/26/2024 20:53:22'!
chequearTiroEnRango: direccionTiro yAtajadaEnRango: direccionAtajada

	(direccionTiro between: 0@0 and: 2@2)
		ifFalse: [self error: self class direccionTiroFueraDeRango].
	
	(direccionAtajada between: 0@0 and: 2@2)
		ifFalse: [self error: self class direccionArqueroFueraDeRango].
		
	direccionRemateResultante := direccionTiro.
	direccionAtajadaResultante := direccionAtajada.! !


!Penales methodsFor: 'modificaciones' stamp: 'fb 4/26/2024 20:55:37'!
chequearSiElRemateFueHaciaUnaEsquina

	^ ((direccionRemateResultante x = 0) | (direccionRemateResultante x = 2)) & ((direccionRemateResultante y = 0) | (direccionRemateResultante y = 2))! !

!Penales methodsFor: 'modificaciones' stamp: 'fb 4/26/2024 12:38:24'!
establecerDireccionArqueroIgnoraAlturaRemate

	^ direccionAtajadaResultante := (direccionAtajadaResultante x)@(direccionRemateResultante y)! !

!Penales methodsFor: 'modificaciones' stamp: 'fb 4/26/2024 20:23:56'!
establecerDireccionAtajadaIgnoraCoordenadaX

	^ direccionAtajadaResultante := direccionRemateResultante x @ direccionAtajadaResultante y! !

!Penales methodsFor: 'modificaciones' stamp: 'fb 4/26/2024 20:55:37'!
establecerDireccionDelanteroPateaAMatarJabulani

	^ (self chequearSiElRemateFueHaciaUnaEsquina)
			ifTrue: [direccionRemateResultante := direccionRemateResultante x @ 1]! !

!Penales methodsFor: 'modificaciones' stamp: 'fb 4/26/2024 20:55:37'!
establecerDireccionDelanteroPateaAMatarPlayera

	^(self chequearSiElRemateFueHaciaUnaEsquina)
			ifTrue: [direccionRemateResultante := direccionRemateResultante x @ 1]
			ifFalse: [direccionRemateResultante := direccionRemateResultante x @ (direccionRemateResultante y + 2)]! !

!Penales methodsFor: 'modificaciones' stamp: 'fb 4/26/2024 12:31:50'!
establecerFuerzaArqueroEligeDireccionContraJabulaniAColocar

	^ fuerzaResultanteArquero := fuerzaResultanteArquero * 1.5! !

!Penales methodsFor: 'modificaciones' stamp: 'fb 4/26/2024 12:45:40'!
establecerFuerzaArqueroEligeDireccionContraPlayeraAColocar

	^ fuerzaResultanteArquero := fuerzaResultanteArquero * 2! !

!Penales methodsFor: 'modificaciones' stamp: 'fb 4/26/2024 12:19:55'!
establecerFuerzaDelanteroPateaAColocar

	^ fuerzaResultanteDelantero := fuerzaResultanteDelantero * 0.5! !

!Penales methodsFor: 'modificaciones' stamp: 'fb 4/26/2024 20:14:55'!
establecerFuerzaDelanteroPateaUnaJabulaniAMatar

	^ fuerzaResultanteDelantero := fuerzaResultanteDelantero * 1.2! !

!Penales methodsFor: 'modificaciones' stamp: 'fb 4/26/2024 12:42:35'!
establecerFuerzaDelanteroPateaUnaPlayeraAColocar

	^ fuerzaResultanteDelantero := fuerzaResultanteDelantero * 0.8! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Penales class' category: #'ISW1-2023-2C-Parcial-1'!
Penales class
	instanceVariableNames: ''!

!Penales class methodsFor: 'message errors' stamp: 'fb 4/26/2024 10:16:11'!
conDelantero: delantero yArquero: arquero

	^ self new initializeWith: delantero andArquero: arquero! !

!Penales class methodsFor: 'message errors' stamp: 'NR 9/19/2023 06:12:49'!
direccionArqueroFueraDeRango
	
	^'El arquero debe lanzarse a coordenadas válidas'! !

!Penales class methodsFor: 'message errors' stamp: 'NR 9/19/2023 06:12:32'!
direccionTiroFueraDeRango
	
	^'La pelota debe dirigirse a coordenadas válidas'! !
