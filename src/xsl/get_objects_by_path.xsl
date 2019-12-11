<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Gets either values, names or generated-ids of nodes at a specified path.
 -->
 <xsl:template name="do:get_objects_by_path">
  <!--** A path. -->
  <xsl:param name="path"/>
  <!--** Kind of objects. -->
  <xsl:param name="what"/>
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
  <xsl:call-template name="do:get_objects_by_expath">
   <xsl:with-param name="expath" select="$_expath"/>
   <xsl:with-param name="what" select="$what"/>
   <xsl:with-param name="prefix" select="$prefix"/>
   <xsl:with-param name="suffix" select="$suffix"/>
   <xsl:with-param name="data_url" select="$data_url"/>
   <xsl:with-param name="data_gid" select="$data_gid"/>
  </xsl:call-template>
 </xsl:template>

 <!--**
   Gets either values, names or generated-ids of nodes by an expanded path.
 -->
 <xsl:template name="do:get_objects_by_expath">
  <!--** An expanded path. -->
  <xsl:param name="expath"/>
  <!--** Kind of objects. -->
  <xsl:param name="what"/>
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
      <xsl:call-template name="do:_get_objects_by_expath_from_current_node">
       <xsl:with-param name="expath" select="$expath"/>
       <xsl:with-param name="what" select="$what"/>
       <xsl:with-param name="prefix" select="$prefix"/>
       <xsl:with-param name="suffix" select="$suffix"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
      <xsl:for-each select="//attribute::node()[generate-id() = $data_gid]">
       <xsl:call-template name="do:_get_objects_by_expath_from_current_node">
        <xsl:with-param name="expath" select="$expath"/>
        <xsl:with-param name="what" select="$what"/>
        <xsl:with-param name="prefix" select="$prefix"/>
        <xsl:with-param name="suffix" select="$suffix"/>
       </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//*[generate-id() = $data_gid]">
       <xsl:call-template name="do:_get_objects_by_expath_from_current_node">
        <xsl:with-param name="expath" select="$expath"/>
        <xsl:with-param name="what" select="$what"/>
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
       <xsl:call-template name="do:_get_objects_by_expath_from_current_node">
        <xsl:with-param name="expath" select="$expath"/>
        <xsl:with-param name="what" select="$what"/>
        <xsl:with-param name="prefix" select="$prefix"/>
        <xsl:with-param name="suffix" select="$suffix"/>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <xsl:for-each select="//attribute::node()[generate-id() = $data_gid]">
        <xsl:call-template name="do:_get_objects_by_expath_from_current_node">
         <xsl:with-param name="expath" select="$expath"/>
         <xsl:with-param name="what" select="$what"/>
         <xsl:with-param name="prefix" select="$prefix"/>
         <xsl:with-param name="suffix" select="$suffix"/>
        </xsl:call-template>
       </xsl:for-each>
       <xsl:for-each select="//*[generate-id() = $data_gid]">
        <xsl:call-template name="do:_get_objects_by_expath_from_current_node">
         <xsl:with-param name="expath" select="$expath"/>
         <xsl:with-param name="what" select="$what"/>
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

 <xsl:template name="do:_get_objects_by_expath_from_current_node">
  <xsl:param name="expath"/>
  <xsl:param name="what"/>
  <xsl:param name="prefix"/>
  <xsl:param name="suffix"/>
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:param name="path_sep" select="$do:_path_sep"/>
  <xsl:choose>
   <xsl:when test="starts-with($expath, $path_sep)">
    <xsl:for-each select="/">
     <xsl:variable name="_next" select="substring-after($expath, $path_sep)"/>
     <xsl:call-template name="do:_get_objects_by_expath_rcr">
      <xsl:with-param name="expath" select="$_next"/>
      <xsl:with-param name="what" select="$what"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
      <xsl:with-param name="path_sep" select="$path_sep"/>
     </xsl:call-template>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="do:_get_objects_by_expath_rcr">
     <xsl:with-param name="expath" select="$expath"/>
     <xsl:with-param name="what" select="$what"/>
     <xsl:with-param name="prefix" select="$prefix"/>
     <xsl:with-param name="suffix" select="$suffix"/>
     <xsl:with-param name="path_sep" select="$path_sep"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_get_objects_by_expath_rcr">
  <xsl:param name="expath"/>
  <xsl:param name="what"/>
  <xsl:param name="prefix"/>
  <xsl:param name="suffix"/>
  <xsl:param name="path_sep"/>
  <xsl:choose>
   <xsl:when test="$expath = ''">
    <xsl:call-template name="do:get_current_value">
     <xsl:with-param name="what" select="$what"/>
     <xsl:with-param name="prefix" select="$prefix"/>
     <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:variable name="_nd0" select="substring-before($expath, $path_sep)"/>
    <xsl:variable name="_next" select="substring-after($expath, $path_sep)"/>
    <xsl:variable name="_at">
     <xsl:if test="starts-with($_nd0, '@')">
      <xsl:value-of select="$ut:true"/>
     </xsl:if>
    </xsl:variable>
    <xsl:variable name="_nd1">
     <xsl:choose>
      <xsl:when test="$_at = $ut:true">
       <xsl:value-of select="substring($_nd0, 2)"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="$_nd0"/>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:variable>
    <xsl:variable name="_ns" select="substring-before($_nd1, $do:_ns_sep)"/>
    <xsl:variable name="_nd2" select="substring-after($_nd1, $do:_ns_sep)"/>
    <xsl:variable name="_lnm" select="substring-before($_nd2, $do:_cond_sep)"/>
    <xsl:variable name="_cnd" select="substring-after($_nd2, $do:_cond_sep)"/>
    <xsl:call-template name="do:_resolve_namespace_and_localname">
     <xsl:with-param name="is_attr" select="$_at"/>
     <xsl:with-param name="namespace" select="$_ns"/>
     <xsl:with-param name="localname" select="$_lnm"/>
     <xsl:with-param name="condition" select="$_cnd"/>
     <xsl:with-param name="next_expath" select="$_next"/>
     <xsl:with-param name="what" select="$what"/>
     <xsl:with-param name="prefix" select="$prefix"/>
     <xsl:with-param name="suffix" select="$suffix"/>
     <xsl:with-param name="path_sep" select="$path_sep"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_resolve_namespace_and_localname">
  <xsl:param name="is_attr"/>
  <xsl:param name="namespace"/>
  <xsl:param name="localname"/>
  <xsl:param name="condition"/>
  <xsl:param name="next_expath"/>
  <xsl:param name="what"/>
  <xsl:param name="prefix"/>
  <xsl:param name="suffix"/>
  <xsl:param name="path_sep"/>
  <xsl:choose>
   <xsl:when test="$is_attr = $ut:true">
    <xsl:if test="string-length($next_expath) = 0">
     <xsl:for-each select="attribute::node()[$namespace = namespace-uri() and $localname = local-name()]">
      <xsl:call-template name="do:_get_conditional_attribute">
       <xsl:with-param name="condition" select="$condition"/>
       <xsl:with-param name="next_expath" select="$next_expath"/>
       <xsl:with-param name="what" select="$what"/>
       <xsl:with-param name="prefix" select="$prefix"/>
       <xsl:with-param name="suffix" select="$suffix"/>
      </xsl:call-template>
     </xsl:for-each>
    </xsl:if>
   </xsl:when>
   <xsl:when test="$localname = '*'">
    <xsl:choose>
     <xsl:when test="string-length($namespace) = 0">
      <xsl:for-each select="*">
       <xsl:call-template name="do:_get_conditional_object">
        <xsl:with-param name="condition" select="$condition"/>
        <xsl:with-param name="next_expath" select="$next_expath"/>
        <xsl:with-param name="what" select="$what"/>
        <xsl:with-param name="prefix" select="$prefix"/>
        <xsl:with-param name="suffix" select="$suffix"/>
        <xsl:with-param name="path_sep" select="$path_sep"/>
       </xsl:call-template>
      </xsl:for-each>
     </xsl:when>
     <xsl:otherwise>
      <xsl:for-each select="*[namespace-uri() = $namespace]">
       <xsl:call-template name="do:_get_conditional_object">
        <xsl:with-param name="condition" select="$condition"/>
        <xsl:with-param name="next_expath" select="$next_expath"/>
        <xsl:with-param name="what" select="$what"/>
        <xsl:with-param name="prefix" select="$prefix"/>
        <xsl:with-param name="suffix" select="$suffix"/>
        <xsl:with-param name="path_sep" select="$path_sep"/>
       </xsl:call-template>
      </xsl:for-each>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:when test="$localname = '**'">
    <xsl:choose>
     <xsl:when test="string-length($namespace) = 0">
      <xsl:for-each select="descendant::*">
       <xsl:call-template name="do:_get_conditional_object">
        <xsl:with-param name="condition" select="$condition"/>
        <xsl:with-param name="next_expath" select="$next_expath"/>
        <xsl:with-param name="what" select="$what"/>
        <xsl:with-param name="prefix" select="$prefix"/>
        <xsl:with-param name="suffix" select="$suffix"/>
        <xsl:with-param name="path_sep" select="$path_sep"/>
       </xsl:call-template>
      </xsl:for-each>
     </xsl:when>
     <xsl:otherwise>
      <xsl:for-each select="descendant::*[namespace-uri() = $namespace]">
       <xsl:call-template name="do:_get_conditional_object">
        <xsl:with-param name="condition" select="$condition"/>
        <xsl:with-param name="next_expath" select="$next_expath"/>
        <xsl:with-param name="what" select="$what"/>
        <xsl:with-param name="prefix" select="$prefix"/>
        <xsl:with-param name="suffix" select="$suffix"/>
        <xsl:with-param name="path_sep" select="$path_sep"/>
       </xsl:call-template>
      </xsl:for-each>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:when test="$localname = '.'">
    <xsl:call-template name="do:_get_conditional_object">
     <xsl:with-param name="condition" select="$condition"/>
     <xsl:with-param name="next_expath" select="$next_expath"/>
     <xsl:with-param name="what" select="$what"/>
     <xsl:with-param name="prefix" select="$prefix"/>
     <xsl:with-param name="suffix" select="$suffix"/>
     <xsl:with-param name="path_sep" select="$path_sep"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:when test="$localname = '..'">
    <xsl:choose>
     <xsl:when test="string-length($namespace) = 0">
      <xsl:for-each select="parent::*">
       <xsl:call-template name="do:_get_conditional_object">
        <xsl:with-param name="condition" select="$condition"/>
        <xsl:with-param name="next_expath" select="$next_expath"/>
        <xsl:with-param name="what" select="$what"/>
        <xsl:with-param name="prefix" select="$prefix"/>
        <xsl:with-param name="suffix" select="$suffix"/>
        <xsl:with-param name="path_sep" select="$path_sep"/>
       </xsl:call-template>
      </xsl:for-each>
     </xsl:when>
     <xsl:otherwise>
      <xsl:for-each select="parent::*[namespace-uri() = $namespace]">
       <xsl:call-template name="do:_get_conditional_object">
        <xsl:with-param name="condition" select="$condition"/>
        <xsl:with-param name="next_expath" select="$next_expath"/>
        <xsl:with-param name="what" select="$what"/>
        <xsl:with-param name="prefix" select="$prefix"/>
        <xsl:with-param name="suffix" select="$suffix"/>
        <xsl:with-param name="path_sep" select="$path_sep"/>
       </xsl:call-template>
      </xsl:for-each>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="*[namespace-uri() = $namespace and local-name() = $localname]">
     <xsl:call-template name="do:_get_conditional_object">
      <xsl:with-param name="condition" select="$condition"/>
      <xsl:with-param name="next_expath" select="$next_expath"/>
      <xsl:with-param name="what" select="$what"/>
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
      <xsl:with-param name="path_sep" select="$path_sep"/>
     </xsl:call-template>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!--**
   Gets a value of the current node.
 -->
 <xsl:template name="do:get_current_value">
  <!--** Kind of objects. -->
  <xsl:param name="what"/>
  <!--** A prefix for each object. -->
  <xsl:param name="prefix"/>
  <!--** A suffix for each object. -->
  <xsl:param name="suffix"/>
  <xsl:value-of select="$prefix"/>
  <xsl:choose>
   <xsl:when test="$what = 'content'">
    <xsl:value-of select="normalize-space(.)"/>
   </xsl:when>
   <xsl:when test="$what = 'text'">
    <xsl:value-of select="normalize-space(text())"/>
   </xsl:when>
   <xsl:when test="$what = 'number'">
    <xsl:value-of select="number(text())"/>
   </xsl:when>
   <xsl:when test="$what = 'name'">
    <xsl:value-of select="local-name()"/>
   </xsl:when>
   <xsl:when test="$what = 'id'">
    <xsl:value-of select="generate-id()"/>
   </xsl:when>
   <xsl:when test="$what = 'preceding-comment'">
    <xsl:call-template name="do:_get_preceding_comment"/>
   </xsl:when>
   <xsl:when test="$what = 'following-comment'">
    <xsl:call-template name="do:_get_following_comment"/>
   </xsl:when>
  </xsl:choose>
  <xsl:value-of select="$suffix"/>
 </xsl:template>

 <xsl:template name="do:_get_preceding_comment">
  <xsl:variable name="_nid1" select="generate-id(preceding-sibling::node()[1])"/>
  <xsl:variable name="_cid1" select="generate-id(preceding-sibling::comment()[1])"/>
  <xsl:choose>
   <xsl:when test="$_nid1 = $_cid1">
    <xsl:value-of select="preceding-sibling::comment()[1]"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:variable name="_tid1" select="generate-id(preceding-sibling::text()[1])"/>
    <xsl:if test="$_nid1 = $_tid1">
     <xsl:if test="string-length(normalize-space(preceding-sibling::text()[1])) = 0">
      <xsl:variable name="_nid2" select="generate-id(preceding-sibling::node()[2])"/>
      <xsl:if test="$_nid2 = $_cid1">
       <xsl:value-of select="preceding-sibling::comment()[1]"/>
      </xsl:if>
     </xsl:if>
    </xsl:if>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_get_following_comment">
  <xsl:variable name="_nid1" select="generate-id(following-sibling::node()[1])"/>
  <xsl:variable name="_cid1" select="generate-id(following-sibling::comment()[1])"/>
  <xsl:choose>
   <xsl:when test="$_nid1 = $_cid1">
    <xsl:value-of select="following-sibling::comment()[1]"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:variable name="_tid1" select="generate-id(following-sibling::text()[1])"/>
    <xsl:if test="$_nid1 = $_tid1">
     <xsl:if test="string-length(normalize-space(following-sibling::text()[1])) = 0">
      <xsl:variable name="_nid2" select="generate-id(following-sibling::node()[2])"/>
      <xsl:if test="$_nid2 = $_cid1">
       <xsl:value-of select="following-sibling::comment()[1]"/>
      </xsl:if>
     </xsl:if>
    </xsl:if>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!--**
   Gets a value of the current attribute.
 -->
 <xsl:template name="do:get_current_attribute">
  <!--** Kind of objects. -->
  <xsl:param name="what"/>
  <!--** A prefix for each object. -->
  <xsl:param name="prefix"/>
  <!--** A suffix for each object. -->
  <xsl:param name="suffix"/>
  <xsl:value-of select="$prefix"/>
  <xsl:choose>
   <xsl:when test="$what = 'content'">
    <xsl:value-of select="."/>
   </xsl:when>
   <xsl:when test="$what = 'text'">
    <xsl:value-of select="."/>
   </xsl:when>
   <xsl:when test="$what = 'number'">
    <xsl:value-of select="number()"/>
   </xsl:when>
   <xsl:when test="$what = 'name'">
    <xsl:value-of select="local-name()"/>
   </xsl:when>
   <xsl:when test="$what = 'id'">
    <xsl:value-of select="generate-id()"/>
   </xsl:when>
  </xsl:choose>
  <xsl:value-of select="$suffix"/>
 </xsl:template>

 <xsl:template name="do:_get_conditional_attribute">
  <xsl:param name="condition"/>
  <xsl:param name="next_expath"/>
  <xsl:param name="what"/>
  <xsl:param name="prefix"/>
  <xsl:param name="suffix"/>
  <xsl:variable name="_matched">
   <xsl:call-template name="do:match_condition">
    <xsl:with-param name="condition" select="$condition"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:if test="$_matched = $ut:true and string-length($next_expath) = 0">
   <xsl:call-template name="do:get_current_attribute">
    <xsl:with-param name="what" select="$what"/>
    <xsl:with-param name="prefix" select="$prefix"/>
    <xsl:with-param name="suffix" select="$suffix"/>
   </xsl:call-template>
  </xsl:if>
 </xsl:template>

 <xsl:template name="do:_get_conditional_object">
  <xsl:param name="condition"/>
  <xsl:param name="next_expath"/>
  <xsl:param name="what"/>
  <xsl:param name="prefix"/>
  <xsl:param name="suffix"/>
  <xsl:param name="path_sep"/>
  <xsl:variable name="_matched">
   <xsl:call-template name="do:match_condition">
    <xsl:with-param name="condition" select="$condition"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:if test="$_matched = $ut:true">
   <xsl:call-template name="do:_get_objects_by_expath_rcr">
    <xsl:with-param name="expath" select="$next_expath"/>
    <xsl:with-param name="what" select="$what"/>
    <xsl:with-param name="prefix" select="$prefix"/>
    <xsl:with-param name="suffix" select="$suffix"/>
    <xsl:with-param name="path_sep" select="$path_sep"/>
   </xsl:call-template>
  </xsl:if>
 </xsl:template>

 <!--**
   Tests a singile/combined condition using expanded paths.
 -->
 <xsl:template name="do:match_condition">
  <!--** a single/combined condition. -->
  <xsl:param name="condition"/>
  <xsl:variable name="_cond0">
   <xsl:call-template name="ut:trim">
    <xsl:with-param name="string" select="$condition"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="string-length($_cond0) = 0">
    <xsl:value-of select="$ut:true"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:variable name="_pos" select="number($_cond0)"/>
    <xsl:choose>
     <xsl:when test="boolean($_pos)">
      <xsl:if test="$_pos = position()">
       <xsl:value-of select="$ut:true"/>
      </xsl:if>
     </xsl:when>
     <xsl:otherwise>
      <xsl:call-template name="do:_match_conditions_or">
       <xsl:with-param name="conds" select="$_cond0"/>
      </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_match_conditions_or">
  <xsl:param name="conds"/>
  <xsl:choose>
   <xsl:when test="string-length($conds) = 0"/>
   <xsl:otherwise>
    <xsl:variable name="_cond" select="substring-before($conds, $do:_cond_or_sep)"/>
    <xsl:variable name="_matched">
     <xsl:call-template name="do:_match_conditions_and">
      <xsl:with-param name="conds" select="$_cond"/>
     </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
     <xsl:when test="$_matched = $ut:true">
      <xsl:value-of select="$ut:true"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:variable name="_next" select="substring-after($conds, $do:_cond_or_sep)"/>
      <xsl:call-template name="do:_match_conditions_or">
       <xsl:with-param name="conds" select="$_next"/>
      </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_match_conditions_and">
  <xsl:param name="conds"/>
  <xsl:choose>
   <xsl:when test="string-length($conds) = 0"/>
   <xsl:otherwise>
    <xsl:variable name="_cond" select="substring-before($conds, $do:_cond_and_sep)"/>
    <xsl:variable name="_matched">
     <xsl:call-template name="do:_match_single_condition">
      <xsl:with-param name="cond" select="$_cond"/>
     </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$_matched = $ut:true">
     <xsl:variable name="_next" select="substring-after($conds, $do:_cond_and_sep)"/>
     <xsl:choose>
      <xsl:when test="string-length($_next) = 0">
       <xsl:value-of select="$ut:true"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:call-template name="do:_match_conditions_and">
        <xsl:with-param name="conds" select="$_next"/>
       </xsl:call-template>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:if>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_match_single_condition">
  <xsl:param name="cond"/>
  <xsl:variable name="_lefts">
   <xsl:variable name="_e0" select="substring-before($cond, $do:_cond_op_sep)"/>
   <xsl:variable name="_e1">
    <xsl:call-template name="ut:trim_end">
     <xsl:with-param name="string" select="$_e0"/>
    </xsl:call-template>
   </xsl:variable>
   <xsl:call-template name="do:_get_objects_by_expath_from_current_node">
    <xsl:with-param name="expath" select="$_e1"/>
    <xsl:with-param name="what">content</xsl:with-param>
    <xsl:with-param name="suffix" select="$do:_object_sep"/>
    <xsl:with-param name="path_sep" select="$do:_cond_path_sep"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_s0" select="substring-after($cond, $do:_cond_op_sep)"/>
  <xsl:variable name="_op" select="substring-before($_s0, $do:_cond_op_sep)"/>
  <xsl:variable name="_right">
   <xsl:variable name="_r0" select="substring-after($_s0, $do:_cond_op_sep)"/>
   <xsl:call-template name="ut:trim_start">
    <xsl:with-param name="string" select="$_r0"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="do:_operate_expression_rcr">
   <xsl:with-param name="lefts" select="$_lefts"/>
   <xsl:with-param name="op" select="$_op"/>
   <xsl:with-param name="right" select="$_right"/>
  </xsl:call-template>
 </xsl:template>

 <xsl:template name="do:_operate_expression_rcr">
  <xsl:param name="lefts"/>
  <xsl:param name="op"/>
  <xsl:param name="right"/>
  <xsl:choose>
   <xsl:when test="string-length($lefts) = 0"/>
   <xsl:otherwise>
    <xsl:variable name="_left" select="substring-before($lefts, $do:_object_sep)"/>
    <xsl:variable name="_result">
     <xsl:call-template name="do:operate_expression">
      <xsl:with-param name="left" select="$_left"/>
      <xsl:with-param name="op" select="$op"/>
      <xsl:with-param name="right" select="$right"/>
     </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
     <xsl:when test="$_result = $ut:true">
      <xsl:value-of select="$ut:true"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:variable name="_nx" select="substring-after($lefts, $do:_object_sep)"/>
      <xsl:call-template name="do:_operate_expression_rcr">
       <xsl:with-param name="lefts" select="$_nx"/>
       <xsl:with-param name="op" select="$op"/>
       <xsl:with-param name="right" select="$right"/>
      </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
