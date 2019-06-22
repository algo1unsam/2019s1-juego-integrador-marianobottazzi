import player.*
import wollok.game.*

class Ficha {
	
	var tapado = true
	var niveles = [nivelDos, nivelTres, nivelUno]
	var nivel = niveles.first()
	var imagen = self.asignarImagen(nivel)
 	
	method cambiar() {
		if(tapado) tapado = !tapado
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
	
	method position() = self.asignarPosicion(nivel)
	
	
}
