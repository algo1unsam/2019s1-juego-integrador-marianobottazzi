import wollok.game.*
import player.*
import niveles.*

class Ficha {
	
	var nivel
	var property tapado = true
	var imagen = self.asignarImagen(nivel)
 	var posicion = self.asignarPosicion(nivel)
 	
	method tapar() {
		tapado = true
	}
	
	method destapar() {
		tapado = false
	}
	
	method asignarImagen(unNivel) {
		var img = nivel.imagenes().anyOne()
		nivel.imagenes().remove(img)
		return img
	}
	
	method asignarPosicion(unNivel) {
		var pos = nivel.posiciones().anyOne()
		nivel.posiciones().remove(pos)
		return pos
	}
	
	method image() {
		if(tapado) return "tapa.jpg"
		else return imagen
	}
	
	method position() = posicion
	
	
}
