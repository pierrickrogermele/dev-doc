<!-- vimvars: b:markdown_embedded_syntax={'html':''} -->
# HTML
## XHTML

XHTML is an XML version of HTML. Tags must always be closed, tag names must be written in lowercase, etc.

See [HTML and XHTML](https://www.w3schools.com/html/html_xhtml.asp).

Required settings for an XHTML page:
```xml
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
...
</html>
```

## lang attribute

 * [Declaring language in HTML](https://www.w3.org/International/questions/qa-html-language-declarations).

Setting language for the whole page:
```html
<html lang='fr'...>
```

The `lang` attribute can be used in any element. You can declare a different language inside an embedded element.

## Encoding

Set UTF-8 character encoding for this HTML file:
```html
<head>
	<meta charset="UTF-8"/>
</head>
```

## Special characters

Non-breaking space:
```html
My text&nbsp;:
```

## form

 * [HTML Form Elements](https://www.w3schools.com/html/html_form_elements.asp).

get: With the HTTP "get" method, the form data set is appended to the URI specified by the action attribute (with a question-mark ("?") as separator) and this new URI is sent to the processing agent.
post: With the HTTP "post" method, the form data set is included in the body of the form and sent to the processing agent.

Simple form:
```html
<form action="mypage.php" method="post">
	<!-- My input fields ... -->
	<input type="submit" value="Filter"/>
</form>
```

Form with multiple buttons with different actions (destination URL):
```html
<form action="mypage.php" method="post">
	<!-- My input fields ... -->
	<input type="submit" value="Filter"/> <!-- Use default form action -->
	<input type="submit" formaction="mysecondpage.php" value="Download"/>
</form>
```

File upload:
```html
<form enctype="multipart/form-data" action="uploader.php" method="post">
<input type="hidden" name="MAX_FILE_SIZE" value="100000"/>
Choose a file to upload: <input name="uploadedfile" type="file"/><br/>
<input type="submit" value="Upload File"/>
</form>
```

Text field:
```html
<input type="text" id="myfield" name="myfield"/>
```

Checkbox (one or more choices):
```html
<input type="checkbox" id="choice1" name="choice1" value="choice1">
<label for="choice1">Choice 1</label><br>
<input type="checkbox" id="choice2" name="choice2" value="choice2">
<label for="choice2">Choice 2</label><br>
```
An array can also be used:
```html
<input type="checkbox" id="choice1" name="choices[]" value="choice1">
<label for="choice1">Choice 1</label><br>
<input type="checkbox" id="choice2" name="choices[]" value="choice2">
<label for="choice2">Choice 2</label><br>
```
If checked attribute is specified, then the check box is pre-checked:
```html
<input type="checkbox" checked id="choice2" name="choice2" value="choice2">
```
If 'disabled' is specified then user can't change the state of the check box
If 'readonly' is specified then user can change the visual state of the check box but it doesn't change the internal value

Radio buttons (one choice only):
```html
<input type="radio" id="choice1" name="choice" value="choice1">
<label for="choice1">Choice 1</label><br>
<input type="radio" id="choice2" name="choice" value="choice2">
<label for="choice2">Choice 2</label><br>
```

Select (drop-down list):
```html
<select id="mychoice" name="mychoice" size=2 multiple> <!-- `size` sets the number of visible values. `multiple` allows multiple selections. -->
	<option value="choice1">Choice 1</option>
	<option value="choice2">Choice 2</option>
	<option value="choice3" selected>Choice 3</option> <!-- default -->
</select>
```

## onClick

The `onClick` attribute can be used on any HTML element in order to run Javascript code.

Example on a form button:
```html
<form action="mypage.php" enctype="multipart/form-data" method="post">
	<input type="submit" value="Send" onClick="return confirm('Are you sure you want to submit the form?')"/>
</form>
```

## onSubmit

Run javascript code when submitting a form:
```html
<form action="mypage.php" enctype="multipart/form-data" method="post" onSubmit="return myFct()">
```

## Upload file

 * [PHP File Upload](https://www.w3schools.com/php/php_file_upload.asp).

Uploading multiple files:
```html
<input type="file" name="file[]" id="file" multiple/>
```

## List

```html
<ul>
	<li>Blabla</li>
	<li>Blabla</li>
	<li>Blabla</li>
</ul>
```

## Link

Redirection:
```html
<META HTTP-EQUIV="Refresh" CONTENT="5; URL=html-redirect.html">
```

Open link in a new window:
```html
<A href="..." target="_blank">blabla</A> <!-- The user agent should load the designated document in a new, unnamed window. -->
<A href="..." target="_self">blabla</A> <!-- The user agent should load the document in the same frame as the element that refers to this target. -->
<A href="..." target="_parent">blabla</A> <!-- The user agent should load the document into the immediate FRAMESET parent of the current frame. This value is equivalent to _self if the current frame has no parent. -->
<A href="..." target="_top">blabla</A> <!-- The user agent should load the document into the full, original window (thus canceling all other frames). This value is equivalent to _self if the current frame has no parent. -->
```

## Map

```html
<IMG SRC="images/image.gif"
		 WIDTH=150
		 HEIGHT=70
		 USEMAP="#Map">
<MAP NAME="Map">
	<AREA SHAPE="rect"
				HREF="debut.html"
				COORDS="0,0,48,28">
	
	<AREA SHAPE="circle"
				HREF="precedent.html"
				COORDS="50,30,10">
	
	<AREA SHAPE="poly"
				HREF="suivant.html"
				COORDS="60,50,80,30,100,40,50,100">
</MAP>
```

## Page size

```html
<script type="text/javascript">

width = screen.width;
height = screen.height;

if (width > 0 && height >0) {
    window.location.href = "http://localhost/main.php?width=" + width + "&height=" + height;
} else 
    exit();

</script>
```

## Text

Forcing text on one line.
If you are displaying text in a table cell you would do:
```html
<TD nowrap>Long Text Here</TD>.
```
If you are using a div or a span, you can use:
```html
<DIV style="white-space: nowrap;">...</DIV>
```

## Font color

```html
<font color="#FFFF00">Green Bay</font>
```

## Background color

For the whole body:
```html
<body bgcolor="#E6E6FA">
```

For a whole table:
```html
<table bgcolor="#ff0000" border="1">
```

For a table row:
```html
<tr bgcolor="#FFFF00">
```

For a table cell:
```html
<td bgcolor="#009900" align="right">
```

For a paragraph:
```html
<p style = "background-color: yellow">
```

## hr

Display an horizontal line:
```html
<hr/>
```
