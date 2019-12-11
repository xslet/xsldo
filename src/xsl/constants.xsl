<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--** The constant parameter for an expanded path separator. -->
 <xsl:param name="do:_path_sep">&#x86;/&#x87;</xsl:param>

 <!--** The constant parameter for a name separator in an expanded path. -->
 <xsl:param name="do:_ns_sep">&#x86;:&#x87;</xsl:param>

 <!--** The constant parameter for a name-condition separator in an expanded path. -->
 <xsl:param name="do:_cond_sep">&#x86;?&#x87;</xsl:param>

 <!--** The constant parameter for a OR condition separator in an expanded path. -->
 <xsl:param name="do:_cond_or_sep">&#x96;|&#x97;</xsl:param>

 <!--** The constant parameter for a AND condition separator in an expanded path. -->
 <xsl:param name="do:_cond_and_sep">&#x96;,&#x97;</xsl:param>

 <!--** The constant parameter for a path separator in an expanded path condition. -->
 <xsl:param name="do:_cond_path_sep">&#x96;/&#x97;</xsl:param>

 <!--** The constant parameter for a oprator separator in an expanded path. -->
 <xsl:param name="do:_cond_op_sep">&#x96;=&#x97;</xsl:param>

 <!--** The constant parameter for an object separator. -->
 <xsl:param name="do:_object_sep">&#x86;;&#x87;</xsl:param>

</xsl:stylesheet>

