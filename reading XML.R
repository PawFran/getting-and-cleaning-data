library(XML)
fileURL <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileURL, useInternal=T)
rootNode <- xmlRoot(doc) # wrapper
xmlName(rootNode)

names(rootNode) # lists all nested elements

rootNode[[1]] # returns content
rootNode[[1]][[1]] # one step deeper

xmlSApply(rootNode, xmlValue) # loops through all the elements and apply function xmlValue (everything between tags)

#XPath language
# /node - top level node
# //node - node at any level
# node[@attr-name] - node with  attribute name
# node[@attr-name='bob'] - node with specific attribute name

xpathSApply(rootNode, "//name", xmlValue) # all values assosiated with tag name
xpathApply(rootNode, "//price", xmlValue)


# another example - html
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal = T)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores
teams
