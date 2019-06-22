import wollok.game.*
import player.*
import niveles.*

class Ficha {
	
	const nivel
	var property position = self.asignarPosicion(nivel)
	var property tapado = true
	var imagen = self.asignarImagen(nivel)
 	
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
	
}
