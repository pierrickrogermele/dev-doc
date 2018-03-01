#!/usr/bin/env Rscript

# From StackOverflow [R: Put Child Elements of an XML node into a data frame, based on the attribute](https://stackoverflow.com/questions/48923213/r-put-child-elements-of-an-xml-node-into-a-data-frame-based-on-the-attribute).

    # Define the XML text
    xml.str <- '<?xml version="1.0"?>
    <catalog>
       <book id="bk101">
          <author>Gambardella, Matthew</author>
          <title>XML Developer\'s Guide</title>
          <genre>Computer</genre>
          <price>44.95</price>
          <publish_date>2000-10-01</publish_date>
          <description>An in-depth look at creating applications 
          with XML.</description>
       </book>
       <book id="bk102">
          <author>Ralls, Kim</author>
          <title>Midnight Rain</title>
          <genre>Fantasy</genre>
          <price>5.95</price>
          <publish_date>2000-12-16</publish_date>
          <description>A former architect battles corporate zombies, 
          an evil sorceress, and her own childhood to become queen 
          of the world.</description>
       </book>
    </catalog>'
    
    # Parse the XML
    xml <- XML::xmlInternalTreeParse(xml.str, asText = TRUE)
    
    # Get the book IDs
    ids <- XML::xpathSApply(xml, '//book', XML::xmlGetAttr, 'id')
    
    # Retrieve values for each book
    books <- data.frame()
    for (id in ids) {
    	book <- list(id = id)
    	for (field in c('author', 'title', 'genre', 'price', 'publish_date')) {
    		value <- XML::xpathSApply(xml, paste0('//book[@id="', id, '"]/', field), XML::xmlValue)
    		book[[field]] <- value
    	}
    	books <- rbind(books, book, stringsAsFactors = FALSE)
    }
    
    # Result
    books
