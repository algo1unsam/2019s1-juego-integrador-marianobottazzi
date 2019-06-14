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
		self.position(nuevaPosicion)
	}

	method acaNoHayNada() = game.colliders(self).asSet().isEmpty()

	method elementoAca() = game.colliders(self).first()

	method ver() {
		if (self.acaNoHayNada()) 
			game.say(self, "aca no hay nada") 
		else {
			self.comprobarEleccion(self.elementoAca())
			self.comprobarFinDeNivel()
		}
	}
	
	method cambiarConDelay(unaImagen, milisegundos) {
		scheduler.schedule(milisegundos, { => unaImagen.cambiarLado() })
	}
	
	method agregarImagen(unaImagen) { imagenesElegidas.add(unaImagen) }

	method tamanioLista(unTamanio) = imagenesElegidas.size() == unTamanio

	method coincidencia() = imagenesElegidas.first().imagen2() == imagenesElegidas.get(1).imagen2()  // imagenes.all({ img => img.image() })
	
	method restaurarImagenes() { 
		imagenesElegidas.forEach({ img => self.cambiarConDelay(img, 3000) })
		imagenesElegidas.clear()
	}

	method comprobarEleccion(unaImagen) {
		self.agregarImagen(unaImagen)
		unaImagen.cambiarLado()
		if(self.tamanioLista(2)) 
			if(!self.coincidencia())
				self.restaurarImagenes()
			else cont++
	}	
	
	method comprobarFinDeNivel() {
		if(cont == 15) game.say(self, "Gane el juego !!")
	}
}

object tablero {

	const property imagenes = [ "steam.png", "youtube.png", "skype.png", 
		"kickstarter.png", "spotify.png", "twitter.png", "instagram.png", 
		"steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png", 
		"twitter.png", "instagram.png", "yelp.png", "yelp.png" ]
	
	method repartirImagen() { 
		var img = imagenes.first() 
		imagenes.remove(img)
		return img
	}	
}

object posiciones {
	var property todasLasPosiciones = #{ 
		game.at(2, 2), game.at(2, 4), game.at(2, 6), game.at(2, 8), 
		game.at(4, 2), game.at(4, 4), game.at(4, 6), game.at(4, 8), 
		game.at(6, 2), game.at(6, 4), game.at(6, 6), game.at(6, 8), 
		game.at(8, 2), game.at(8, 4), game.at(8, 6), game.at(8, 8) 
	}
	
	method repartirPosicion() {
		var pos = todasLasPosiciones.anyOne() // siempre salen en el mismo orden
		todasLasPosiciones.remove(pos)
		return pos
	}
}