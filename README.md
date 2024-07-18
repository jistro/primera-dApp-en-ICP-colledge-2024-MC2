# Que es motoko
Motoko es un lenguaje de programación moderno y seguro diseñado específicamente para desarrollar aplicaciones distribuidas en la red blockchain de Internet Computer. Fue creado por el equipo de Motoko en la Fundación DFINITY, liderado por Andreas Rossberg, co-creador de WebAssembly.

# Actor
Un actor en Internet Computer y Motoko es como una caja especial que:

1. Guarda información privada.
2. Puede recibir mensajes y hacer cosas con ellos.
3. Trabaja de forma independiente y segura.
4. Siempre recibe mensajes de forma asincrónica.

Los actores son útiles porque:

- Evitan problemas comunes en programas que hacen muchas cosas a la vez.
- Manejan los mensajes uno por uno, en orden.
- No se bloquean mientras trabajan.

Mensajes asincrónicos significa que:
- Cuando envías un mensaje a un actor, no esperas una respuesta inmediata.
- El actor procesa el mensaje cuando puede, no necesariamente al instante.
- Esto permite que el programa siga funcionando sin detenerse a esperar respuestas.

En Internet Computer, cada "canister" (una unidad de software) es un actor.

Un ejemplo simple en Motoko:

```
actor Counter {  
  var valor = 0;
  public func aumentar() : async Nat {
    valor += 1;
    return valor;
  };
}
```

Este actor `Counter` guarda un número y tiene una función para aumentarlo y mostrarlo.

# Variables

## Declaracion de variables

En Motoko existen 3 tipos de variables


1. `let`: Para valores que no cambian (inmmutables):

```motoko
let x : Nat = 0;
```
Aquí, `x` siempre será `0`. No se puede cambiar después.

2. `let-else`: Para manejar posibles errores:

```motoko
let ?x = foo() else { Debug.print "foo failed"; return };
```
Si `foo()` falla, imprime "foo failed" y sale. Si no, continúa con `x` como el valor que devolvió `foo()`.

3. `var`: Para valores que pueden cambiar:

```motoko
var x : Nat = 0;
```
`x` empieza como 0, pero puedes cambiarlo después.

## Sintaxis de Expresiones:

Esta sintaxis proporciona una visión completa de cómo se pueden construir expresiones, patrones y tipos en Motoko.

```motoko
<exp> ::=                                      Expresiones
```
Esta línea indica que estamos definiendo los diferentes tipos de expresiones en Motoko.

Algunas expresiones importantes:

```motoko
  <id>                                           Variable
  <lit>                                          Literal
  <unop> <exp>                                   Operador unario
  <exp> <binop> <exp>                            Operador binario
  <exp> <relop> <exp>                            Operador relacional binario
```
Estas son expresiones básicas como variables, literales y operaciones.

```motoko
  ( <exp>,* )                                    Tupla
  { <exp-field>;* }                              Objeto
  [ var? <exp>,* ]                               Array
```
Definen estructuras de datos como tuplas, objetos y arrays.

```motoko
  <shared-pat>? func <func_exp>                  Expresión de función
  <exp> <typ-args>? <exp>                        Llamada a función
```
Definen y llaman a funciones.

```motoko
  if <exp> <block-or-exp> (else <block-or-exp>)? Condicional
  switch <exp> { (case <pat> <block-or-exp>;)+ } Switch
  while <exp> <block-or-exp>                     Bucle while
  for ( <pat> in <exp> ) <block-or-exp>          Iteración
```
Estructuras de control como condicionales y bucles.

```motoko
  async <block-or-exp>                           Expresión asíncrona
  await <block-or-exp>                           Esperar futuro (solo en async)
  throw <exp>                                    Lanzar un error (solo en async)
  try <block-or-exp> catch <pat> <block-or-exp>  Capturar un error (solo en async)
```
Operaciones asíncronas y manejo de errores.

2. Sintaxis de Patrones:

```motoko
<pat> ::=                                      Patrones
```
Define los diferentes tipos de patrones que se pueden usar en Motoko.

Algunos patrones importantes:

```motoko
  _                                              Comodín
  <id>                                           Variable
  <unop>? <lit>                                  Literal
  ( <pat>,* )                                    Tupla o paréntesis
  { <pat-field>;* }                              Patrón de objeto
  # <id> <pat>?                                  Patrón de variante
```
Estos patrones se usan en coincidencia de patrones, por ejemplo en declaraciones `switch` o `case`.

3. Sintaxis de Tipos:

```motoko
<typ> ::=                                     Expresiones de tipo
```
Define los diferentes tipos de expresiones de tipo en Motoko.

Algunos tipos importantes:

```motoko
  <path> <type-typ-args>?                       Constructor
  <sort>? { <typ-field>;* }                     Objeto
  [ var? <typ> ]                                Array
  ? <typ>                                       Opción
  <shared>? <typ-params>? <typ> -> <typ>        Función
  async <typ>                                   Futuro
```
Estos definen varios tipos de datos y estructuras en Motoko.

```motoko
<sort> ::= (actor | module | object)
```
Define los posibles tipos de "sort" para objetos.

```motoko
<shared> ::=                                 Calificador de tipo de función compartida
  shared <query>?
```
Define funciones compartidas, que pueden ser opcionalmente de consulta.

### Ejemplos


1. Ejemplos de Expresiones:

```motoko
// Variable
let x = 5;

// Literal
let str = "Hola, mundo!";

// Operador unario
let negativo = -10;

// Operador binario
let suma = 5 + 3;

// Operador relacional
let esIgual = (5 == 5);

// Tupla
let coordenadas = (10, 20);

// Objeto
let persona = { nombre = "Alice"; edad = 30 };

// Array
let numeros = [1, 2, 3, 4, 5];

// Función
let suma = func(a : Nat, b : Nat) : Nat { a + b };

// Llamada a función
let resultado = suma(5, 3);

// Condicional
if (x > 0) { "Positivo" } else { "No positivo" };

// Switch
switch (fruta) {
  case ("manzana") { "Es roja" };
  case ("plátano") { "Es amarillo" };
  case (_) { "No sé qué color es" };
};

// Bucle while
var i = 0;
while (i < 5) {
  Debug.print(Int.toText(i));
  i += 1;
};

// Iteración (for)
for (num in [1, 2, 3].vals()) {
  Debug.print(Int.toText(num));
};

// Async/Await
let futuro = async {
  await someAsyncFunction();
  "Completado"
};
```

2. Ejemplos de Patrones:

```motoko
// Comodín
case (_) { "Cualquier valor" };

// Variable
case (x) { Debug.print("El valor es: " # debug_show x) };

// Literal
case (0) { "Cero" };

// Tupla
case ((x, y)) { "Coordenadas: " # Int.toText(x) # ", " # Int.toText(y) };

// Objeto
case ({ nombre; edad }) { nombre # " tiene " # Int.toText(edad) # " años" };

// Variante
type Fruta = {#Manzana; #Platano; #Naranja};
case (#Manzana) { "Es una manzana" };

// Patrón OR
case (0 or 1) { "Cero o uno" };
```

3. Ejemplos de Tipos:

```motoko
// Tipo básico (constructor)
let edad : Nat = 30;

// Objeto
type Persona = {
  nombre : Text;
  edad : Nat;
};

// Variante
type Resultado = {
  #Ok : Nat;
  #Err : Text;
};

// Array
let numeros : [Nat] = [1, 2, 3, 4, 5];

// Array mutable
let numerosMutables : [var Nat] = [var 1, 2, 3, 4, 5];

// Null
let valorNulo : Null = null;

// Opcional
let quizasNumero : ?Nat = ?5;

// Función
let suma : (Nat, Nat) -> Nat = func(a, b) { a + b };

// Función compartida
shared func obtenerContador() : async Nat { /* ... */ };

// Futuro
let resultadoFuturo : async Nat = async { /* ... */ };

// Tupla
let punto : (Nat, Nat) = (10, 20);

// Intersección
type A = { x : Nat };
type B = { y : Nat };
type C = A and B;  // Tipo que tiene tanto x como y

// Unión
type NumeroOTexto = Nat or Text;
```


## Primitivas basicas

### Type `Text`

Representa secuencias de caracteres unicode (strings).
- t.size: devuelve el número de caracteres.
- Operaciones: concatenación (#) e iteración sobre caracteres.


### Type `Float`

Representa números de punto flotante de 64 bits.
- Sigue el estándar IEEE 754-2019.
- Funciones comunes en la biblioteca "base/Float".


### Types `Int` y `Nat`

Int: números enteros con signo.
Nat: números naturales (enteros no negativos).
- Precisión arbitraria.
- Nat es subtipo de Int (Nat <: Int).


### Enteros acotados `Int8`, `Int16`, `Int32` y `Int64`

Representan enteros con signo de 8, 16, 32 y 64 bits.
- Operaciones que pueden causar desbordamiento dan error.
- Operaciones con '%' (ej: +%) usan aritmética modular.
- Soportan operaciones a nivel de bits (&, |, ^, <<, >>).


### Naturales acotados `Nat8`, `Nat16`, `Nat32` y `Nat64`

Representan enteros sin signo de 8, 16, 32 y 64 bits.
- Similares a los Int acotados, pero sin signo.
- Operaciones que pueden causar desbordamiento dan error.
- Operaciones con '%' usan aritmética modular.
- Soportan operaciones a nivel de bits.

# Mas recursos

Para ver las librerias que se pueden usar en Motoko, se puede visitar la documentacion oficial en el siguiente [enlace](https://internetcomputer.org/docs/current/motoko/main/base/)

Si se desea ver referencias del leguaje, se puede visitar el siguiente [enlace](https://internetcomputer.org/docs/current/motoko/main/reference/language-manual)
