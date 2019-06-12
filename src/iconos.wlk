import wollok.game.*
import player.*

class Icono {

	var property position = posiciones.repartirPosicion()
	var property imagen1 = "tapa.jpg"
	var property imagen2 = tablero.repartirImagen()
	var property imagenParaMostrar = imagen1
	
	method image() = imagenParaMostrar

	method cambiarLado() {
		if (imagenParaMostrar == imagen1) 
			imagenParaMostrar = imagen2
		else 
			imagenParaMostrar = imagen1
	} 
}

