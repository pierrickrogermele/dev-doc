<!-- vimvars: b:markdown_embedded_syntax={'xml':'','bash':'sh','sh':''} -->
# XML

## xmllint

On UNIX, to reindent an XML run:
```bash
xmllint --format myfile.xml >myfile_indented.xml
```

Reindent in VIM buffer:
```vim
%!xmllint --format -
```

To check syntax of an XML file:
```bash
xmllint --noout myfile.xml
```

To check using a schema:
```sh
xmllint --noout --schema myschema.xml myfile.xml
```

## xmlstarlet

 * [Adding a subnode to an XML file](https://www.technomancy.org/xml/add-a-subnode-command-line-xmlstarlet/).

Select all elements of a same type using XPath:
```sh
xmlstarlet sel -t -c '//b' -n myxml.xml 
```
	-n : new line
	-c : copy XPath selection

To print only the text (i.e.: values):
```sh
xmlstarlet sel -t -v '//b' -n myxml.xml 
```

Delete elements using XPath:
```sh
xmlstarlet ed -d '//my/tag' myxml.xml
# or
xmlstarlet ed --delete '//my/tag' myxml.xml
```

Use a namespace:
```sh
xmlstarlet sel -N x="http://my.name/space" -t -v '//x:b' -n myxml.xml 
```

## XPath

 * [XPath Tutorial](http://www.w3schools.com/xsl/xpath_intro.asp).

TO run an XPath command in a terminal:
```bash
xmllint --xpath '//element/@attribute' file.xml
```

To look for a node anywhere in the tree:
```
//mynode
```

To look for a node using a namespace ns:
```
//ns:mynode
```

To look for all nodes under another one:
```
/my/path/*
/my/path//*
```

To search for all nodes:
```
//*
```

To search for a node with text:
```
//mynode[text()='abc']
//mynode[starts-with(.,'Test')]
//mynode[contains(text(), 'Yahoo')]
```

To search for a node with a specific attribute:
```
//title[@lang]
//title[@lang='eng']
```

To search for a node that does not have a certain attribute:
```
//title[not(@lang)]
```

Get an attribute's value:
```
//mynode/@myattrb
```

Search a tag and the go up to find next tag of the same type:
```
//td[text()='InChIKey']/../td[2]
```

## XSLT

 * [FunctX XSLT Functions](http://www.xsltfunctions.com/xsl/).
 * [XSL Transformations (XSLT) Version 2.0](http://www.w3.org/TR/xslt20/).

## XML schema

XML Schema (aka XSD) is the language that is used to describe the structure of an XML.

Element with children:
```xml
<xs:element name="some_element_name">
  <xs:complexType>
    <xs:sequence> <!-- order indicator, see below -->

			<!-- children -->
				
    </xs:sequence>
  </xs:complexType>
</xs:element>
```

Order indicators for children:
```xml
<xs:sequence> <!-- order of children must be in the specified order -->
	<!-- children -->
</xs:sequence>

<xs:all> <!-- children can appear in any order, but can only appear once (or not at all) -->
	<!-- children -->
</xs:all>

<xs:choice> <!-- only one of the possible children can appear -->
</xs:choice>
```

Occurrence indicators.
They are used inside order indicators to define how often a child can occur.
```xml
<xs:sequence>
  <xs:element name="full_name" type="xs:string" maxOccurs="unbounded"/> <!-- this element can appear an unlimited number of times -->
  <xs:element name="child_name" type="xs:string" maxOccurs="10" minOccurs="0"/>
</xs:sequence>
```

Enumeration:
```xml
<xs:element name="car">
  <xs:simpleType>
    <xs:restriction base="xs:string">
      <xs:enumeration value="Audi"/>
      <xs:enumeration value="Golf"/>
      <xs:enumeration value="BMW"/>
    </xs:restriction>
  </xs:simpleType>
</xs:element>
```

Group:
```xml
<xs:group name="some_group">
  <xs:sequence>
    <xs:element name="customer" type="xs:string"/>
    <xs:element name="orderdetails" type="xs:string"/>
    <xs:element name="billto" type="xs:string"/>
    <xs:element name="shipto" type="xs:string"/>
  </xs:sequence>
</xs:group>

<xs:element name="some_element">
	<xs:group ref="some_group"/>
</xs:element>
```

Header:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
	
</xs:schema>
```


Complex type:
```xml
<xs:complexType name="some_complextype">
  <xs:sequence>
		<xs:element name="an_element" type="xs:string"/>
		<xs:element name="another_element" type="xs:string"/>
	</xs:sequence>
</xs:complexType>

<xs:element name="some_element" type="some_complextype"/>
```

Whitespace restriction.
	preserve = don't touch anything
	replace = replace all whitespace chars by space
	collapse = "replace" + reduce sequence of spaces with one single space
```xml
<xs:element name="address">
  <xs:simpleType>
    <xs:restriction base="xs:string">
      <xs:whiteSpace value="preserve"/>
    </xs:restriction>
  </xs:simpleType>
</xs:element>
```
