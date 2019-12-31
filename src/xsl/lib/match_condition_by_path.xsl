<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Tests if a given condition matches.
 -->
 <xsl:template name="do:match_condition_by_path">
  <!--** A condition. -->
  <xsl:param name="condition"/>
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generate-id of a base node. -->
  <xsl:param name="data_gid"/>
  <xsl:variable name="_cond_by_expath">
   <xsl:call-template name="do:expand_path_in_condition">
    <xsl:with-param name="condition" select="$condition"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="string-length($data_url) = 0">
    <xsl:choose>
     <xsl:when test="string-length($data_gid) = 0">
      <xsl:call-template name="do:match_condition_by_expath">
       <xsl:with-param name="condition" select="$_cond_by_expath"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
      <xsl:for-each select="//attribute::node()[generate-id() = $data_gid]">
       <xsl:call-template name="do:match_condition_by_expath">
        <xsl:with-param name="condition" select="$_cond_by_expath"/>
       </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="//*[generate-id() = $data_gid]">
       <xsl:call-template name="do:match_condition_by_expath">
        <xsl:with-param name="condition" select="$_cond_by_expath"/>
       </xsl:call-template>
      </xsl:for-each>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="document($data_url, /)">
     <xsl:choose>
      <xsl:when test="string-length($data_gid) = 0">
       <xsl:call-template name="do:match_condition_by_expath">
        <xsl:with-param name="condition" select="$_cond_by_expath"/>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <xsl:for-each select="//attribute::node()[generate-id() = $data_gid]">
        <xsl:call-template name="do:match_condition_by_expath">
         <xsl:with-param name="condition" select="$_cond_by_expath"/>
        </xsl:call-template>
       </xsl:for-each>
       <xsl:for-each select="//*[generate-id() = $data_gid]">
        <xsl:call-template name="do:match_condition_by_expath">
         <xsl:with-param name="condition" select="$_cond_by_expath"/>
        </xsl:call-template>
       </xsl:for-each>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
