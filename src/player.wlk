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
	
	var property imagenesElegidas = []
	var property position = game.origin()

	method image() = "mano1.png"

	method move(nuevaPosicion) {
		if ((nuevaPosicion.x() >= 0 && nuevaPosicion.x() <= 9) && (nuevaPosicion.y() >= 0 && nuevaPosicion.y() <= 9)) self.position(nuevaPosicion) else game.say(self, "me voy a caer del tablero!")
	}

	method acaNoHayNada() = game.colliders(self).asSet().isEmpty()

	method elementoAca() = game.colliders(self).first()

	method agregarImagen(unaFicha) {
		imagenesElegidas.add(unaFicha)
	}

	method tamanioLista(unTamanio) = imagenesElegidas.size() == unTamanio

	method coincidencia() = imagenesElegidas.first().imagen2() == imagenesElegidas.get(1).imagen2() // imagenes.all({ img => img.image() })

	method taparConDelay(unaFicha, milisegundos) {
		scheduler.schedule(milisegundos, { => unaFicha.tapar()})
	}

	method restaurarImagenes() {
		imagenesElegidas.forEach({ img => self.taparConDelay(img, 1000)})
		imagenesElegidas.clear()
	}

	method comprobarEleccion(unaFicha) {
		self.agregarImagen(unaFicha)
		unaFicha.destapar()
		if (self.tamanioLista(2)) {
			if (!self.coincidencia()) self.restaurarImagenes() else {
				imagenesElegidas.clear()
				if(inicio.todasDestapadas()) { 
					scheduler.schedule(2000, { => 
					game.clear();
					inicio.iniciarNivel(inicio.nivelSiguiente())	
					})
				}
			}
		}
	}

	method ver() {
		if (self.acaNoHayNada()) game.say(self, "aca no hay nada") else {
			self.comprobarEleccion(self.elementoAca())
		}
	}

}
