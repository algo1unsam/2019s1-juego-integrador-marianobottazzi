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

object tablero {

	var property todasLasImagenes = []

	method repartirImagen() {
		var img = todasLasImagenes.anyOne()
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

object player {

	var cont = 0
	var property nivel = null
	var property imagenesElegidas = []
	var property position = game.origin()

	method image() = "mano1.png"

	method move(nuevaPosicion) {
		if ((nuevaPosicion.x() >= 0 && nuevaPosicion.x() <= 9) && (nuevaPosicion.y() >= 0 && nuevaPosicion.y() <= 9)) self.position(nuevaPosicion) else game.say(self, "me voy a caer del tablero!")
	}

	method acaNoHayNada() = game.colliders(self).asSet().isEmpty()

	method elementoAca() = game.colliders(self).first()

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
				nivel.comprobarFinDeNivel(cont)
			}
		}
	}
	
	method ver() {
		if (self.acaNoHayNada()) game.say(self, "aca no hay nada") else {
			self.comprobarEleccion(self.elementoAca())
		}
	}

}

object nivelUno {

	const property imagenes = [ "steam.png", "youtube.png", "skype.png", "kickstarter.png", "steam.png", "youtube.png", "skype.png", "kickstarter.png" ]
	const property posiciones = #{ game.at(2, 2), game.at(2, 4), game.at(4, 2), game.at(4, 4), game.at(6, 2), game.at(6, 4), game.at(8, 2), game.at(8, 4) }

	method comprobarFinDeNivel(contador) {
		console.println(contador)
		if (contador == imagenes.size() / 2) {
			game.say(player, "Terminò el nivel !!")
			scheduler.schedule(2000, { =>
				game.clear()
				inicio.iniciarNivel(nivelDos.imagenes(), nivelDos.posiciones())
			})
		}
	}

}

object nivelDos {

	const property imagenes = [ "steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png", "steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png" ]
	const property posiciones = #{ game.at(2, 2), game.at(2, 4), game.at(2, 6), game.at(2, 8), game.at(4, 4), game.at(4, 6), game.at(4, 8), game.at(6, 6), game.at(6, 8), game.at(8, 8) }

	method comprobarFinDeNivel(contador) {
		if (contador == imagenes.size() / 2) {
			game.say(self, "Terminò el nivel !!")
			scheduler.schedule(2000, { =>
				game.clear()
				inicio.iniciarNivel(nivelTres.imagenes(), nivelTres.posiciones())
			})
		}
	}

}

object nivelTres {

	const property imagenes = [ "steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png", "twitter.png", "instagram.png", "steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png", "twitter.png", "instagram.png", "yelp.png", "yelp.png" ]
	const property posiciones = #{ game.at(2, 2), game.at(2, 4), game.at(2, 6), game.at(2, 8), game.at(4, 2), game.at(4, 4), game.at(4, 6), game.at(4, 8), game.at(6, 2), game.at(6, 4), game.at(6, 6), game.at(6, 8), game.at(8, 2), game.at(8, 4), game.at(8, 6), game.at(8, 8) }

	method comprobarFinDeNivel(contador) {
		if (contador == imagenes.size() / 2) {
			game.say(self, "Terminò el juego !!")
			scheduler.schedule(2000, { =>
				game.clear()
				inicio.iniciarNivel(nivelUno.imagenes(), nivelUno.posiciones())
			})
		}
	}

}

object inicio {

	var property niveles = [ nivelUno, nivelDos, nivelTres ]

	method nivelActual() {
		if (niveles.asSet().isEmpty()) niveles.addAll([ nivelUno, nivelDos, nivelTres ])
		var nivel = niveles.first()
		niveles.remove(nivel)
		return nivel
	}

	method iniciarNivel(imagenes, posiciones) {
		player.nivel(self.nivelActual())
		tablero.todasLasImagenes().addAll(imagenes)
		ubicacion.todasLasPosiciones().addAll(posiciones)
		game.addVisual(player)
		keyboard.up().onPressDo{ player.move(player.position().up(1));}
		keyboard.down().onPressDo{ player.move(player.position().down(1));}
		keyboard.left().onPressDo{ player.move(player.position().left(1));}
		keyboard.right().onPressDo{ player.move(player.position().right(1));}
		keyboard.space().onPressDo{ player.ver()}
		imagenes.size().times({ i => game.addVisual(new Icono())})
	}

}

