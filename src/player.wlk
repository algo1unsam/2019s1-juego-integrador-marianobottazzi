import wollok.game.*
import iconos.*

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

	var cont = 0
	var property imagenesElegidas = []
	var property position = game.at(1, 1)

	method image() = "mano1.png"

	method move(nuevaPosicion) {
		if (nuevaPosicion.x() >= 0 && nuevaPosicion.y() >= 0) self.position(nuevaPosicion) else game.say(self, "me voy a caer del tablero!")
	}

	method acaNoHayNada() = game.colliders(self).asSet().isEmpty()

	method elementoAca() = game.colliders(self).first()

	method ver() {
		if (self.acaNoHayNada()) game.say(self, "aca no hay nada") else {
			self.comprobarEleccion(self.elementoAca())
		}
	}

	method cambiarConDelay(unaImagen, milisegundos) {
		scheduler.schedule(milisegundos, { => unaImagen.cambiarLado()})
	}

	method agregarImagen(unaImagen) {
		imagenesElegidas.add(unaImagen)
	}

	method tamanioLista(unTamanio) = imagenesElegidas.size() == unTamanio

	method coincidencia() = imagenesElegidas.first().imagen2() == imagenesElegidas.get(1).imagen2() // imagenes.all({ img => img.image() })

	method restaurarImagenes() {
		imagenesElegidas.forEach({ img => self.cambiarConDelay(img, 1000)})
		imagenesElegidas.clear()
	}

	method comprobarEleccion(unaImagen) {
		self.agregarImagen(unaImagen)
		unaImagen.cambiarLado()
		if (self.tamanioLista(2)) {
			if (!self.coincidencia()) self.restaurarImagenes() else {
				imagenesElegidas.clear()
				cont++
				self.comprobarFinDeNivel(cont)
			}
		}
	}

	method comprobarFinDeNivel(contador) {
		if (contador == 8) {
			game.say(self, "Terminò el juego !!")
			scheduler.schedule(2000, { => game.clear()})
			nivelUno.iniciarNivel()
		}
	}

}

object tablero {

	var property todasLasImagenes = []

	method repartirImagen() {
		var img = todasLasImagenes.first()
		todasLasImagenes.remove(img)
		return img
	}

}

object ubicacion {

	var property todasLasPosiciones = #{}

	method repartirPosicion() {
		var pos = todasLasPosiciones.anyOne()
		todasLasPosiciones.remove(pos)
		return pos
	}

}

object nivelUno {

	const property imagenes = [ "steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png", "twitter.png", "instagram.png", "steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png", "twitter.png", "instagram.png", "yelp.png", "yelp.png" ]
	const property posiciones = #{ game.at(2, 2), game.at(2, 4), game.at(2, 6), game.at(2, 8), game.at(4, 2), game.at(4, 4), game.at(4, 6), game.at(4, 8), game.at(6, 2), game.at(6, 4), game.at(6, 6), game.at(6, 8), game.at(8, 2), game.at(8, 4), game.at(8, 6), game.at(8, 8) }

	method iniciarNivel() {
		tablero.todasLasImagenes(imagenes)
		ubicacion.todasLasPosiciones(posiciones)
		game.addVisual(player)
		16.times({ i => game.addVisual(new Icono())})
	}

}

