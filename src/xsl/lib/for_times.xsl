<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Loops child nodes specified times.
   This template passes following parameters to child elements:
    - data_url : An URL of external data file.
    - data_gid : A generate-id of a base node.
    - data_index : An index of parent &lt;for&gt; element.
    - data_indexes : Indexes of ancestor's &lt;for&gt; element.
    - allow : Elements which are allowed to be applied.
    - allow_text_node : A flag if text node is allowed.
    - deny : Elements which are denied to be applied.
    - arg0 : Any argument 0.
    - arg1 : Any argument 1.
    - arg2 : Any argument 2.
 -->
 <xsl:template name="do:for_times">
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generate-id of a base node. -->
  <xsl:param name="data_gid"/>
  <!--** A loop count. -->
  <xsl:param name="times"/>
  <!--** Indexes of ancestor's for element. -->
  <xsl:param name="index_set"/>
  <!--** Current index ID -->
  <xsl:param name="index_id"/>
  <!--** Elements which are allowed to be applied. -->
  <xsl:param name="allow"/>
  <!--** A flag if text node is allowed. -->
  <xsl:param name="allow_text_node" select="$ut:true"/>
  <!--** Elements which are denied to be applied. -->
  <xsl:param name="deny"/>
  <!--** Any argument 0. -->
  <xsl:param name="arg0"/>
  <!--** Any argument 1. -->
  <xsl:param name="arg1"/>
  <!--** Any argument 2. -->
  <xsl:param name="arg2"/>
  <xsl:call-template name="do:_for_times_rcr">
   <xsl:with-param name="times" select="$times"/>
   <xsl:with-param name="index">1</xsl:with-param>
   <xsl:with-param name="index_set" select="$index_set"/>
   <xsl:with-param name="index_id" select="$index_id"/>
   <xsl:with-param name="allow" select="$allow"/>
   <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
   <xsl:with-param name="deny" select="$deny"/>
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
  <xsl:param name="index_set"/>
  <xsl:param name="index_id"/>
  <xsl:param name="allow"/>
  <xsl:param name="allow_text_node"/>
  <xsl:param name="deny"/>
  <xsl:param name="arg0"/>
  <xsl:param name="arg1"/>
  <xsl:param name="arg2"/>
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:variable name="_index_set">
   <xsl:if test="string-length($index_id) &gt; 0">
    <xsl:value-of select="$do:_object_sep"/>
    <xsl:value-of select="$index_id"/>
    <xsl:value-of select="$do:_cond_op_sep"/>
    <xsl:value-of select="$index"/>
   </xsl:if>
   <xsl:choose>
    <xsl:when test="string-length($index_set) = 0">
     <xsl:value-of select="$do:_object_sep"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$index_set"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:if test="$index &lt;= $times">
   <xsl:call-template name="do:_apply_each_node">
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
    <xsl:with-param name="data_index" select="$index"/>
    <xsl:with-param name="data_indexes" select="$_index_set"/>
    <xsl:with-param name="allow" select="$allow"/>
    <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
    <xsl:with-param name="deny" select="$deny"/>
    <xsl:with-param name="arg0" select="$arg0"/>
    <xsl:with-param name="arg1" select="$arg1"/>
    <xsl:with-param name="arg2" select="$arg2"/>
   </xsl:call-template>
   <xsl:call-template name="do:_for_times_rcr">
    <xsl:with-param name="times" select="$times"/>
    <xsl:with-param name="index" select="$index + 1"/>
    <xsl:with-param name="index_set" select="$index_set"/>
    <xsl:with-param name="index_id" select="$index_id"/>
    <xsl:with-param name="allow" select="$allow"/>
    <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
    <xsl:with-param name="deny" select="$deny"/>
    <xsl:with-param name="arg0" select="$arg0"/>
    <xsl:with-param name="arg1" select="$arg1"/>
    <xsl:with-param name="arg2" select="$arg2"/>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
