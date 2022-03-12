<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Loops child nodes for each nodes at a specified path.
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
  <!--** A reverse flag -->
  <xsl:param name="reverse"/>
  <!--** A sort node name -->
  <xsl:param name="sort_name"/>
  <!--** A sort direction -->
  <xsl:param name="sort_dir"/>
  <!--** A sort type (text/number) -->
  <xsl:param name="sort_type"/>
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
   <xsl:with-param name="reverse" select="$reverse"/>
   <xsl:with-param name="sort_name" select="$sort_name"/>
   <xsl:with-param name="sort_dir" select="$sort_dir"/>
   <xsl:with-param name="sort_type" select="$sort_type"/>
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
  <!--** A reverse flag -->
  <xsl:param name="reverse"/>
  <!--** A sort node name -->
  <xsl:param name="sort_name"/>
  <!--** A sort direction -->
  <xsl:param name="sort_dir"/>
  <!--** A sort type (text/number) -->
  <xsl:param name="sort_type"/>
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
       <xsl:call-template name="do:_collect_gids_without_data_gid">
        <xsl:with-param name="expath" select="$expath"/>
        <xsl:with-param name="sort_name" select="$sort_name"/> 
        <xsl:with-param name="sort_dir" select="$sort_dir"/> 
        <xsl:with-param name="sort_type" select="$sort_type"/> 
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <xsl:call-template name="do:_collect_gids_with_data_gid">
        <xsl:with-param name="data_gid" select="$data_gid"/>
        <xsl:with-param name="expath" select="$expath"/>
        <xsl:with-param name="sort_name" select="$sort_name"/> 
        <xsl:with-param name="sort_dir" select="$sort_dir"/> 
        <xsl:with-param name="sort_type" select="$sort_type"/> 
       </xsl:call-template>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
     <xsl:for-each select="document($data_url, /)">
      <xsl:choose>
       <xsl:when test="string-length($data_gid) = 0">
        <xsl:call-template name="do:_collect_gids_without_data_gid">
         <xsl:with-param name="expath" select="$expath"/>
         <xsl:with-param name="sort_name" select="$sort_name"/> 
         <xsl:with-param name="sort_dir" select="$sort_dir"/> 
         <xsl:with-param name="sort_type" select="$sort_type"/> 
        </xsl:call-template>
       </xsl:when>
       <xsl:otherwise>
        <xsl:call-template name="do:_collect_gids_with_data_gid">
         <xsl:with-param name="data_gid" select="$data_gid"/>
         <xsl:with-param name="expath" select="$expath"/>
         <xsl:with-param name="sort_name" select="$sort_name"/> 
         <xsl:with-param name="sort_dir" select="$sort_dir"/> 
         <xsl:with-param name="sort_type" select="$sort_type"/> 
        </xsl:call-template>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:for-each>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_num_of_gids">
   <xsl:if test="$reverse = $ut:true">
    <xsl:variable name="_len0" select="string-length($_gids)"/>
    <xsl:variable name="_len1" select="string-length(translate($_gids, $do:_object_sep, ''))"/>
    <xsl:variable name="_sep_len" select="string-length($do:_object_sep)"/>
    <xsl:value-of select="($_len0 - $_len1) div $_sep_len"/>
   </xsl:if>
  </xsl:variable>
  <xsl:call-template name="do:_for_by_gids_rcr">
   <xsl:with-param name="gids" select="$_gids"/>
   <xsl:with-param name="reverse" select="$reverse"/>
   <xsl:with-param name="index">1</xsl:with-param>
   <xsl:with-param name="index_set" select="$index_set"/>
   <xsl:with-param name="index_id" select="$index_id"/>
   <xsl:with-param name="count" select="$_num_of_gids"/>
   <xsl:with-param name="allow" select="$allow"/>
   <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
   <xsl:with-param name="deny" select="$deny"/>
   <xsl:with-param name="arg0" select="$arg0"/>
   <xsl:with-param name="arg1" select="$arg1"/>
   <xsl:with-param name="arg2" select="$arg2"/>
   <xsl:with-param name="data_url" select="$data_url"/>
  </xsl:call-template>
 </xsl:template>


 <xsl:template name="do:_collect_gids_without_data_gid">
  <xsl:param name="expath"/>
  <xsl:param name="sort_name"/>
  <xsl:param name="sort_type"/>
  <xsl:param name="sort_dir"/>
  <xsl:variable name="_gids0">
   <xsl:call-template name="do:get_objects_by_expath">
    <xsl:with-param name="expath" select="$expath"/>
    <xsl:with-param name="what">id</xsl:with-param>
    <xsl:with-param name="suffix" select="$do:_object_sep"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="string-length($sort_name) &gt; 0 or string-length($sort_dir) &gt; 0 or string-length($sort_type) &gt; 0">
    <xsl:call-template name="do:_sort_gids">
     <xsl:with-param name="gids" select="$_gids0"/>
     <xsl:with-param name="expath" select="$expath"/> 
     <xsl:with-param name="sort_name" select="$sort_name"/> 
     <xsl:with-param name="sort_dir" select="$sort_dir"/> 
     <xsl:with-param name="sort_type" select="$sort_type"/> 
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$_gids0"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_collect_gids_with_data_gid">
  <xsl:param name="data_gid"/>
  <xsl:param name="expath"/>
  <xsl:param name="sort_name"/>
  <xsl:param name="sort_type"/>
  <xsl:param name="sort_dir"/>
  <xsl:variable name="_gids0">
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
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="string-length($sort_name) &gt; 0 or string-length($sort_dir) &gt; 0 or string-length($sort_type) &gt; 0">
    <xsl:call-template name="do:_sort_gids">
     <xsl:with-param name="gids" select="$_gids0"/>
     <xsl:with-param name="expath" select="$expath"/> 
     <xsl:with-param name="sort_name" select="$sort_name"/> 
     <xsl:with-param name="sort_dir" select="$sort_dir"/> 
     <xsl:with-param name="sort_type" select="$sort_type"/> 
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$_gids0"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>


 <xsl:template name="do:_for_by_gids_rcr">
  <xsl:param name="gids"/>
  <xsl:param name="reverse"/>
  <xsl:param name="index"/>
  <xsl:param name="index_set"/>
  <xsl:param name="index_id"/>
  <xsl:param name="count"/>
  <xsl:param name="allow"/>
  <xsl:param name="allow_text_node"/>
  <xsl:param name="deny"/>
  <xsl:param name="arg0"/>
  <xsl:param name="arg1"/>
  <xsl:param name="arg2"/>
  <xsl:param name="data_url"/>
  <xsl:variable name="_index_set">
   <xsl:if test="string-length($index_id) &gt; 0">
    <xsl:value-of select="$do:_object_sep"/>
    <xsl:value-of select="$index_id"/>
    <xsl:value-of select="$do:_cond_op_sep"/>
    <xsl:choose>
     <xsl:when test="$reverse = $ut:true">
      <xsl:value-of select="$count + 1 - $index"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:value-of select="$index"/>
     </xsl:otherwise>
    </xsl:choose>
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
  <xsl:variable name="_gid" select="substring-before($gids, $do:_object_sep)"/>
  <xsl:variable name="_next" select="substring-after($gids, $do:_object_sep)"/>
  <xsl:choose>
   <xsl:when test="$reverse = $ut:true">
    <xsl:if test="string-length($_next) &gt; 0">
     <xsl:call-template name="do:_for_by_gids_rcr">
      <xsl:with-param name="gids" select="$_next"/>
      <xsl:with-param name="reverse" select="$reverse"/>
      <xsl:with-param name="index" select="$index + 1"/>
      <xsl:with-param name="index_set" select="$index_set"/>
      <xsl:with-param name="index_id" select="$index_id"/>
      <xsl:with-param name="count" select="$count"/>
      <xsl:with-param name="allow" select="$allow"/>
      <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
      <xsl:with-param name="deny" select="$deny"/>
      <xsl:with-param name="arg0" select="$arg0"/>
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
      <xsl:with-param name="data_url" select="$data_url"/>
     </xsl:call-template>
    </xsl:if>
    <xsl:if test="string-length($_gid) &gt; 0">
     <xsl:call-template name="do:_apply_each_node">
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="data_gid" select="$_gid"/>
      <xsl:with-param name="data_index" select="$count + 1 - $index"/>
      <xsl:with-param name="data_indexes" select="$_index_set"/>
      <xsl:with-param name="allow" select="$allow"/>
      <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
      <xsl:with-param name="deny" select="$deny"/>
      <xsl:with-param name="arg0" select="$arg0"/>
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
     </xsl:call-template>
    </xsl:if>
   </xsl:when>
   <xsl:otherwise>
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
      <xsl:with-param name="reverse" select="$reverse"/>
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
   </xsl:otherwise>
  </xsl:choose>
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

 <xsl:template name="do:_sort_gids">
  <xsl:param name="gids"/>
  <xsl:param name="expath"/>
  <xsl:param name="sort_name"/>
  <xsl:param name="sort_dir"/>
  <xsl:param name="sort_type"/>
  <xsl:variable name="_last">
   <xsl:call-template name="do:_get_last_node_name">
    <xsl:with-param name="expath" select="$expath"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_is_last_attr">
   <xsl:if test="starts-with($_last, '@')">
    <xsl:value-of select="$ut:true"/>
   </xsl:if>
  </xsl:variable>
  <xsl:variable name="_last_name">
   <xsl:choose>
    <xsl:when test="$_is_last_attr = $ut:true">
     <xsl:value-of select="substring($_last, 2)"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$_last"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_ns">
   <xsl:value-of select="substring-before($_last_name, $do:_ns_sep)"/>
  </xsl:variable>
  <xsl:variable name="_lname">
   <xsl:value-of select="substring-before(substring-after($_last_name, $do:_ns_sep), $do:_cond_sep)"/>
  </xsl:variable>
  <xsl:variable name="_is_sort_by_attr">
   <xsl:if test="starts-with($sort_name, '@')">
    <xsl:value-of select="$ut:true"/>
   </xsl:if>
  </xsl:variable>
  <xsl:variable name="_sort_name">
   <xsl:choose>
    <xsl:when test="$_is_sort_by_attr = $ut:true">
     <xsl:value-of select="substring($sort_name, 2)"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$sort_name"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_sort_ns">
   <xsl:variable name="_s" select="substring-before($_sort_name, ':')"/>
   <xsl:choose>
    <xsl:when test="string-length($_s) &gt; 0">
     <xsl:call-template name="ut:get_namespace_uri">
      <xsl:with-param name="prefix" select="$_s"/>
     </xsl:call-template>
    </xsl:when>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_sort_elem_lname">
   <xsl:variable name="_s" select="substring-after($_sort_name, ':')"/>
   <xsl:choose>
    <xsl:when test="string-length($_s) &gt; 0">
     <xsl:value-of select="$_s"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$_sort_name"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_sort_lname">
   <xsl:variable name="_s" select="substring-before($_sort_elem_lname, '/@')"/>
   <xsl:choose>
    <xsl:when test="string-length($_s) &gt; 0">
     <xsl:value-of select="$_s"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$_sort_elem_lname"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_sort_attr_name">
   <xsl:variable name="_s" select="substring-after($_sort_elem_lname, '/@')"/>
   <xsl:choose>
    <xsl:when test="string-length($_s) &gt; 0">
     <xsl:value-of select="$_s"/>
    </xsl:when>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_sort_attr_ns">
   <xsl:variable name="_s" select="substring-before($_sort_attr_name, ':')"/>
   <xsl:choose>
    <xsl:when test="string-length($_s) &gt; 0">
     <xsl:call-template name="ut:get_namespace_uri">
      <xsl:with-param name="prefix" select="$_s"/>
     </xsl:call-template>
    </xsl:when>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_sort_attr_lname">
   <xsl:variable name="_s" select="substring-after($_sort_attr_name, ':')"/>
   <xsl:choose>
    <xsl:when test="string-length($_s) &gt; 0">
     <xsl:value-of select="$_s"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$_sort_attr_name"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_sort_dir">
   <xsl:choose>
    <xsl:when test="$sort_dir = 'desc'">descending</xsl:when>
    <xsl:otherwise>ascending</xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_sort_type">
   <xsl:choose>
    <xsl:when test="$sort_type = 'number'">number</xsl:when>
    <xsl:otherwise>text</xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_sorted_gids">
   <xsl:choose>
    <xsl:when test="$_is_last_attr = $ut:true">
     <xsl:if test="string-length($sort_name) = 0 or $sort_name='.'">
      <xsl:call-template name="do:_sort_attributes">
       <xsl:with-param name="expath" select="$expath"/>
       <xsl:with-param name="ns" select="$_ns"/>
       <xsl:with-param name="lname" select="$_lname"/>
       <xsl:with-param name="sort_dir" select="$_sort_dir"/>
       <xsl:with-param name="sort_type" select="$_sort_type"/>
      </xsl:call-template>
     </xsl:if>
    </xsl:when>
    <xsl:when test="$_is_sort_by_attr = $ut:true">
     <xsl:call-template name="do:_sort_elements_by_attribute">
      <xsl:with-param name="expath" select="$expath"/>
      <xsl:with-param name="ns" select="$_ns"/>
      <xsl:with-param name="lname" select="$_lname"/>
      <xsl:with-param name="sort_ns" select="$_sort_ns"/>
      <xsl:with-param name="sort_lname" select="$_sort_lname"/>
      <xsl:with-param name="sort_dir" select="$_sort_dir"/>
      <xsl:with-param name="sort_type" select="$_sort_type"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="string-length($sort_name) = 0 or $sort_name = '.'">
     <xsl:call-template name="do:_sort_elements_without_sort_name">
      <xsl:with-param name="expath" select="$expath"/>
      <xsl:with-param name="ns" select="$_ns"/>
      <xsl:with-param name="lname" select="$_lname"/>
      <xsl:with-param name="sort_dir" select="$_sort_dir"/>
      <xsl:with-param name="sort_type" select="$_sort_type"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="string-length($_sort_attr_name) &gt; 0">
     <xsl:call-template name="do:_sort_elements_by_element_and_attribute">
      <xsl:with-param name="expath" select="$expath"/>
      <xsl:with-param name="ns" select="$_ns"/>
      <xsl:with-param name="lname" select="$_lname"/>
      <xsl:with-param name="sort_ns" select="$_sort_ns"/>
      <xsl:with-param name="sort_lname" select="$_sort_lname"/>
      <xsl:with-param name="sort_attr_ns" select="$_sort_attr_ns"/>
      <xsl:with-param name="sort_attr_lname" select="$_sort_attr_lname"/>
      <xsl:with-param name="sort_dir" select="$_sort_dir"/>
      <xsl:with-param name="sort_type" select="$_sort_type"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="do:_sort_elements_by_element">
      <xsl:with-param name="expath" select="$expath"/>
      <xsl:with-param name="ns" select="$_ns"/>
      <xsl:with-param name="lname" select="$_lname"/>
      <xsl:with-param name="sort_ns" select="$_sort_ns"/>
      <xsl:with-param name="sort_lname" select="$_sort_lname"/>
      <xsl:with-param name="sort_dir" select="$_sort_dir"/>
      <xsl:with-param name="sort_type" select="$_sort_type"/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:call-template name="do:_sort_selected_gids_rcr">
   <xsl:with-param name="selected_gids" select="concat($do:_object_sep, $gids)"/>
   <xsl:with-param name="sorted_gids" select="$_sorted_gids"/>
  </xsl:call-template>
 </xsl:template>

 <xsl:template name="do:_sort_attributes">
  <xsl:param name="expath"/>
  <xsl:param name="ns"/>
  <xsl:param name="lname"/>
  <xsl:param name="sort_dir"/>
  <xsl:param name="sort_type"/>
  <xsl:choose>
   <xsl:when test="starts-with($expath, $do:_path_sep)">
    <xsl:for-each select="//attribute::node()[namespace-uri() = $ns and local-name() = $lname]">
     <xsl:sort order="{$sort_dir}" data-type="{$sort_type}"/>
     <xsl:value-of select="generate-id()"/>
     <xsl:value-of select="$do:_object_sep"/>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select=".//attribute::node()[namespace-uri() = $ns and local-name() = $lname]">
     <xsl:sort order="{$sort_dir}" data-type="{$sort_type}"/>
     <xsl:value-of select="generate-id()"/>
     <xsl:value-of select="$do:_object_sep"/>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_sort_elements_by_attribute">
  <xsl:param name="expath"/>
  <xsl:param name="ns"/>
  <xsl:param name="lname"/>
  <xsl:param name="sort_ns"/>
  <xsl:param name="sort_lname"/>
  <xsl:param name="sort_dir"/>
  <xsl:param name="sort_type"/>
  <xsl:choose>
   <xsl:when test="starts-with($expath, $do:_path_sep)">
    <xsl:for-each select="/descendant::*[namespace-uri() = $ns and local-name() = $lname]">
     <xsl:sort select="attribute::node()[namespace-uri() = $sort_ns and local-name() = $sort_lname]" order="{$sort_dir}" data-type="{$sort_type}"/>
     <xsl:value-of select="generate-id()"/>
     <xsl:value-of select="$do:_object_sep"/>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="descendant::*[namespace-uri() = $ns and local-name() = $lname]">
     <xsl:sort select="attribute::node()[namespace-uri() = $sort_ns and local-name() = $sort_lname]" order="{$sort_dir}" data-type="{$sort_type}"/>
     <xsl:value-of select="generate-id()"/>
     <xsl:value-of select="$do:_object_sep"/>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_sort_elements_by_element">
  <xsl:param name="expath"/>
  <xsl:param name="ns"/>
  <xsl:param name="lname"/>
  <xsl:param name="sort_ns"/>
  <xsl:param name="sort_lname"/>
  <xsl:param name="sort_dir"/>
  <xsl:param name="sort_type"/>
  <xsl:choose>
   <xsl:when test="starts-with($expath, $do:_path_sep)">
    <xsl:for-each select="/descendant::*[namespace-uri() = $ns and local-name() = $lname]">
     <xsl:sort select="*[namespace-uri() = $sort_ns and local-name() = $sort_lname]" order="{$sort_dir}" data-type="{$sort_type}"/>
     <xsl:value-of select="generate-id()"/>
     <xsl:value-of select="$do:_object_sep"/>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="descendant::*[namespace-uri() = $ns and local-name() = $lname]">
     <xsl:sort select="*[namespace-uri() = $sort_ns and local-name() = $sort_lname]" order="{$sort_dir}" data-type="{$sort_type}"/>
     <xsl:value-of select="generate-id()"/>
     <xsl:value-of select="$do:_object_sep"/>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_sort_elements_by_element_and_attribute">
  <xsl:param name="expath"/>
  <xsl:param name="ns"/>
  <xsl:param name="lname"/>
  <xsl:param name="sort_ns"/>
  <xsl:param name="sort_lname"/>
  <xsl:param name="sort_attr_ns"/>
  <xsl:param name="sort_attr_lname"/>
  <xsl:param name="sort_dir"/>
  <xsl:param name="sort_type"/>
  <xsl:choose>
   <xsl:when test="starts-with($expath, $do:_path_sep)">
    <xsl:for-each select="/descendant::*[namespace-uri() = $ns and local-name() = $lname]">
     <xsl:sort select="*[namespace-uri() = $sort_ns and local-name() = $sort_lname]/attribute::node()[namespace-uri() = $sort_attr_ns and local-name() = $sort_attr_lname]" order="{$sort_dir}" data-type="{$sort_type}"/>
     <xsl:value-of select="generate-id()"/>
     <xsl:value-of select="$do:_object_sep"/>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="descendant::*[namespace-uri() = $ns and local-name() = $lname]">
     <xsl:sort select="*[namespace-uri() = $sort_ns and local-name() = $sort_lname]/attribute::node()[namespace-uri() = $sort_attr_ns and local-name() = $sort_attr_lname]" order="{$sort_dir}" data-type="{$sort_type}"/>
     <xsl:value-of select="generate-id()"/>
     <xsl:value-of select="$do:_object_sep"/>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_sort_elements_without_sort_name">
  <xsl:param name="expath"/>
  <xsl:param name="ns"/>
  <xsl:param name="lname"/>
  <xsl:param name="sort_dir"/>
  <xsl:param name="sort_type"/>
  <xsl:choose>
   <xsl:when test="starts-with($expath, $do:_path_sep)">
    <xsl:for-each select="/descendant::*[namespace-uri() = $ns and local-name() = $lname]">
     <xsl:sort order="{$sort_dir}" data-type="{$sort_type}"/>
     <xsl:value-of select="generate-id()"/>
     <xsl:value-of select="$do:_object_sep"/>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="descendant::*[namespace-uri() = $ns and local-name() = $lname]">
     <xsl:sort order="{$sort_dir}" data-type="{$sort_type}"/>
     <xsl:value-of select="generate-id()"/>
     <xsl:value-of select="$do:_object_sep"/>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>


 <xsl:template name="do:_get_last_node_name">
  <xsl:param name="expath"/>
  <xsl:variable name="_next" select="substring-after($expath, $do:_path_sep)"/>
  <xsl:choose>
   <xsl:when test="string-length($_next) &gt; 0">
    <xsl:call-template name="do:_get_last_node_name">
     <xsl:with-param name="expath" select="$_next"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$expath"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_sort_selected_gids_rcr">
  <xsl:param name="selected_gids"/>
  <xsl:param name="sorted_gids"/>
  <xsl:variable name="_gid" select="substring-before($sorted_gids, $do:_object_sep)"/>
  <xsl:variable name="_next" select="substring-after($sorted_gids, $do:_object_sep)"/>
  <xsl:if test="string-length($_gid) &gt; 0">
   <xsl:if test="contains($selected_gids, concat($do:_object_sep, $_gid, $do:_object_sep))">
    <xsl:value-of select="$_gid"/>
    <xsl:value-of select="$do:_object_sep"/>
   </xsl:if>
   <xsl:call-template name="do:_sort_selected_gids_rcr">
    <xsl:with-param name="selected_gids" select="$selected_gids"/>
    <xsl:with-param name="sorted_gids" select="$_next"/>
   </xsl:call-template>
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
