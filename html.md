HTML
====

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

## Form

get: With the HTTP "get" method, the form data set is appended to the URI specified by the action attribute (with a question-mark ("?") as separator) and this new URI is sent to the processing agent.
post: With the HTTP "post" method, the form data set is included in the body of the form and sent to the processing agent.

File upload:
```html
<form enctype="multipart/form-data" action="uploader.php" method="post">
<input type="hidden" name="MAX_FILE_SIZE" value="100000" />
Choose a file to upload: <input name="uploadedfile" type="file" /><br />
<input type="submit" value="Upload File" />
</form>
```

Checkbox :
If checked="checked" is specified, then the check box is pre-checked
If 'disabled' is specified then user can't change the state of the check box
If 'readonly' is specified then user can change the visual state of the check box but it doesn't change the internal value
```html
<INPUT type=checkbox name="field_name" checked="checked" disabled>text label
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

