import wollok.game.*
import player.*
import niveles.*

class Ficha {
	
	var property position = null
	var property imagen = null
 	var property tapada = true
 	
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
