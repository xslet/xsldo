<?xml version="1.0" encoding="utf-8"?>
  
<xsl:stylesheet version="1.0"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
  Get expanded path of which namespace prefixies are replaced to namespace URIs.
 -->
 <xsl:template name="do:expand_path">
  <!--** A path to be expanded. -->
  <xsl:param name="path"/>
  <!--** A path separator. -->
  <xsl:param name="path_sep" select="$do:_path_sep"/>
  <xsl:choose>
   <xsl:when test="substring($path, 1, 1) = '/'">
    <xsl:value-of select="$path_sep"/>
    <xsl:call-template name="do:_expand_path_rcr">
     <xsl:with-param name="path" select="substring($path, 2)"/>
     <xsl:with-param name="path_sep" select="$path_sep"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="do:_expand_path_rcr">
     <xsl:with-param name="path" select="$path"/>
     <xsl:with-param name="path_sep" select="$path_sep"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_expand_path_rcr">
  <xsl:param name="path"/>
  <xsl:param name="path_sep"/>
  <xsl:choose>
   <xsl:when test="string-length($path) = 0"/>
   <xsl:when test="starts-with($path, '/')"><!-- path = '/bbb' in 'aaa//bbb' -->
    <xsl:variable name="_next" select="substring($path, 2)"/>
    <xsl:choose>
     <xsl:when test="string-length($_next) = 0"/>
     <xsl:otherwise>
      <xsl:call-template name="do:_format_node">
       <xsl:with-param name="localname">**</xsl:with-param>
       <xsl:with-param name="path_sep" select="$path_sep"/>
      </xsl:call-template>
      <xsl:call-template name="do:_expand_path_rcr">
       <xsl:with-param name="path" select="$_next"/>
       <xsl:with-param name="path_sep" select="$path_sep"/>
      </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <xsl:variable name="_first">
     <xsl:call-template name="do:_get_first_node">
      <xsl:with-param name="path" select="$path"/>
      <xsl:with-param name="path_sep" select="$path_sep"/>
     </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="do:_expand_first_node">
     <xsl:with-param name="name" select="$_first"/>
     <xsl:with-param name="path_sep" select="$path_sep"/>
    </xsl:call-template>
    <xsl:if test="string-length($_first) != 0">
     <xsl:variable name="_len" select="string-length($_first)"/>
     <xsl:variable name="_next" select="substring($path, $_len + 2)"/>
     <xsl:call-template name="do:_expand_path_rcr">
      <xsl:with-param name="path" select="$_next"/>
      <xsl:with-param name="path_sep" select="$path_sep"/>
     </xsl:call-template>
    </xsl:if>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_format_node">
  <xsl:param name="attr_mark"/>
  <xsl:param name="namespace"/>
  <xsl:param name="localname"/>
  <xsl:param name="condition"/>
  <xsl:param name="path_sep"/>
  <xsl:value-of select="$attr_mark"/>
  <xsl:value-of select="$namespace"/>
  <xsl:value-of select="$do:_ns_sep"/>
  <xsl:value-of select="$localname"/>
  <xsl:value-of select="$do:_cond_sep"/>
  <xsl:value-of select="$condition"/>
  <xsl:value-of select="$path_sep"/>
 </xsl:template>

 <xsl:template name="do:_get_first_node">
  <xsl:param name="path"/>
  <xsl:param name="path_sep"/>
  <xsl:variable name="_str0" select="substring-before($path, '/')"/>
  <xsl:variable name="_len0" select="string-length($_str0)"/>
  <xsl:choose>
   <xsl:when test="$_len0 = 0">
    <xsl:value-of select="$path"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:variable name="_str1" select="substring-after($_str0, '[')"/>
    <xsl:variable name="_len1" select="string-length($_str1)"/>
    <xsl:choose>
     <xsl:when test="$_len1 = 0 and substring($_str0, $_len0) != '['">
      <xsl:value-of select="$_str0"/>
     </xsl:when>
     <xsl:when test="contains($_str1, ']')">
      <xsl:value-of select="$_str0"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:variable name="_str2" select="substring($path, $_len0 + 1)"/>
      <xsl:variable name="_str3" select="substring-before($_str2, ']')"/>
      <xsl:variable name="_len3" select="string-length($_str3)"/>
      <xsl:choose>
       <xsl:when test="$_len3 = 0">
        <xsl:value-of select="$path"/>
       </xsl:when>
       <xsl:otherwise>
        <xsl:variable name="_str4" select="substring($_str2, $_len3 + 1)"/>
        <xsl:variable name="_str5" select="substring-before($_str4, '/')"/>
        <xsl:variable name="_len5" select="string-length($_str5)"/>
        <xsl:choose>
         <xsl:when test="$_len5 = 0">
          <xsl:value-of select="$path"/>
         </xsl:when>
         <xsl:otherwise>
          <xsl:variable name="_len" select="$_len0 + $_len3 + $_len5"/>
          <xsl:value-of select="substring($path, 1, $_len)"/>
         </xsl:otherwise>
        </xsl:choose>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_expand_first_node">
  <xsl:param name="name"/>
  <xsl:param name="path_sep"/>
  <xsl:variable name="_at">
   <xsl:if test="starts-with($name, '@')">@</xsl:if>
  </xsl:variable>
  <xsl:variable name="_str0">
   <xsl:choose>
    <xsl:when test="string-length($_at) = 0">
     <xsl:value-of select="$name"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="substring($name, 2)"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_str1" select="substring-before($_str0, '[')"/>
  <xsl:variable name="_len1" select="string-length($_str1)"/>
  <xsl:variable name="_str2">
   <xsl:choose>
    <xsl:when test="$_len1 = 0">
     <xsl:value-of select="$_str0"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$_str1"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_prefix" select="substring-before($_str2, ':')"/>
  <xsl:variable name="_ns">
   <xsl:call-template name="ut:get_namespace_uri">
    <xsl:with-param name="prefix" select="$_prefix"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_lname">
   <xsl:choose>
    <xsl:when test="string-length($_prefix) = 0">
     <xsl:value-of select="$_str2"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="substring($_str2, string-length($_prefix) + 2)"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_cond">
   <xsl:variable name="_str3" select="substring($_str0, $_len1 + 2)"/>
   <xsl:variable name="_len3" select="string-length($_str3)"/>
   <xsl:choose>
    <xsl:when test="substring($_str3, $_len3) = ']'">
     <xsl:value-of select="substring($_str3, 1, $_len3 - 1)"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="substring-before($_str3, ']')"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_expanded_cond">
   <xsl:call-template name="do:expand_path_in_condition">
    <xsl:with-param name="condition" select="$_cond"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="do:_format_node">
   <xsl:with-param name="attr_mark" select="$_at"/>
   <xsl:with-param name="namespace" select="$_ns"/>
   <xsl:with-param name="localname" select="$_lname"/>
   <xsl:with-param name="condition" select="$_expanded_cond"/>
   <xsl:with-param name="path_sep" select="$path_sep"/>
  </xsl:call-template>
 </xsl:template>

 <!--**
   Get a condition in which paths are expanded. 
 -->
 <xsl:template name="do:expand_path_in_condition">
  <!--** A condition. -->
  <xsl:param name="condition"/>
  <xsl:variable name="_cond0">
   <xsl:call-template name="ut:trim">
    <xsl:with-param name="string" select="$condition"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="string-length($_cond0) = 0"/>
   <xsl:otherwise>
    <xsl:variable name="_pos" select="number($_cond0)"/>
    <xsl:choose>
     <xsl:when test="boolean($_pos)">
      <xsl:value-of select="$_pos"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:call-template name="do:_expand_path_in_or_condition">
       <xsl:with-param name="conds" select="$_cond0"/>
      </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_expand_path_in_or_condition">
  <xsl:param name="conds"/>
  <xsl:choose>
   <xsl:when test="string-length($conds) = 0 or $conds = '|'"/>
   <xsl:otherwise>
    <xsl:variable name="_cond0">
     <xsl:call-template name="ut:trim_end">
      <xsl:with-param name="string" select="substring-before($conds, '|')"/>
     </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="_next0">
     <xsl:call-template name="ut:trim_start">
      <xsl:with-param name="string" select="substring-after($conds, '|')"/>
     </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
     <xsl:when test="string-length($_cond0) = 0 and string-length($_next0) = 0">
      <xsl:variable name="_cond1">
       <xsl:call-template name="do:_expand_path_in_and_condition">
        <xsl:with-param name="conds" select="$conds"/>
       </xsl:call-template>
      </xsl:variable>
      <xsl:if test="string-length($_cond1) != 0">
       <xsl:value-of select="$_cond1"/>
       <xsl:value-of select="$do:_cond_or_sep"/>
      </xsl:if>
     </xsl:when>
     <xsl:otherwise>
      <xsl:variable name="_cond1">
       <xsl:call-template name="do:_expand_path_in_and_condition">
        <xsl:with-param name="conds" select="$_cond0"/>
       </xsl:call-template>
      </xsl:variable>
      <xsl:if test="string-length($_cond1) != 0">
       <xsl:value-of select="$_cond1"/>
       <xsl:value-of select="$do:_cond_or_sep"/>
      </xsl:if>
      <xsl:call-template name="do:_expand_path_in_or_condition">
       <xsl:with-param name="conds" select="$_next0"/>
      </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_expand_path_in_and_condition">
  <xsl:param name="conds"/>
  <xsl:choose>
   <xsl:when test="string-length($conds) = 0 or $conds = ','"/>
   <xsl:otherwise>
    <xsl:variable name="_cond0">
     <xsl:call-template name="ut:trim_end">
      <xsl:with-param name="string" select="substring-before($conds, ',')"/>
     </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="_next0">
     <xsl:call-template name="ut:trim_start">
      <xsl:with-param name="string" select="substring-after($conds, ',')"/>
     </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
     <xsl:when test="string-length($_cond0) =0 and string-length($_next0) =0">
      <xsl:variable name="_cond1">
       <xsl:call-template name="do:_expand_path_in_single_condition">
        <xsl:with-param name="expr" select="$conds"/>
       </xsl:call-template>
      </xsl:variable>
      <xsl:if test="string-length($_cond1) != 0">
       <xsl:value-of select="$_cond1"/>
       <xsl:value-of select="$do:_cond_and_sep"/>
      </xsl:if>
     </xsl:when>
     <xsl:otherwise>
      <xsl:variable name="_cond1">
       <xsl:call-template name="do:_expand_path_in_single_condition">
        <xsl:with-param name="expr" select="$_cond0"/>
       </xsl:call-template>
      </xsl:variable>
      <xsl:if test="string-length($_cond1) != 0">
       <xsl:value-of select="$_cond1"/>
       <xsl:value-of select="$do:_cond_and_sep"/>
      </xsl:if>
      <xsl:call-template name="do:_expand_path_in_and_condition">
       <xsl:with-param name="conds" select="$_next0"/>
      </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="do:_expand_path_in_single_condition">
  <xsl:param name="expr"/>
  <xsl:call-template name="do:_expand_path_in_single_condition_by_op">
   <xsl:with-param name="expr" select="$expr"/>
   <xsl:with-param name="op_mark">
    <xsl:choose>
     <xsl:when test="contains($expr, '!=')">!=</xsl:when>
     <xsl:when test="contains($expr, '=')">=</xsl:when>
     <xsl:when test="contains($expr, ' eq ')"> eq </xsl:when>
     <xsl:when test="contains($expr, ' ne ')"> ne </xsl:when>
     <xsl:when test="contains($expr, ' gt ')"> gt </xsl:when>
     <xsl:when test="contains($expr, ' ge ')"> ge </xsl:when>
     <xsl:when test="contains($expr, ' lt ')"> lt </xsl:when>
     <xsl:when test="contains($expr, ' le ')"> le </xsl:when>
    </xsl:choose>
   </xsl:with-param>
   <xsl:with-param name="op">
    <xsl:choose>
     <xsl:when test="contains($expr, '!=')">ne</xsl:when>
     <xsl:when test="contains($expr, '=')">eq</xsl:when>
     <xsl:when test="contains($expr, ' eq ')">eq</xsl:when>
     <xsl:when test="contains($expr, ' ne ')">ne</xsl:when>
     <xsl:when test="contains($expr, ' gt ')">gt</xsl:when>
     <xsl:when test="contains($expr, ' ge ')">ge</xsl:when>
     <xsl:when test="contains($expr, ' lt ')">lt</xsl:when>
     <xsl:when test="contains($expr, ' le ')">le</xsl:when>
    </xsl:choose>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>

 <xsl:template name="do:_expand_path_in_single_condition_by_op">
  <xsl:param name="expr"/>
  <xsl:param name="op_mark"/>
  <xsl:param name="op"/>
  <xsl:variable name="_path">
   <xsl:call-template name="ut:trim_end">
    <xsl:with-param name="string" select="substring-before($expr, $op_mark)"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="do:expand_path">
   <xsl:with-param name="path" select="$_path"/>
   <xsl:with-param name="path_sep" select="$do:_cond_path_sep"/>
  </xsl:call-template>
  <xsl:value-of select="$do:_cond_op_sep"/>
  <xsl:value-of select="$op"/>
  <xsl:value-of select="$do:_cond_op_sep"/>
  <xsl:call-template name="ut:trim_start">
   <xsl:with-param name="string" select="substring-after($expr, $op_mark)"/>
  </xsl:call-template>
 </xsl:template>

</xsl:stylesheet>
