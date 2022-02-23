<?xml version="1.0" encoding="utf-8"?>

<!--**
 xsldo is a XSLT liblet to operate XML data on Web browsers.

 This liblet provides functions (named-templates) to get values or to loop of nodes at the specified XML path. A XML path is a concatenation of node names with slash(/). Further more, this liblet can operate XML data in external files.

 Following notations for XML paths have special meanings:

 - Single asterisk (*) means any child nodes.
 - Double asterisks (**) or empty (//) means any descendant nodes.
 - Single dot (.) means current node.
 - Double dots (..) means parent node.
 - Expressions in brackets ([]) means path condition.

 The path condition supports the following operators:

 - '=' and 'eq' means that left side is equal to right side.
 - '!=' and 'ne' means that left side is not equal to right side.
 - 'gt' means that left side is greater than right side.
 - 'ge' means that left side is greater than or equal to right side.
 - 'lt' means that left side is less than right side.
 - 'le' means that left side is less than or equal to right side.

 do:get_current_value, do:get_current_attribute and some functions which use these two functions inside have a parameter `what` which means kind of object. This parameter can have one of following values:
  - content : Result applying a template to each element.
  - text : Child text node of each element or value of each attribute.
  - number : Numeric value by converting child text node of each element or value of each attribute.
  - name : Local name of each element/attribute.
  - id : Generated ID of each element/attribute.
  - preceding-comment : Immediate preceding comment of each element.
  - following-comment : Immediate following comment of each element.

 This program is written in XSLT 1.0.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
</xsl:stylesheet>
