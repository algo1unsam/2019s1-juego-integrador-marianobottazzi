import wollok.game.*
import fichas.*
import niveles.*

object scheduler {

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
	var parDeFichas = []
	var fichasDestapadas = []
	var property position = game.origin()

	method image() = "mano1.png"

	method move(nuevaPosicion) {
		if ((nuevaPosicion.x() >= 0 && nuevaPosicion.x() <= 9) && (nuevaPosicion.y() >= 0 && nuevaPosicion.y() <= 9)) self.position(nuevaPosicion) else game.say(self, "me voy a caer del tablero!")
	}

	method acaNoHayNada() = game.colliders(self).asSet().isEmpty()

	method elementoAca() = game.colliders(self).first()

	method elegir(unaFicha) {
		if (!fichasDestapadas.contains(unaFicha)) {
			unaFicha.destapar()
			parDeFichas.add(unaFicha)
		}
	}

	method taparFichasElegidas() {
		scheduler.schedule(500, { => parDeFichas.forEach({ ficha => ficha.tapar()})})
	}

	method comparacion() = parDeFichas.first().imagen() == parDeFichas.get(1).imagen()

	method todasDestapadas() = fichasDestapadas.size() == nivelJugando.imagenes().size()

	method terminoElNIvel() {
		fichasDestapadas.clear()
		scheduler.schedule(1000, { =>
			game.clear()
		;
			inicio.iniciarNivel(inicio.nivelSiguiente())
		})
	}

	method resultado(unaFicha) {
		if (parDeFichas.size() < 2) self.elegir(unaFicha) else {
			if (self.comparacion()) {
				fichasDestapadas.addAll(parDeFichas)
				parDeFichas.clear()
				if (self.todasDestapadas()) self.terminoElNIvel()
			} else {
				self.taparFichasElegidas()
				parDeFichas.clear()
			}
		}
	}

	method ver() {
		if (self.acaNoHayNada()) game.say(self, "aca no hay nada") else self.resultado(self.elementoAca())
	}

}

