<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Counts nodes at a specified path
 -->
 <xsl:template name="do:count_nodes_by_path">
  <!--** A path. -->
  <xsl:param name="path"/>
  <!--** A prefix for each object. -->
  <xsl:param name="prefix"/>
  <!--** A suffix for each object. -->
  <xsl:param name="suffix"/>
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generate-id of a base node. -->
  <xsl:param name="data_gid"/>
  <xsl:variable name="_expath">
   <xsl:call-template name="do:expand_path">
    <xsl:with-param name="path" select="$path"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="do:count_nodes_by_expath">
   <xsl:with-param name="expath" select="$_expath"/>
   <xsl:with-param name="prefix" select="$prefix"/>
   <xsl:with-param name="suffix" select="$suffix"/>
   <xsl:with-param name="data_url" select="$data_url"/>
   <xsl:with-param name="data_gid" select="$data_gid"/>
  </xsl:call-template>
 </xsl:template>

 <!--**
   Counts nodes by an expath.
 -->
 <xsl:template name="do:count_nodes_by_expath">
  <!--** An expanded path. -->
  <xsl:param name="expath"/>
  <!--** A prefix for each object. -->
  <xsl:param name="prefix"/>
  <!--** A suffix for each object. -->
  <xsl:param name="suffix"/>
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generate-id of a base node. -->
  <xsl:param name="data_gid"/>
  <xsl:choose>
   <xsl:when test="string-length($data_url) = 0">
    <xsl:choose>
     <xsl:when test="string-length($data_gid) = 0">
      <xsl:call-template name="do:_count_nodes_by_expath_from_current_node">
       <xsl:with-param name="expath" select="$expath"/>
       <xsl:with-param name="prefix" select="$prefix"/>
       <xsl:with-param name="suffix" select="$suffix"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
      <xsl:for-each select="//attribute::node()[generate-id() = $data_gid]">
       <xsl:call-template name="do:_count_nodes_by_expath_from_current_node">
        <xsl:with-param name="expath" select="$expath"/>
        <xsl:with-param name="prefix" select="$prefix"/>
        <xsl:with-param name="suffix" select="$suffix"/>
       </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//*[generate-id() = $data_gid]">
       <xsl:call-template name="do:_count_nodes_by_expath_from_current_node">
        <xsl:with-param name="expath" select="$expath"/>
        <xsl:with-param name="prefix" select="$prefix"/>
        <xsl:with-param name="suffix" select="$suffix"/>
       </xsl:call-template>
      </xsl:for-each>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="document($data_url, /)">
     <xsl:choose>
      <xsl:when test="string-length($data_gid) = 0">
       <xsl:call-template name="do:_count_nodes_by_expath_from_current_node">
        <xsl:with-param name="expath" select="$expath"/>
        <xsl:with-param name="prefix" select="$prefix"/>
        <xsl:with-param name="suffix" select="$suffix"/>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <xsl:for-each select="//attribute::node()[generate-id() = $data_gid]">
        <xsl:call-template name="do:_count_nodes_by_expath_from_current_node">
         <xsl:with-param name="expath" select="$expath"/>
         <xsl:with-param name="prefix" select="$prefix"/>
         <xsl:with-param name="suffix" select="$suffix"/>
        </xsl:call-template>
       </xsl:for-each>
       <xsl:for-each select="//*[generate-id() = $data_gid]">
        <xsl:call-template name="do:_count_nodes_by_expath_from_current_node">
         <xsl:with-param name="expath" select="$expath"/>
         <xsl:with-param name="prefix" select="$prefix"/>
         <xsl:with-param name="suffix" select="$suffix"/>
        </xsl:call-template>
       </xsl:for-each>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_count_nodes_by_expath_from_current_node">
  <xsl:param name="expath"/>
  <xsl:param name="prefix"/>
  <xsl:param name="suffix"/>
  <xsl:variable name="_flags">
   <xsl:call-template name="do:get_objects_by_expath">
    <xsl:with-param name="expath" select="$expath"/>
    <xsl:with-param name="suffix">I</xsl:with-param>
   </xsl:call-template>
  </xsl:variable>
  <xsl:value-of select="$prefix"/>
  <xsl:value-of select="string-length($_flags)"/>
  <xsl:value-of select="$suffix"/>
 </xsl:template>

</xsl:stylesheet>
