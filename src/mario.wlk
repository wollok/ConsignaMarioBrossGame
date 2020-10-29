import wollok.game.*

object mario {
	var position = game.origin()
	var monedas = 0
	
	method agarrar(moneda) {
		monedas += moneda.valor()
		game.removeVisual(moneda)
	}
	
	method monedas() = monedas
		
	method saltar(){
		self.subir()
		game.schedule(500, {self.caer()})
	}
	
	method subir(){
		position = position.up(2)
	}

	method caer(){
		position = position.down(2)
	}
	
	method position() {
		return position
	}
	
	method position(nueva){
		position = nueva
	}
	
	method image() = "marioBross.png"
}


object juego {
	
	method iniciar() {
		game.height(10)
		game.width(15)
		game.title("Mario PdeP")
		game.boardGround("FondoMario.jpg")
		game.addVisualCharacter(mario)
		
		keyboard.space().onPressDo{mario.saltar()}
		keyboard.enter().onPressDo{game.say(mario, "tengo " + mario.monedas().toString() + " monedas!!!")}
//		keyboard.x().onPressDo{game.stop()}
		
		game.onTick(1000, "aparece moneda",{self.aparecerMoneda()})
		game.onCollideDo(mario,{moneda => mario.agarrar(moneda)} )
		game.start()
	}
	
	method aparecerMoneda() {
		const x = (0..game.width()-1).anyOne()
		const y = (0..game.height()-1).anyOne()
		game.addVisual( 
			new Moneda(
				valor = [1,5,10].anyOne(),
				position = game.at(x,y)
			)
		)
	}
}

class Moneda {
	var property position = game.center()
	var property valor
	
	method image() = "moneda" + valor.toString() + ".png"
} 