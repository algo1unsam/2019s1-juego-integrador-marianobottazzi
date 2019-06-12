import wollok.game.*
import iconos.*

object player {

	var property imagenesCambiadas = []
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
			self.elementoAca().cambiarLado()
			self.agregarDelay()
			self.removeDelay()			
			self.elementoAca().cambiarLado()
		}
	}
	
	method agregarImagen(unaImagen) { imagenesCambiadas.add(unaImagen) }

	method comprobarConcidencia() = imagenesCambiadas.all({ img => img.image() })
	
	method restaurarImagenes() {
		imagenesCambiadas.first().cambiarLado()
		imagenesCambiadas.get(1).cambiarLado()
		imagenesCambiadas.clear()
	}
	
	method agregarDelay() {
		game.onTick(2000, "delay", { => self.elementoAca().cambiarLado() })
		game.onTick(3500, "remove", { => self.removeDelay()})
	}
	
	method removeDelay(){
		console.println("remuevo delay onTick")
		game.removeTickEvent("delay")
		game.removeTickEvent("remove")
	}
}

object tablero {

	const property imagenes = [ "steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png", "twitter.png", "instagram.png", "steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png", "twitter.png", "instagram.png", "yelp.png", "yelp.png" ]
	
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
		var pos = todasLasPosiciones.anyOne()
//		var pos = todasLasPosiciones.get(0.randomUpTo(15).roundUp(0))
		todasLasPosiciones.remove(pos)
		return pos
	}
}