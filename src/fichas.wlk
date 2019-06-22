import wollok.game.*
import player.*
import niveles.*

class Ficha {
	
	const nivel
	var property position = self.asignarPosicion(nivel)
	var property tapada = true
	var imagen = self.asignarImagen(nivel)
 	
	method tapar() {
		tapada = true
	}
	
	method destapar() {
		tapada = false
	}
	
	method asignarImagen(unNivel) {
		var img = unNivel.imagenes().anyOne()
		unNivel.imagenes().remove(img)
		return img
	}
	
	method asignarPosicion(unNivel) {
		var pos = unNivel.posiciones().anyOne()
		unNivel.posiciones().remove(pos)
		return pos
	}
	
	method image() {
		if(tapada) return "tapa.jpg"
		else return imagen
	}
	
}
