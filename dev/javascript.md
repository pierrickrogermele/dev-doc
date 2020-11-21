<!-- vimvars: b:markdown_embedded_syntax={'javascript':'','html':''} -->
# Javascript

 * [JavaScript and HTML: possibilities and caveats](https://www.cs.tut.fi/~jkorpela/forms/javascript.html).
 * [Using keyboard shortcuts in Javascript](http://www.catswhocode.com/blog/using-keyboard-shortcuts-in-javascript).
 * [Nifty Corners Cube](http://www.html.it/articoli/niftycube/index.html).

## Javascript inside HTML

Write javascript in HTML:
```html
<script>
function myFunc() {
}
</script>
```

## Types

### Strings

Get a sub-string:
```javascript
s.substr(start, length);
```

Get length:
```javascript
s.length;
```

## Operators

	+
	-
	*
	/
	%
	++
	--
	=
	+=
	-=
	*=
	/=
	%=

## function

Declaring a function:
```javascript
function product(a,b) {
	return a*b;
}
```

## Debug

```javascript
alert("hello");
```

```javascript
document.write(Message);
```

## Elements

Get an element property:
```javascript
document.getElementById("menu1").offsetHeight;
```

Possible properties:
	className (nom de classe de feuille de style d'un élément)
	dataFld (champ de données pour la liaison de données)
	dataFormatAs (type de données lors d'une liaison de données)
	dataPageSize (nombre d'enregistrements lors d'une liaison de données)
	dataSrc (source de données lors d'une liaison de données)
	id (nom d'identification d'un élément)
	innerHTML (contenu HTML d'un élément)
	innerText (contenu texte d'un élément)
	isTextEdit (possibilité d'éditer un élément)
	lang (langue d'un élément)
	language (langage Script pour un élément)
	length (nombre d'éléments)
	offsetHeight (hauteur d'un élément)
	offsetLeft (valeur gauche du coin supérieur gauche)
	offsetParent (position de l'élément parent)
	offsetTop (valeur du haut du coin supérieur gauche)
	offsetWidth (largeur d'un élément)
	outerHTML (contenu d'un élément avec contexte HTML)
	outerText (contenu texte d'un élément avec texte)
	parentElement (élément parent)
	parentTextEdit (possibilité d'éditer un élément parent)
	recordNumber (numéro d'enregistrement lors d'une liaison de données)
	sourceIndex (numéro d'ordre d'un élément)
	tagName (repères HTML de l'élément)
	title (titre de l'élément)

Methods:
	click() (cliquer sur l'élément)
	contains() (chaîne de caractères contenue dans l'élément)
	getAttribute() (rechercher l'attribut d'un élément)
	insertAdjacentHTML() (insérer un élément)
	insertAdjacentText() (insérer du texte)
	removeAttribute() (retirer l'attribut de l'élément)
	scrollIntoView() (faire défiler à l'élément)
	setAttribute() (insérer l'attribut d'un élément)

## Packages

###  Node.js

 * [Node.js](http://nodejs.org).

Node.js is a platform built on Chrome's JavaScript runtime for easily building fast, scalable network applications. Node.js uses an event-driven, non-blocking I/O model that makes it lightweight and efficient, perfect for data-intensive real-time applications that run across distributed devices.
