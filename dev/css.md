CSS
===

 * [CSS Reference](http://www.w3schools.com/cssref/).
 * [Secure Login System with PHP and MySQL](https://codeshack.io/secure-login-system-php-mysql/), good example of using styles for navigation bar and form.

 * [CSS declarations](https://developer.mozilla.org/en-US/docs/Web/CSS/Syntax).

## Rulesets

  * [Cascade and inheritance](https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Cascade_and_inheritance).

A CSS file is made of rulesets (aka rules).
A rule is composed of a selector group and a declarations block delimited by curly braces.
```css
some_selector {
	/* the declarations block */
}
```

The selector group is made of one or more coma-separated selectors.

Attention ! If a selector group uses one unknown pseudo-element or pseudo-class, then the whole ruleset is invalid and thus ignore.

An element of a page may be matched by more than one selectors. In this case the cascade algorithm is used to which order the rulesets are applied.

## Selectors

  * [CSS selectors](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors).

There are no selectors or combinators to select parent items, siblings of parents, or children of parent siblings.

```css
* {} /* All elements. */
ns|* {} /* All elements of namespace ns. */
*|* {} /* All elements of all namespaces. */
elementname {} /* All elements elementname. */
.classname {} /* All elements of class classname. */
#idname {} /* The element with id attribute set to idname.
			  There should be only one such element in a document. */
[attr] {} /* All elements which have the attribute attr set.*/
[attr=value] {} /* All elements which have the attribute attr set to value value. */
[attr=~value] {}
[attr|=value] {}
[attr^=value] {}
[attr$=value] {}
[attr*=value] {}
```

Grouping selectors is done with coma as separator:
```css
selector1, selector2 {}
```

Combinators:
```css
A B {} /* B elements that are descendant of A (B elements inside A). */
A > B {} /* B elements that are direct children of A (B elements directly under A). */
A ~ B {} /* B is a sibling of A (same parent) and A appears first. */
A + B {} /* B is a sibling of A (same parent) and B follows directly A (adjacent). */
A || B {} /* B elements that belong to the scope of A (e.g.: col || td --> all <td> elements that belong to <col>). */
```

Pseudo classes `:`:
```css
a:visited {} /* All <a>  elements that have been visited. */
```
See [Pseudo-classes](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-classes#Specifications).

Pseudo elements `::`:
```css
p::first-line {} /* First line of all <p> elements. */
```
See [Pseudo-elements](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-elements#Specifications).

## Using CSS inside HTML

Making reference to a CSS file:
```html
<html>
	<head>
	<title> LC/MS matching results </title>
	<link rel=stylesheet href="R2HTML.css" type=text/css>
	</head>
```

Browser may cache the CSS file. This means that when developing, changes inside the CSS file will not be visible.
To force browser to reload the CSS file, append `?v=1` at the end of the CSS filename, increasing the number as you need:
```html
<link rel=stylesheet href="R2HTML.css?v=1" type=text/css>
```

Embedding CSS inside HTML file:
```html
<html>
	<head>
		<style>
			body {background-color:lightgray}
			h1   {color:blue}
			p    {color:green}
		</style>
	</head>
```

## Box

```css
IMG { margin-left: 50% }
```

Border:
```css
DIV { border-width:2px; border-color:#000; border-style:solid; }
```

## Classes

Defining a class:
```css
P.my_class { /*...*/ }
```

Using a class:
```html
<p class="my_class">...</p>
```
Multiple classes can be set for an element:
```html
<p class="class1 class2 class3">...</p>
```

Pseudo classes:
CSS pseudo-classes are used to add special effects to some selectors.
```css
BODY:my_pseudo_class { /*...*/ }
BODY.my_class:my_pseudo_class { /*...*/ }
```

Anchor pseudo classes (for 'A' tag): link, visited, hover, active.
The `:first-child` pseudo-class matches a specified element that is the first child of another element.
The `:lang` pseudo-class allows you to define special rules for different languages.

## Variables

 * [Using CSS custom properties (variables)](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties).
 * [CSS Variables](https://www.w3schools.com/css/css3_variables.asp).

## Color

```css
Setting text color or background color:
BODY { background:#01366b ; color:white }
```

 * [CSS Color Names](http://www.w3schools.com/cssref/css_colornames.asp).

## Image

To have image scaled automatically:
```css
IMG { width:100% }
```

Center an image:
```css
IMG { display:block ; margin:auto }
```

Wrap text around an image:
```css
IMG.floatLeft { float: left; margin: 4px; }
IMG.floatRight { float: right; margin: 4px; }
```
`float`: left | right | none.

Controls if floating elements are allowed or not around an element:
```css
IMG { clear: none }
P { clear: none }
```
`clear`: left | right | both | none.

## Import

```css
@import "general.css";
```

## Comment

```css
/* My C style comment. */
```

## Links

Order of declaration is important: link, visited, active, hover:
```css
<style type="text/css">
A:link {text-decoration: none}
A:visited {text-decoration: none}
A:active {text-decoration: none}
A:hover {text-decoration: underline; color: red;}
</style>
```

## List

list style:
```css
ul.circle {list-style-type:circle}
ul.square {list-style-type:square}
ol.upper-roman {list-style-type:upper-roman}
ol.lower-alpha {list-style-type:lower-alpha}
```

Style                   | Description
----------------------- | -----------
`none`                  | No marker.
`circle`                | The marker is a circle.
`disc`                  | The marker is a filled circle. This is default.
`square`                | The marker is a square.
`armenian`              | The marker is traditional Armenian numbering.
`decimal`               | The marker is a number.
`decimal-leading-zero`  | The marker is a number padded by initial zeros (01, 02, 03, etc.).
`georgian`              | The marker is traditional Georgian numbering (an, ban, gan, etc.).
`lower-alpha`           | The marker is lower-alpha (a, b, c, d, e, etc.).
`lower-greek`           | The marker is lower-greek (alpha, beta, gamma, etc.).
`lower-latin`           | The marker is lower-latin (a, b, c, d, e, etc.).
`lower-roman`           | The marker is lower-roman (i, ii, iii, iv, v, etc.).
`upper-alpha`           | The marker is upper-alpha (A, B, C, D, E, etc.) .
`upper-latin`           | The marker is upper-latin (A, B, C, D, E, etc.).
`upper-roman`           | The marker is upper-roman (I, II, III, IV, V, etc.).
`inherit`               | Specifies that the value of the list-style-type property should be inherited from the parent element.

## Mouse

Change color when mouse over:
```css
<style type="text/css">
td.menuon { background-color: #000000; color: #FFFFFF; }
td.menuoff { background-color: #FFFFFF; color: #000000; }
</style>
<td class="menuoff" onmouseover="className='menuon';" onmouseout="className='menuoff';">
</td>
```

set cursor form:
```css
TD { cursor:hand }
```
`cursor`: hand, pointer.

## Position

position values | Description
--------------- | ------------------------------------
`Static`        | Positonnement habituel de l'élément, c'est à dire en fonction de son ordre d'arrivée. C'est la valeur par défaut.
`Absolute`      | L'élément est positionné par rapport aux bords de la page. Il défile avec la page.
`Fixed`         | L'élément est positionné par rapport aux bords de la page mais ne défile pas avec la page. Cette possibilité est encore peu reconnue par les navigateurs.
`Relative`      | L'élément est positionné par rapport à l'élément précédent.
`Inherit`       | Même valeur que celle de l'élément parent.

## Table

To center a table in the page:
```css
TABLE { margin-left:auto; margin-right:auto }
```

Background color:
```css
TABLE { background-color:red }
```

Cell spacing:
```css
TABLE { border-spacing:10 }
TABLE { border-collapse:collapse } /* to put no space between cells */
```

Coloring the header row:
```css
th { background-color: LightBlue; }
```

Coloring a specific row (header counts for index 1, if present):
```css
tr:nth-child(10) { background-color: LightGreen; }
```

Coloring alternatively background of rows:
```css
tr:nth-child(even) { background-color: LemonChiffon; }
tr:nth-child(odd) { background-color: LightGreen; }
```
Or using a formula:
```css
tr:nth-child(3n+0) { background-color: LemonChiffon; }
```


## Text

Alignment:
```css
H1 { text-align: center }
P { vertical-align:top; }
```
`text-align`: left | right | center | justify.
`vertical-align`: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>.

Line:
```css
P { line-height: 400% }
```

Indent first line of text:
```css
P { text-indent:3% }
```

Underline:
```css
P { text-decoration:underline }
```

Text on one line:
```css
P.my_class { white-space:nowrap }
```

## Font

`[ <font-style> || <font-variant> || <font-weight> ]? <font-size> [ / <line-height> ]? <font-family>`
The font-size and the font-family are compulsory.
```css
P { font: 10pt Arial } /* minimum to declare: size + font */
P { font: 10pt 'Lucida Sans Unicode' } /* put apostrophes when font name contains spaces */
P { font: italic bold 12pt/14pt Times, serif }
P { font-style: italic }
```

`text-decoration`: none | underline | overline | line-through | blink.

The fonts that are most safe to use are:
Arial / Helvetica
Times New Roman / Times
Courier New / Courier

Other options that usually work cross-platform are:
Palatino
Garamond
Bookman
Avant Garde

Fonts that work on Windows and MacOS but not Unix+X are:
Verdana
Georgia
Comic Sans MS
Trebuchet MS
Arial Black
Impact
