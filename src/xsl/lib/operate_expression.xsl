<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Operates an expression.
 -->
 <xsl:template name="do:operate_expression">
  <!--** A left side of an expression -->
  <xsl:param name="left"/>
  <!--** An operator -->
  <xsl:param name="op"/>
  <!--** A right side of an expression -->
  <xsl:param name="right"/>
  <xsl:choose>
   <xsl:when test="$op = 'eq'">
    <xsl:if test="$left = $right">
     <xsl:value-of select="$ut:true"/>
    </xsl:if>
   </xsl:when>
   <xsl:when test="$op = 'ne'">
    <xsl:if test="$left != $right">
     <xsl:value-of select="$ut:true"/>
    </xsl:if>
   </xsl:when>
   <xsl:when test="$op = 'lt'">
    <xsl:if test="$left &lt; $right">
     <xsl:value-of select="$ut:true"/>
    </xsl:if>
   </xsl:when>
   <xsl:when test="$op = 'le'">
    <xsl:if test="$left &lt;= $right">
     <xsl:value-of select="$ut:true"/>
    </xsl:if>
   </xsl:when>
   <xsl:when test="$op = 'gt'">
    <xsl:if test="$left &gt; $right">
     <xsl:value-of select="$ut:true"/>
    </xsl:if>
   </xsl:when>
   <xsl:when test="$op = 'ge'">
    <xsl:if test="$left &gt;= $right">
     <xsl:value-of select="$ut:true"/>
    </xsl:if>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
