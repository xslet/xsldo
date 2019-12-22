<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Loops specified times.
 -->
 <xsl:template name="do:for_times">
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generate-id of a base node. -->
  <xsl:param name="data_gid"/>
  <!--** A loop count. -->
  <xsl:param name="times"/>
  <!--** Elements which are allowed to be applied. -->
  <xsl:param name="allow"/>
  <!--** A flag if text node is allowed. -->
  <xsl:param name="allow_text_node" select="$ut:true"/>
  <!--** Any argument 0. -->
  <xsl:param name="arg0"/>
  <!--** Any argument 1. -->
  <xsl:param name="arg1"/>
  <!--** Any argument 2. -->
  <xsl:param name="arg2"/>
  <xsl:call-template name="do:_for_times_rcr">
   <xsl:with-param name="times" select="$times"/>
   <xsl:with-param name="index">1</xsl:with-param>
   <xsl:with-param name="allow" select="$allow"/>
   <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
   <xsl:with-param name="arg0" select="$arg0"/>
   <xsl:with-param name="arg1" select="$arg1"/>
   <xsl:with-param name="arg2" select="$arg2"/>
   <xsl:with-param name="data_url" select="$data_url"/>
   <xsl:with-param name="data_gid" select="$data_gid"/>
  </xsl:call-template>
 </xsl:template>

 <xsl:template name="do:_for_times_rcr">
  <xsl:param name="times"/>
  <xsl:param name="index"/>
  <xsl:param name="allow"/>
  <xsl:param name="allow_text_node"/>
  <xsl:param name="arg0"/>
  <xsl:param name="arg1"/>
  <xsl:param name="arg2"/>
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:if test="$index &lt;= $times">
   <xsl:choose>
    <xsl:when test="$allow_text_node = $ut:true">
     <xsl:apply-templates select="text()|*[contains($allow, concat('|', name(), '|'))]">
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="data_gid" select="$data_gid"/>
      <xsl:with-param name="data_index" select="$index"/>
      <xsl:with-param name="allow" select="$allow"/>
      <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
      <xsl:with-param name="arg0" select="$arg0"/>
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
     </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates select="*[contains($allow, concat('|', name(), '|'))]">
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="data_gid" select="$data_gid"/>
      <xsl:with-param name="data_index" select="$index"/>
      <xsl:with-param name="allow" select="$allow"/>
      <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
      <xsl:with-param name="arg0" select="$arg0"/>
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
     </xsl:apply-templates>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:call-template name="do:_for_times_rcr">
    <xsl:with-param name="times" select="$times"/>
    <xsl:with-param name="index" select="$index + 1"/>
    <xsl:with-param name="allow" select="$allow"/>
    <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
    <xsl:with-param name="arg0" select="$arg0"/>
    <xsl:with-param name="arg1" select="$arg1"/>
    <xsl:with-param name="arg2" select="$arg2"/>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
