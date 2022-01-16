<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Loops for each nodes at a specified path.
 -->
 <xsl:template name="do:for_by_path">
  <!--** A path. -->
  <xsl:param name="path"/>
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generate-id of a base node. -->
  <xsl:param name="data_gid"/>
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
  <xsl:variable name="_expath">
   <xsl:call-template name="do:expand_path">
    <xsl:with-param name="path" select="$path"/>
    <xsl:with-param name="what">id</xsl:with-param>
   </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="do:for_by_expath">
   <xsl:with-param name="expath" select="$_expath"/>
   <xsl:with-param name="data_url" select="$data_url"/>
   <xsl:with-param name="data_gid" select="$data_gid"/>
   <xsl:with-param name="index_set" select="$index_set"/>
   <xsl:with-param name="index_id" select="$index_id"/>
   <xsl:with-param name="allow" select="$allow"/>
   <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
   <xsl:with-param name="deny" select="$deny"/>
   <xsl:with-param name="arg0" select="$arg0"/>
   <xsl:with-param name="arg1" select="$arg1"/>
   <xsl:with-param name="arg2" select="$arg2"/>
  </xsl:call-template>
 </xsl:template>

 <!--**
   Loops for each nodes at specified expanded paths.
 -->
 <xsl:template name="do:for_by_expath">
  <!--** An expanded path. -->
  <xsl:param name="expath"/>
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generate-id of a base node. -->
  <xsl:param name="data_gid"/>
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
  <xsl:variable name="_gids">
   <xsl:choose>
    <xsl:when test="string-length($data_url) = 0">
     <xsl:choose>
      <xsl:when test="string-length($data_gid) = 0">
       <xsl:call-template name="do:get_objects_by_expath">
        <xsl:with-param name="expath" select="$expath"/>
        <xsl:with-param name="what">id</xsl:with-param>
        <xsl:with-param name="suffix" select="$do:_object_sep"/>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <xsl:for-each select="//attribute::node()[generate-id() = $data_gid]">
        <xsl:call-template name="do:get_objects_by_expath">
         <xsl:with-param name="expath" select="$expath"/>
         <xsl:with-param name="what">id</xsl:with-param>
         <xsl:with-param name="suffix" select="$do:_object_sep"/>
        </xsl:call-template>
       </xsl:for-each>
       <xsl:for-each select="//*[generate-id() = $data_gid]">
        <xsl:call-template name="do:get_objects_by_expath">
         <xsl:with-param name="expath" select="$expath"/>
         <xsl:with-param name="what">id</xsl:with-param>
         <xsl:with-param name="suffix" select="$do:_object_sep"/>
        </xsl:call-template>
       </xsl:for-each>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
     <xsl:for-each select="document($data_url, /)">
      <xsl:choose>
       <xsl:when test="string-length($data_gid) = 0">
        <xsl:call-template name="do:get_objects_by_expath">
         <xsl:with-param name="expath" select="$expath"/>
         <xsl:with-param name="what">id</xsl:with-param>
         <xsl:with-param name="suffix" select="$do:_object_sep"/>
        </xsl:call-template>
       </xsl:when>
       <xsl:otherwise>
        <xsl:for-each select="//attribute::node()[generate-id() = $data_gid]">
         <xsl:call-template name="do:get_objects_by_expath">
          <xsl:with-param name="expath" select="$expath"/>
          <xsl:with-param name="what">id</xsl:with-param>
          <xsl:with-param name="suffix" select="$do:_object_sep"/>
         </xsl:call-template>
        </xsl:for-each>
        <xsl:for-each select="//*[generate-id() = $data_gid]">
         <xsl:call-template name="do:get_objects_by_expath">
          <xsl:with-param name="expath" select="$expath"/>
          <xsl:with-param name="what">id</xsl:with-param>
          <xsl:with-param name="suffix" select="$do:_object_sep"/>
         </xsl:call-template>
        </xsl:for-each>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:for-each>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:call-template name="do:_for_by_gids_rcr">
   <xsl:with-param name="gids" select="$_gids"/>
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
  </xsl:call-template>
 </xsl:template>

 <xsl:template name="do:_for_by_gids_rcr">
  <xsl:param name="gids"/>
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
  <xsl:variable name="_index_set">
   <xsl:if test="string-length($index_id) &gt; 0">
    <xsl:value-of select="$index_id"/>
    <xsl:value-of select="$do:_cond_op_sep"/>
    <xsl:value-of select="$index"/>
    <xsl:value-of select="$do:_object_sep"/>
   </xsl:if>
   <xsl:value-of select="$index_set"/>
  </xsl:variable>
  <xsl:variable name="_gid" select="substring-before($gids, $do:_object_sep)"/>
  <xsl:variable name="_next" select="substring-after($gids, $do:_object_sep)"/>
  <xsl:if test="string-length($_gid) &gt; 0">
   <xsl:call-template name="do:_apply_each_node">
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$_gid"/>
    <xsl:with-param name="data_index" select="$index"/>
    <xsl:with-param name="data_indexes" select="$_index_set"/>
    <xsl:with-param name="allow" select="$allow"/>
    <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
    <xsl:with-param name="deny" select="$deny"/>
    <xsl:with-param name="arg0" select="$arg0"/>
    <xsl:with-param name="arg1" select="$arg1"/>
    <xsl:with-param name="arg2" select="$arg2"/>
   </xsl:call-template>
  </xsl:if>
  <xsl:if test="string-length($_next) &gt; 0">
   <xsl:call-template name="do:_for_by_gids_rcr">
    <xsl:with-param name="gids" select="$_next"/>
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
   </xsl:call-template>
  </xsl:if>
 </xsl:template>

 <xsl:template name="do:_apply_each_node">
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:param name="data_index"/>
  <xsl:param name="data_indexes"/>
  <xsl:param name="allow"/>
  <xsl:param name="allow_text_node"/>
  <xsl:param name="deny"/>
  <xsl:param name="arg0"/>
  <xsl:param name="arg1"/>
  <xsl:param name="arg2"/>
  <xsl:choose>
   <xsl:when test="string-length($allow) = 0">
    <xsl:choose>
     <xsl:when test="$allow_text_node = $ut:true">
      <xsl:apply-templates select="text()|*[not(contains($deny, concat('|', name(), '|')))]">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="data_gid" select="$data_gid"/>
       <xsl:with-param name="data_index" select="$data_index"/>
       <xsl:with-param name="data_indexes" select="$data_indexes"/>
       <xsl:with-param name="allow" select="$allow"/>
       <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
       <xsl:with-param name="deny" select="$deny"/>
       <xsl:with-param name="arg0" select="$arg0"/>
       <xsl:with-param name="arg1" select="$arg1"/>
       <xsl:with-param name="arg2" select="$arg2"/>
      </xsl:apply-templates>
     </xsl:when>
     <xsl:otherwise>
      <xsl:apply-templates select="*[not(contains($deny, concat('|', name(), '|')))]">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="data_gid" select="$data_gid"/>
       <xsl:with-param name="data_index" select="$data_index"/>
       <xsl:with-param name="data_indexes" select="$data_indexes"/>
       <xsl:with-param name="allow" select="$allow"/>
       <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
       <xsl:with-param name="deny" select="$deny"/>
       <xsl:with-param name="arg0" select="$arg0"/>
       <xsl:with-param name="arg1" select="$arg1"/>
       <xsl:with-param name="arg2" select="$arg2"/>
      </xsl:apply-templates>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <xsl:choose>
     <xsl:when test="$allow_text_node = $ut:true">
      <xsl:apply-templates select="text()|*[contains($allow, concat('|', name(), '|')) and not(contains($deny, concat('|', name(), '|')))]">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="data_gid" select="$data_gid"/>
       <xsl:with-param name="data_index" select="$data_index"/>
       <xsl:with-param name="data_indexes" select="$data_indexes"/>
       <xsl:with-param name="allow" select="$allow"/>
       <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
       <xsl:with-param name="deny" select="$deny"/>
       <xsl:with-param name="arg0" select="$arg0"/>
       <xsl:with-param name="arg1" select="$arg1"/>
       <xsl:with-param name="arg2" select="$arg2"/>
      </xsl:apply-templates>
     </xsl:when>
     <xsl:otherwise>
      <xsl:apply-templates select="*[contains($allow, concat('|', name(), '|')) and not(contains($deny, concat('|', name(), '|')))]">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="data_gid" select="$data_gid"/>
       <xsl:with-param name="data_index" select="$data_index"/>
       <xsl:with-param name="data_indexes" select="$data_indexes"/>
       <xsl:with-param name="allow" select="$allow"/>
       <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
       <xsl:with-param name="deny" select="$deny"/>
       <xsl:with-param name="arg0" select="$arg0"/>
       <xsl:with-param name="arg1" select="$arg1"/>
       <xsl:with-param name="arg2" select="$arg2"/>
      </xsl:apply-templates>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
