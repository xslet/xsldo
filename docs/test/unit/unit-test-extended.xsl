<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsx="dummy-ns" exclude-result-prefixes="xsx"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="unit-test.xsl"/>

 <xsl:template match="value_of_current_node">
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:call-template name="do:get_objects_by_expath">
   <xsl:with-param name="what">content</xsl:with-param>
   <xsl:with-param name="data_url" select="$data_url"/>
   <xsl:with-param name="data_gid" select="$data_gid"/>
  </xsl:call-template>
 </xsl:template>

 <xsl:template match="index_of_current_node">
  <xsl:param name="data_index"/>
  <xsl:text>[</xsl:text>
  <xsl:value-of select="$data_index"/>
  <xsl:text>]</xsl:text>
 </xsl:template>

 <xsl:template match="index_of">
  <xsl:param name="data_indexes"/>
  <xsl:variable name="_id" select="@index_id"/>
  <xsl:variable name="_s" select="substring-after($data_indexes, concat($do:_object_sep, $_id, $do:_cond_op_sep))"/>
  <xsl:text>{</xsl:text>
  <xsl:value-of select="substring-before($_s, $do:_object_sep)"/>
  <xsl:text>}</xsl:text>
 </xsl:template>

 <xsl:template match="compute[@name='do:get_current_attribute']">
  <xsl:variable name="_what" select="@what"/>
  <xsl:variable name="_prefix" select="@prefix"/>
  <xsl:variable name="_suffix" select="@suffix"/>
  <xsl:for-each select="@attr">
   <xsl:call-template name="do:get_current_attribute">
    <xsl:with-param name="what" select="$_what"/>
    <xsl:with-param name="prefix" select="$_prefix"/>
    <xsl:with-param name="suffix" select="$_suffix"/>
   </xsl:call-template>
  </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>
