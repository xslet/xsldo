<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:ut="https://github.com/xslet/2020/xslutil" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"><xsl:param name="_xsl_url"><xsl:call-template name="ut:get_xsl_url"/></xsl:param><xsl:param name="_xsl_dir"><xsl:call-template name="ut:get_dir_from_url"><xsl:with-param name="url" select="$_xsl_url"/></xsl:call-template></xsl:param><xsl:param name="DESIGN_COMMENT_PREFIX">**</xsl:param><xsl:param name="_eol" select="'&#xA;'"/><xsl:param name="ut:apos">'</xsl:param><xsl:param name="ut:quot">"</xsl:param><xsl:param name="ut:true" select="string(true())"/><xsl:param name="ut:unknown_namespace">&#x86;-&#x87;</xsl:param><xsl:template match="/xsl:stylesheet"><html><head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><meta http-equiv="X-UA-Compatible" content="ie=edge"/><title/><script src="{concat($_xsl_dir, '/xsldoc.js')}"/><link rel="stylesheet" href="{concat($_xsl_dir, '/xsldoc.css')}"/></head><body><header><xsl:call-template name="print_system_props"/></header><main><xsl:call-template name="print_page_title"/><xsl:call-template name="print_page_comment"/><xsl:call-template name="print_namespaces"/><xsl:call-template name="print_importings"/><xsl:call-template name="print_includings"/><xsl:call-template name="print_parameters"/><xsl:call-template name="print_elements"/><xsl:call-template name="print_functions"/></main><footer><xsl:call-template name="print_system_props"/></footer></body></html></xsl:template><xsl:template name="print_system_props"><div class="system-props"><span class="system-props-title">System Properties:</span><span class="system-prop-list"><span class="system-prop-item"><span class="system-prop-name">xsl:vendor</span><span class="system-prop-value"><xsl:value-of select="system-property('xsl:vendor')"/></span></span><span class="system-prop-item"><span class="system-prop-name">xsl:version</span><span class="system-prop-value"><xsl:value-of select="system-property('xsl:version')"/></span></span><span class="system-prop-item"><span class="system-prop-name">xsl:vendor-url</span><span class="system-prop-value"><xsl:value-of select="system-property('xsl:vendor-url')"/></span></span></span></div></xsl:template><xsl:template name="print_page_title"><h1/><script>xsldoc.printPageTitle()</script></xsl:template><xsl:template name="print_page_comment"><div class="comment page-desc"><xsl:call-template name="get_design_comment"/></div></xsl:template><xsl:template name="print_namespaces"><xsl:if test="boolean(namespace::*)"><section class="namespaces"><h2>Namespaces:</h2><div class="section-body namespace-list"><xsl:for-each select="namespace::*"><div class="namespace-item"><span class="namespace-prefix"><xsl:text>xmlns:</xsl:text><xsl:value-of select="name()"/></span><span class="namespace-uri"><xsl:value-of select="."/></span></div></xsl:for-each></div></section></xsl:if></xsl:template><xsl:template name="print_importings"><xsl:if test="boolean(xsl:import)"><section class="importings"><h2>Importings:</h2><div class="section-body importing-list"><xsl:for-each select="xsl:import"><div class="importing-item"><div class="importing-file"><a href="{concat($_xsl_dir,'/',@href)}"><xsl:value-of select="@href"/></a></div><div class="comment importing-desc"><xsl:variable name="_desc"><xsl:call-template name="get_design_comment"/></xsl:variable><xsl:choose><xsl:when test="string-length($_desc) != 0"><xsl:value-of select="$_desc"/></xsl:when><xsl:otherwise><xsl:for-each select="document(@href, /)/xsl:stylesheet"><xsl:call-template name="get_design_comment"/></xsl:for-each></xsl:otherwise></xsl:choose></div></div></xsl:for-each></div></section></xsl:if></xsl:template><xsl:template name="print_includings"><xsl:if test="boolean(//xsl:include)"><section class="including-section"><h2>Includings:</h2><div class="section-body including-list"><xsl:for-each select="//xsl:include"><div class="including-item"><span class="including-file"><a href="{concat($_xsl_dir,'/',@href)}"><xsl:value-of select="@href"/></a></span><span class="comment including-desc"><xsl:variable name="_desc"><xsl:call-template name="get_design_comment"/></xsl:variable><xsl:choose><xsl:when test="string-length($_desc) != 0"><xsl:value-of select="$_desc"/></xsl:when><xsl:otherwise><xsl:for-each select="document(@href, /)/xsl:stylesheet"><xsl:call-template name="get_design_comment"><xsl:with-param name="only_one_line" select="$ut:true"/></xsl:call-template></xsl:for-each></xsl:otherwise></xsl:choose></span></div></xsl:for-each></div></section></xsl:if></xsl:template><xsl:template name="print_parameters"><xsl:if test="boolean(xsl:param[not(starts-with(@name, '_')) and not(contains(@name, ':_'))])"><section class="parameters"><h2>Parameters:</h2><div class="section-body parameter-list"><xsl:for-each select="xsl:param"><xsl:choose><xsl:when test="starts-with(@name, '_')"/><xsl:when test="starts-with(substring-after(@name, ':'), '_')"/><xsl:otherwise><div class="parameter-item"><div class="parameter-name"><xsl:value-of select="@name"/></div><div class="comment parameter-desc"><xsl:call-template name="get_design_comment"/></div></div></xsl:otherwise></xsl:choose></xsl:for-each></div></section></xsl:if></xsl:template><xsl:template name="print_elements"><xsl:if test="boolean(xsl:template/@match)"><section class="elements"><h2>Elements:</h2><div class="section-body element-list"><xsl:for-each select="xsl:template[boolean(@match)]"><xsl:choose><xsl:when test="starts-with(@match, '_')"/><xsl:when test="starts-with(substring-after(@match, ':'), '_')"/><xsl:otherwise><div class="element-item"><div class="element-match"><xsl:value-of select="@match"/></div><div class="comment element-desc"><xsl:call-template name="get_design_comment"/></div><xsl:if test="boolean(xsl:param)"><div class="params element-param-list"><xsl:for-each select="xsl:param"><div class="element-param-item"><div class="element-param-name"><xsl:value-of select="@name"/></div><div class="comment element-param-desc"><xsl:call-template name="get_design_comment"/></div></div></xsl:for-each></div></xsl:if></div></xsl:otherwise></xsl:choose></xsl:for-each></div></section></xsl:if></xsl:template><xsl:template name="print_functions"><xsl:if test="boolean(xsl:template/@name[not(starts-with(., '_')) and not(contains(., ':_'))])"><section class="functions"><h2>Functions:</h2><div class="section-body function-list"><xsl:for-each select="xsl:template[boolean(@name)]"><xsl:choose><xsl:when test="starts-with(@name, '_')"/><xsl:when test="starts-with(substring-after(@name, ':'), '_')"/><xsl:otherwise><div class="function-item"><div class="function-name"><xsl:value-of select="@name"/></div><div class="comment function-desc"><xsl:call-template name="get_design_comment"/></div><xsl:if test="boolean(xsl:param)"><div class="params function-param-list"><xsl:for-each select="xsl:param"><div class="function-param-item"><div class="function-param-name"><xsl:value-of select="@name"/></div><div class="comment function-param-desc"><xsl:call-template name="get_design_comment"/></div></div></xsl:for-each></div></xsl:if></div></xsl:otherwise></xsl:choose></xsl:for-each></div></section></xsl:if></xsl:template><xsl:template name="get_design_comment"><!--** A flag to be set 'true' if printing only first iine. --><xsl:param name="only_first_line"/><xsl:variable name="_prev_comment"><xsl:call-template name="ut:trim_start"><xsl:with-param name="string"><xsl:call-template name="_get_prev_comment"/></xsl:with-param></xsl:call-template></xsl:variable><xsl:variable name="_prefix_len" select="string-length($DESIGN_COMMENT_PREFIX)"/><xsl:if test="starts-with($_prev_comment, $DESIGN_COMMENT_PREFIX)"><xsl:variable name="_s0" select="substring($_prev_comment, $_prefix_len + 1)"/><xsl:variable name="_s1"><xsl:call-template name="ut:trim_start"><xsl:with-param name="string" select="$_s0"/></xsl:call-template></xsl:variable><xsl:variable name="_s2"><xsl:call-template name="ut:replace"><xsl:with-param name="string" select="$_s1"/><xsl:with-param name="target" select="'&#xD;'"/><xsl:with-param name="replacement" select="$_eol"/></xsl:call-template><xsl:value-of select="$_eol"/></xsl:variable><xsl:value-of select="normalize-space(substring-before($_s2, $_eol))"/><xsl:choose><xsl:when test="$only_first_line = $ut:true"/><xsl:otherwise><xsl:variable name="_next" select="substring-after($_s2, $_eol)"/><xsl:call-template name="_get_design_comment_rcr"><xsl:with-param name="design_comment" select="$_next"/><xsl:with-param name="line_delimiter" select="$_eol"/></xsl:call-template></xsl:otherwise></xsl:choose></xsl:if></xsl:template><xsl:template name="_get_design_comment_rcr"><xsl:param name="design_comment"/><xsl:param name="line_delimiter"/><xsl:variable name="_line" select="normalize-space(substring-before($design_comment, $_eol))"/><xsl:variable name="_next" select="substring-after($design_comment, $_eol)"/><xsl:variable name="_prefix_len" select="string-length($DESIGN_COMMENT_PREFIX)"/><xsl:variable name="_line1" select="normalize-space($_line)"/><xsl:variable name="_line2"><xsl:choose><xsl:when test="starts-with($_line, $DESIGN_COMMENT_PREFIX)"><xsl:value-of select="normalize-space(substring($_line1, $_prefix_len + 1))"/></xsl:when><xsl:otherwise><xsl:value-of select="$_line1"/></xsl:otherwise></xsl:choose></xsl:variable><xsl:choose><xsl:when test="string-length($_line2) != 0"><xsl:choose><xsl:when test="string-length($line_delimiter) = 1"><br/></xsl:when><xsl:when test="string-length($line_delimiter) &gt;= 2"><br/><br/></xsl:when></xsl:choose><xsl:value-of select="$_line2"/><xsl:if test="string-length($_next) != 0"><xsl:call-template name="_get_design_comment_rcr"><xsl:with-param name="design_comment" select="$_next"/><xsl:with-param name="line_delimiter" select="'n'"/></xsl:call-template></xsl:if></xsl:when><xsl:otherwise><xsl:if test="string-length($_next) != 0"><xsl:call-template name="_get_design_comment_rcr"><xsl:with-param name="design_comment" select="$_next"/><xsl:with-param name="line_delimiter" select="concat($line_delimiter, 'n')"/></xsl:call-template></xsl:if></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="_get_prev_comment"><xsl:variable name="_prev_comment_id" select="generate-id(preceding-sibling::comment()[1])"/><xsl:variable name="_prev_node_id" select="generate-id(preceding-sibling::node()[1])"/><xsl:choose><xsl:when test="$_prev_comment_id = $_prev_node_id"><xsl:value-of select="preceding-sibling::comment()[1]"/></xsl:when><xsl:otherwise><xsl:variable name="_prev_2nd_node_id" select="generate-id(preceding-sibling::node()[2])"/><xsl:if test="$_prev_comment_id = $_prev_2nd_node_id"><xsl:variable name="_prev_text_id" select="generate-id(preceding-sibling::text()[1])"/><xsl:if test="$_prev_text_id = $_prev_node_id"><xsl:if test="string-length(normalize-space(preceding-sibling::text()[1])) = 0"><xsl:value-of select="preceding-sibling::comment()[1]"/></xsl:if></xsl:if></xsl:if></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="ut:count"><xsl:param name="string"/><xsl:param name="target"/><xsl:choose><xsl:when test="string-length($string) = 0">0</xsl:when><xsl:when test="string-length($target) = 0">0</xsl:when><xsl:when test="starts-with($string, $target)"><xsl:variable name="_count"><xsl:variable name="_next_bgn" select="string-length($target) + 1"/><xsl:call-template name="ut:count"><xsl:with-param name="string" select="substring($string, $_next_bgn)"/><xsl:with-param name="target" select="$target"/></xsl:call-template></xsl:variable><xsl:value-of select="$_count + 1"/></xsl:when><xsl:otherwise><xsl:call-template name="ut:count"><xsl:with-param name="string" select="substring($string, 2)"/><xsl:with-param name="target" select="$target"/></xsl:call-template></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="ut:ends_with"><xsl:param name="string"/><xsl:param name="suffix"/><xsl:variable name="_len1" select="string-length($suffix)"/><xsl:choose><xsl:when test="$_len1 = 0"><xsl:value-of select="$ut:true"/></xsl:when><xsl:otherwise><xsl:variable name="_len0" select="string-length($string)"/><xsl:variable name="_len2" select="$_len0 - $_len1"/><xsl:variable name="_ends" select="substring($string, $_len2 + 1)"/><xsl:if test="$_ends = $suffix"><xsl:value-of select="$ut:true"/></xsl:if></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="ut:get_dir_from_url"><xsl:param name="url"/><xsl:choose><xsl:when test="not(contains($url, '/'))">.</xsl:when><xsl:otherwise><xsl:call-template name="ut:_get_dir_from_url_r"><xsl:with-param name="url" select="$url"/></xsl:call-template></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="ut:_get_dir_from_url_r"><xsl:param name="url"/><xsl:value-of select="substring-before($url, '/')"/><xsl:variable name="suburl" select="substring-after($url, '/')"/><xsl:if test="string-length($suburl) &gt; 0"><xsl:variable name="subdir"><xsl:call-template name="ut:_get_dir_from_url_r"><xsl:with-param name="url" select="$suburl"/></xsl:call-template></xsl:variable><xsl:if test="string-length($subdir) &gt; 0"><xsl:value-of select="concat('/', $subdir)"/></xsl:if></xsl:if></xsl:template><xsl:template name="ut:get_namespace_uri"><xsl:param name="prefix"/><xsl:variable name="_ns" select="namespace::*[name() = $prefix]"/><xsl:choose><xsl:when test="string-length($_ns) &gt; 0"><xsl:value-of select="$_ns"/></xsl:when><xsl:otherwise><!-- Because Firefox does not support namespace axis --><xsl:variable name="_ns2" select="namespace-uri(//*[name() = concat($prefix,':',local-name())])"/><xsl:choose><xsl:when test="string-length($_ns2) &gt; 0"><xsl:value-of select="$_ns2"/></xsl:when><xsl:when test="string-length($prefix) &gt; 0"><xsl:value-of select="$ut:unknown_namespace"/></xsl:when></xsl:choose></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="ut:get_xsl_url"><xsl:param name="pi" select="/processing-instruction('xml-stylesheet')"/><xsl:variable name="QUOT">"</xsl:variable><xsl:variable name="APOS">'</xsl:variable><xsl:variable name="s1" select="substring-after($pi, 'href')"/><xsl:if test="normalize-space(substring-before($s1, '=')) = ''"><xsl:variable name="s2" select="substring-after($s1, '=')"/><xsl:choose><xsl:when test="substring($s2, 1, 1) = $QUOT"><xsl:value-of select="translate(substring-before(substring-after($s2, $QUOT), $QUOT), '\', '/')"/></xsl:when><xsl:when test="substring($s2, 1, 1) = $APOS"><xsl:value-of select="translate(substring-before(substring-after($s2, $APOS), $APOS), '\', '/')"/></xsl:when><xsl:otherwise><xsl:variable name="s3" select="normalize-space($s2)"/><xsl:choose><xsl:when test="substring($s3, 1, 1) = $QUOT"><xsl:value-of select="translate(substring-before(substring-after($s2, $QUOT), $QUOT), '\', '/')"/></xsl:when><xsl:when test="substring($s3, 1, 1) = $APOS"><xsl:value-of select="translate(substring-before(substring-after($s2, $APOS), $APOS), '\', '/')"/></xsl:when></xsl:choose></xsl:otherwise></xsl:choose></xsl:if></xsl:template><xsl:template name="ut:is_absolute_url"><xsl:param name="url"/><xsl:choose><xsl:when test="string-length($url) = 0"><xsl:value-of select="$ut:true"/></xsl:when><xsl:when test="contains($url, ':')"><xsl:value-of select="$ut:true"/></xsl:when><xsl:when test="starts-with($url, '/')"><xsl:value-of select="$ut:true"/></xsl:when></xsl:choose></xsl:template><xsl:template name="ut:repeat"><xsl:param name="string"/><xsl:param name="count"/><xsl:if test="$count &gt; 0"><xsl:value-of select="$string"/><xsl:call-template name="ut:repeat"><xsl:with-param name="string" select="$string"/><xsl:with-param name="count" select="$count - 1"/></xsl:call-template></xsl:if></xsl:template><xsl:template name="ut:replace"><xsl:param name="string"/><xsl:param name="target"/><xsl:param name="replacement"/><xsl:variable name="_lenT" select="string-length($target)"/><xsl:choose><xsl:when test="$_lenT = 0"><xsl:value-of select="$string"/></xsl:when><xsl:when test="starts-with($string, $target)"><xsl:value-of select="$replacement"/><xsl:call-template name="ut:replace"><xsl:with-param name="string" select="substring($string, $_lenT + 1)"/><xsl:with-param name="target" select="$target"/><xsl:with-param name="replacement" select="$replacement"/></xsl:call-template></xsl:when><xsl:otherwise><xsl:variable name="_before" select="substring-before($string, $target)"/><xsl:choose><xsl:when test="$_before = ''"><xsl:value-of select="$string"/></xsl:when><xsl:otherwise><xsl:variable name="_lenB" select="string-length($_before)"/><xsl:variable name="_posA" select="$_lenB + $_lenT + 1"/><xsl:value-of select="$_before"/><xsl:value-of select="$replacement"/><xsl:call-template name="ut:replace"><xsl:with-param name="string" select="substring($string, $_posA)"/><xsl:with-param name="target" select="$target"/><xsl:with-param name="replacement" select="$replacement"/></xsl:call-template></xsl:otherwise></xsl:choose></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="ut:trim_start"><xsl:param name="string"/><xsl:param name="target"/><xsl:variable name="_lenS" select="string-length($string)"/><xsl:variable name="_lenT" select="string-length($target)"/><xsl:choose><xsl:when test="$_lenS = 0"/><xsl:when test="$_lenT = 0"><xsl:variable name="_first" select="substring($string, 1, 1)"/><xsl:choose><xsl:when test="normalize-space($_first) = ''"><xsl:call-template name="ut:trim_start"><xsl:with-param name="string" select="substring($string, 2)"/></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="$string"/></xsl:otherwise></xsl:choose></xsl:when><xsl:otherwise><xsl:choose><xsl:when test="starts-with($string, $target)"><xsl:call-template name="ut:trim_start"><xsl:with-param name="string" select="substring($string, $_lenT + 1)"/><xsl:with-param name="target" select="$target"/></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="$string"/></xsl:otherwise></xsl:choose></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="ut:trim_end"><xsl:param name="string"/><xsl:param name="target"/><xsl:variable name="_lenS" select="string-length($string)"/><xsl:variable name="_lenT" select="string-length($target)"/><xsl:choose><xsl:when test="$_lenS = 0"/><xsl:when test="$_lenT = 0"><xsl:variable name="_last" select="substring($string, $_lenS, 1)"/><xsl:choose><xsl:when test="normalize-space($_last) = ''"><xsl:call-template name="ut:trim_end"><xsl:with-param name="string" select="substring($string, 1, $_lenS - 1)"/></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="$string"/></xsl:otherwise></xsl:choose></xsl:when><xsl:otherwise><xsl:choose><xsl:when test="substring($string, $_lenS - $_lenT + 1) = $target"><xsl:call-template name="ut:trim_end"><xsl:with-param name="string" select="substring($string, 1, $_lenS - $_lenT)"/><xsl:with-param name="target" select="$target"/></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="$string"/></xsl:otherwise></xsl:choose></xsl:otherwise></xsl:choose></xsl:template><xsl:template name="ut:trim"><xsl:param name="string"/><xsl:param name="target"/><xsl:variable name="_str"><xsl:call-template name="ut:trim_start"><xsl:with-param name="string" select="$string"/><xsl:with-param name="target" select="$target"/></xsl:call-template></xsl:variable><xsl:call-template name="ut:trim_end"><xsl:with-param name="string" select="$_str"/><xsl:with-param name="target" select="$target"/></xsl:call-template></xsl:template><xsl:template name="ut:validate"><xsl:param name="string"/><xsl:param name="forbidden"/><xsl:param name="default"/><xsl:variable name="_s" select="translate($string, $forbidden, '')"/><xsl:choose><xsl:when test="string-length($_s) = string-length($string)"><xsl:value-of select="$string"/></xsl:when><xsl:otherwise><xsl:value-of select="$default"/></xsl:otherwise></xsl:choose></xsl:template></xsl:stylesheet>