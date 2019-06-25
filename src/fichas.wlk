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
	
	method image() {
		if(tapada) return "tapa.jpg"
		else return imagen
	}
	
}
