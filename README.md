**Mario Bross Game**

*Ejemplo completo y simple de las funcionalidades de Wollok Game*

.

**Forma de uso**

-Mover a Mario con las flechas del teclado y pasar por encima de las monedas para juntarlas 
-Presionar <Espacio> para saltar
-Presionar <Enter> para ver cuantas monedas juntó
-Presionar <x> para salir

.

**El problema básico**

Mario se dedica a juntar monedas. Cuando agarra una acumula su valor y cuando se le pregunta por las monedas, dice cuanto acumuló.

Monedas puede haber muchas, los valores posibles son $1, $5 y $10.

- Implementar a mario y las monedas.
- Hacer un test en el que junte una moneda de cada valor, y verificar que siga funcionando a medida que se agregan funcionalidades visuales.

.

**Mario**
  
*addVisual(visual), image(), position(), start()*

- Crear un objeto que represente el juego y definir los métodos indispensables para que mario pueda ser visualizado en la pantalla. Que se le pueda pedir que cambie su posición desde la consola.

.

**Mario interactivo**

*addVisualCharacter(visual), position(position)*

- Modificar la solución para que se ejecute desde un programa (*.wprg) y que mario se mueva a partir del teclado, mediante las flechas.

.

**Las monedas**

*onTick(tiempo,nombre,accion), width(), heigth()* 

- Hacer que con intervalo de un segundo, se genere una nueva moneda y aparezca en la pantalla. Que sus posiciones y valores sean aleatorios. Contemplar que las monedas de diferente valor tengan distinto aspecto visual.

.

**Agarrar las monedas**

*onCollideDo(visual,accion), removeVisual(visual)*

- Representar que cuando Mario se encuentra con una moneda, la agarra, acumulando su valor, y la moneda desaparece de la pantalla.

.

**Saltos**

*onPressDo(acccion), schedule(tiempo, accion)*
- Permitir interactuar con el teclado, de manera que al presionar una tecla, Mario salte una par de casillas y enseguida vuelva a caer()

.

**El tablero de juego**

*heigth(celdas), width(celdas), title(descripcion), say(visual,leyenda), stop()*

- Ampliar el tamaño de la pantalla, agregar una imagen de fondo, colocar un nombre al juego. 
- Hacer que cuando se presiona una tecla, Mario informe cuánto tiene de monedas.
- Agregar una tecla para terminar el juego.

.

**Posibles ampliaciones**

- Lograr que en todo el recorrido del salto Mario pueda agarrar monedas
- Que la imagen de Mario cambie según la dirección en que se desplaza
- Hacer que Mario se agache
- Que mario pueda agarrar hongos (o trate de esquivar) u otros elementos del tablero y que sucedan diferentes cosas en consecuencia. 
- Determinar alguna condición para que el juego termine, ya sea que se gane o se pierda.
- Agregar niveles, posibilidad de reiniciar.

.

**Implementación**

~~~Wollok
import wollok.game.*

object juego {
	
	method iniciar() {
		game.height(10)
		game.width(15)
		game.title("Mario PdeP")
		game.boardGround("FondoMario.jpg")
		game.addVisualCharacter(mario)
		
		keyboard.space().onPressDo{mario.saltar()}
		keyboard.enter().onPressDo{game.say(mario, "tengo " + mario.monedas().toString() + " monedas!!!")}
		keyboard.x().onPressDo{game.stop()}
		
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

class Moneda {
	var property position = game.center()
	var property valor
	
	method image() = "moneda" + valor.toString() + ".png"
} 
~~~