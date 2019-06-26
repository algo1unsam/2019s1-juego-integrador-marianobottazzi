import wollok.game.*
import fichas.*
import niveles.*

object scheduler { // no esta funcionando bien

	var count = 0

	method schedule(milliseconds, action) {
		count += 1
		const name = "scheduler" + count
		game.onTick(milliseconds, name, { =>
			action.apply()
			game.removeTickEvent(name)
		})
	}

}

object player {

	var property nivelJugando = null
	var property tamanioNivel = null
	var property parDeFichas = []
	var property fichasDestapadas = []
	var property position = game.origin()

	method image() = "mano1.png"

	method move(nuevaPosicion) {
		if ((nuevaPosicion.x() >= 0 && nuevaPosicion.x() <= 9) && (nuevaPosicion.y() >= 0 && nuevaPosicion.y() <= 9)) self.position(nuevaPosicion) else game.say(self, "me voy a caer del tablero!")
	}

	method acaNoHayNada() = game.colliders(self).asSet().isEmpty()

	method elementoAca() = game.colliders(self).first()

	method elegir(unaFicha) {
		if (fichasDestapadas.asSet().isEmpty()) {
			unaFicha.destapar()
			parDeFichas.add(unaFicha)
		} else if (!fichasDestapadas.contains(unaFicha)) {
			unaFicha.destapar()
			parDeFichas.add(unaFicha)
		}
	}

	method taparFichasElegidas() {
		scheduler.schedule(500, { => 
			parDeFichas.forEach({ ficha => ficha.tapar()})
			parDeFichas.clear()
		})
	}

	method sonIguales() = parDeFichas.first().imagen() == parDeFichas.get(1).imagen() && parDeFichas.first().position() != parDeFichas.get(1).position()
	
	method nivelCompleto() = fichasDestapadas.size() == tamanioNivel
	
	method terminoElNIvel() {
		fichasDestapadas.clear()
		if(nivelJugando == nivelTres) {
			game.clear()
			game.addVisual(self)
			game.say(self, "GANASTE EL JUEGO!! ")
		}
		else {
		game.say(self, "NIVEL TERMINADO !!")
		scheduler.schedule(1000, { =>
			game.clear()
			inicio.iniciarNivel(inicio.nivelSiguiente())
		})
		}
	}

	method resultado(unaFicha) {
		self.elegir(unaFicha)
		if (parDeFichas.size() == 2) {
			if (self.sonIguales()) {
				fichasDestapadas.addAll(parDeFichas)
				parDeFichas.clear()
				if (self.nivelCompleto()) self.terminoElNIvel()
			} else 
				self.taparFichasElegidas()
		}
	}

	method ver() {
		if (self.acaNoHayNada()) game.say(self, "aca no hay nada") 
		else 
			self.resultado(self.elementoAca())
	}

}

