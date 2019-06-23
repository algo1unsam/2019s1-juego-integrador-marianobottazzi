import wollok.game.*
import player.*
import fichas.*


object nivelUno {

	const property imagenes = [ "steam.png", "youtube.png", "skype.png", "kickstarter.png", "steam.png", "youtube.png", "skype.png", "kickstarter.png" ]
	const property posiciones = #{ game.at(2, 2), game.at(2, 4), game.at(4, 2), game.at(4, 4), game.at(6, 4), game.at(6, 6), game.at(8, 4), game.at(8, 6) }

}

object nivelDos {

	const property imagenes = [ "steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png", "steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png" ]
	const property posiciones = #{ game.at(2, 2), game.at(2, 4), game.at(2, 6), game.at(2, 8), game.at(4, 4), game.at(4, 6), game.at(4, 8), game.at(6, 6), game.at(6, 8), game.at(8, 8) }

}

object nivelTres {

	const property imagenes = [ "steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png", "twitter.png", "instagram.png", "steam.png", "youtube.png", "skype.png", "kickstarter.png", "spotify.png", "twitter.png", "instagram.png", "yelp.png", "yelp.png" ]
	const property posiciones = #{ game.at(2, 2), game.at(2, 4), game.at(2, 6), game.at(2, 8), game.at(4, 2), game.at(4, 4), game.at(4, 6), game.at(4, 8), game.at(6, 2), game.at(6, 4), game.at(6, 6), game.at(6, 8), game.at(8, 2), game.at(8, 4), game.at(8, 6), game.at(8, 8) }

}

object inicio {

	var niveles = [nivelDos, nivelTres, nivelUno]
	
	method nivelSiguiente() {
		if(niveles.asSet().isEmpty()) niveles.addAll([nivelDos, nivelTres, nivelUno])
		var niv = niveles.first()
		niveles.remove(niv)
		return niv
	}

	method iniciarNivel(unNivel) {
		game.addVisual(player)
		keyboard.up().onPressDo{ player.move(player.position().up(1));}
		keyboard.down().onPressDo{ player.move(player.position().down(1));}
		keyboard.left().onPressDo{ player.move(player.position().left(1));}
		keyboard.right().onPressDo{ player.move(player.position().right(1));}
		keyboard.space().onPressDo{ player.ver()}
		player.nivel(unNivel)
		unNivel.imagenes().size().times({ i => 
			var ficha = new Ficha()
			ficha.position(ficha.asignarPosicion(unNivel))
			ficha.imagen(ficha.asignarImagen(unNivel))
			game.addVisual (ficha)
		})
	}

}

