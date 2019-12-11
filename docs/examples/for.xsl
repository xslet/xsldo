<?xml version="1.0" encoding="utf-8"?>
<!-- for.xsl -->
<xsl:stylesheet version="1.0"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="xsldo.xsl"/>

 <xsl:template match="/top">
  <html>
   <body>
    <xsl:apply-templates select="for"/>
   </body>
  </html>
 </xsl:template>

 <xsl:template match="for[boolean(@path)]">
  <xsl:call-template name="do:for_by_path">
   <xsl:with-param name="path" select="@path"/>
   <xsl:with-param name="data_url" select="@file"/>
   <xsl:with-param name="allow">|all|</xsl:with-param>
   <xsl:with-param name="prefix">(</xsl:with-param>
   <xsl:with-param name="suffix">)</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

 <xsl:template match="all">
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:call-template name="do:get_objects_by_path">
   <xsl:with-param name="path" select="@path"/>
   <xsl:with-param name="data_url" select="$data_url"/>
   <xsl:with-param name="data_gid" select="$data_gid"/>
   <xsl:with-param name="what">text</xsl:with-param>
   <xsl:with-param name="prefix">(</xsl:with-param>
   <xsl:with-param name="suffix">)</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>
