# [@xslet/xsldo][repo-url] ![Version][ver-image] [![Github.io][io-image]][io-url] [![MIT License][mit-image]][mit-url]

XML data operation libraries for XSLT programs on Web browsers.


## Namespace

`xmlns:do="https://github.com/xslet/2020/xsldo"`


## API

The API document of this program is [here][api-url].


## List

* [`do:count_nodes_by_path`](#usage_count_nodes_by_path)
* [`do:first_object_by_path`](#usage_first_object_by_path)
* [`do:get_objects_by_path`](#usage_get_objects_by_path)
* [`do:for_by_path`](#usage_for_by_path)
* [`do:for_times`](#usage_for_times)


## Usage

<a name="usage_count_nodes_by_path"></a>
### `do:count_nodes_by_path`

Counts elements/attributes at a specified path.

**Example:**

```
<?xml version="1.0" encoding="utf-8"?>
<!-- count.xsl -->
<xsl:stylesheet version="1.0"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="xsldo.xsl"/>

 <xsl:template match="/top">
  <html>
   <body>
    <xsl:apply-templates select="count"/>
   </body>
  </html>
 </xsl:template>

 <xsl:template match="count">
  <xsl:call-template name="do:count_nodes_by_path">
   <xsl:with-param name="path" select="@path"/>
   <xsl:with-param name="data_url" select="@file"/>
   <xsl:with-param name="prefix">(</xsl:with-param>
   <xsl:with-param name="suffix">)</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>
```

By using the above XSL file, the following XML file prints `(3)` on your Web browser.

```
<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="application/xml" href="count.xsl"?>
<!-- count.xml -->
<top>
  <count path="//aaa/bbb"/>
  <!-- Outputs '(3)' -->
  
  <aaa>
    <bbb>ABC1</bbb>
    <bbb>ABC2</bbb>
  </aaa>
  <aaa>
    <bbb>ABC3</bbb>
  </aaa>
</top>
```

Also, the following XML file prints `(4)` by using an external XML file.

```
<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="application/xml" href="count.xsl"?>
<!-- count_f.xml -->
<top>
  <count path="//aaa/bbb" file="external.xml"/>
  <!-- Outputs '(4)' -->
</top>
```

```
<?xml version="1.0" encoding="utf-8"?>
<!-- external.xml -->
<top>
  <aaa>
    <bbb>DEF1</bbb>
    <bbb>DEF2</bbb>
  </aaa>
  <aaa>
    <bbb>DEF3</bbb>
    <bbb>DEF4</bbb>
  </aaa>
</top>
```

<a name="usage_first_object_by_path"></a>
### `do:first_object_by_path`

Gets either a value, a name, a generated-id or a comment of first element/attribute at a specified path.

**Example:**

```
<?xml version="1.0" encoding="utf-8"?>
<!-- first.xsl -->
<xsl:stylesheet version="1.0"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
 <xsl:import href="xsldo.xsl"/>
  
 <xsl:template match="/top">
  <html>
   <body>
    <xsl:apply-templates select="first"/>
   </body>
  </html>
 </xsl:template>

 <xsl:template match="first">
  <xsl:call-template name="do:first_object_by_path">
   <xsl:with-param name="path" select="@path"/>
   <xsl:with-param name="data_url" select="@file"/>
   <xsl:with-param name="what">text</xsl:with-param>
   <xsl:with-param name="prefix">(</xsl:with-param>
   <xsl:with-param name="suffix">)</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>
```

By using the above XSL file, the following XML file prints `(ABC1)` on your Web browser.

```
<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="application/xml" href="first.xsl"?>
<!-- first.xml -->
<top>
  <first path="//aaa/bbb"/>
  <!-- Outputs '(ABC1)' -->

  <aaa>
    <bbb>ABC1</bbb>
    <bbb>ABC2</bbb>
  </aaa>
  <aaa>
    <bbb>ABC3</bbb>
  </aaa>
</top>
```

Also, the following XML file prints `(DEF1)` by using an external XML file.

```
<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="application/xml" href="first.xsl"?>
<!-- first_f.xml -->
<top>
  <first path="//aaa/bbb" file="external.xml"/>
  <!-- Outputs '(DEF1)' -->
</top>
```

```
<?xml version="1.0" encoding="utf-8"?>
<!-- external.xml -->
<top>
  <aaa>
    <bbb>DEF1</bbb>
    <bbb>DEF2</bbb>
  </aaa>
  <aaa>
    <bbb>DEF3</bbb>
    <bbb>DEF4</bbb>
  </aaa>
</top>
```

<a name="usage_get_objects_by_path"></a>
### `do:get_objects_by_path`

Gets either values, names, generated-ids or comments of elements/attributes at a specified path.

**Example:**

```
<?xml version="1.0" encoding="utf-8"?>
<!-- all.xsl --> 
<xsl:stylesheet version="1.0"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
 <xsl:import href="xsldo.xsl"/>
  
 <xsl:template match="/top">
  <html>
   <body>
    <xsl:apply-templates select="all"/>
   </body>
  </html>
 </xsl:template>

 <xsl:template match="all">
  <xsl:call-template name="do:get_objects_by_path">
   <xsl:with-param name="path" select="@path"/>
   <xsl:with-param name="data_url" select="@file"/>
   <xsl:with-param name="what">text</xsl:with-param>
   <xsl:with-param name="prefix">(</xsl:with-param>
   <xsl:with-param name="suffix">)</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>
```

By using the above XSL file, the following XML file prints `(ABC1)(ABC2)(ABC3)` on your Web browser.

```
<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="application/xml" href="all.xsl"?>
<!-- all.xml -->
<top>
  <all path="//aaa/bbb"/>
  <!-- Outputs '(ABC1)(ABC2)(ABC3)' -->

  <aaa>
    <bbb>ABC1</bbb>
    <bbb>ABC2</bbb>
  </aaa>
  <aaa>
    <bbb>ABC3</bbb>
  </aaa>
</top>
```

Also, the following XML file prints `(DEF1)(DEF2)(DEF3)(DEF4)` by using an external XML file.

```
<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="application/xml" href="all.xsl"?>
<!-- all_f.xml -->
<top>
  <all path="//aaa/bbb" file="external.xml"/>
  <!-- Outputs '(DEF1)(DEF2)(DEF3)(DEF4)' -->
</top>
```

```
<?xml version="1.0" encoding="utf-8"?>
<!-- external.xml -->
<top>
  <aaa>
    <bbb>DEF1</bbb>
    <bbb>DEF2</bbb>
  </aaa>
  <aaa>
    <bbb>DEF3</bbb>
    <bbb>DEF4</bbb>
  </aaa>
</top>
```

<a name="usage_for_by_path"></a>
### `do:for_by_path`

Loops for each element/attribute at a specified path.

**Example:**

```
<?xml version="1.0" encoding="utf-8"?>
<!-- for.xsl -->
<xsl:stylesheet version="1.0"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="xsldo.xsl"/>

 <xsl:template match="/top">
  <html>
   <body>
    <xsl:apply-templates select="for"/>
   </body>
  </html>
 </xsl:template>

 <xsl:template match="for[boolean(@path)]">
  <xsl:call-template name="do:for_by_path">
   <xsl:with-param name="path" select="@path"/>
   <xsl:with-param name="data_url" select="@file"/>
   <xsl:with-param name="allow">|all|</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

 <xsl:template match="all">
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:call-template name="do:get_objects_by_path">
   <xsl:with-param name="path" select="@path"/>
   <xsl:with-param name="data_url" select="$data_url"/>
   <xsl:with-param name="data_gid" select="$data_gid"/>
   <xsl:with-param name="what">text</xsl:with-param>
   <xsl:with-param name="prefix">(</xsl:with-param>
   <xsl:with-param name="suffix">)</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>
```

By using the above XSL file, the following XML file prints `[(ABC1)(ABC2)][(ABC3)]` on your Web browser.

```
<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="application/xml" href="for.xsl"?>
<!-- for.xml -->
<top>
  <for path="//aaa">[<all path="bbb"/>]</for>
  <!-- Outputs [(ABC1)(ABC2)][(ABC3)] -->

  <aaa>
    <bbb>ABC1</bbb>
    <bbb>ABC2</bbb>
  </aaa>
  <aaa>
    <bbb>ABC3</bbb>
  </aaa>
</top>
```

Also, the following XML file prints `[(DEF1)(DEF2)][(DEF3)(DEF4)]` by using an external XML file.

```
<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="application/xml" href="for.xsl"?>
<!-- for_f.xml -->
<top>
  <for path="//aaa" file="external.xml">[<all path="bbb"/>]</for>
  <!-- Outputs '[(DEF1)(DEF2)][(DEF3)(DEF4)]' -->
</top>
```

```
<?xml version="1.0" encoding="utf-8"?>
<!-- external.xml -->
<top>
  <aaa>
    <bbb>DEF1</bbb>
    <bbb>DEF2</bbb>
  </aaa>
  <aaa>
    <bbb>DEF3</bbb>
    <bbb>DEF4</bbb>
  </aaa>
</top>
```

<a name="usage_for_times"></a>
### `do:for_times`

Loops specified times.

**Example:**

```
<?xml version="1.0" encoding="utf-8"?>
<!-- times.xsl --> 
<xsl:stylesheet version="1.0"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
 <xsl:import href="xsldo.xsl"/>
  
 <xsl:template match="/top">
  <html>
   <body>
    <xsl:apply-templates select="for"/>
   </body>
  </html>
 </xsl:template>

 <xsl:template match="for[boolean(@times)]">
  <xsl:call-template name="do:for_times">
   <xsl:with-param name="times" select="@times"/>
   <xsl:with-param name="data_url" select="@file"/>
   <xsl:with-param name="allow">|first|</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <xsl:template match="first">
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:call-template name="do:first_object_by_path">
   <xsl:with-param name="path" select="@path"/>
   <xsl:with-param name="data_url" select="$data_url"/>
   <xsl:with-param name="data_gid" select="$data_gid"/>
   <xsl:with-param name="what">text</xsl:with-param>
   <xsl:with-param name="prefix">(</xsl:with-param>
   <xsl:with-param name="suffix">)</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>
```

By using the above XSL file, the following XML file prints `[(ABC1)][(ABC1)]` on your Web browser.

```
<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="application/xml" href="times.xsl"?>
<!-- times.xml -->
<top>
  <for times="2">[<first path="//aaa/bbb"/>]</for>
  <!-- Outputs '[(ABC1)][(ABC1)]' -->
  
  <aaa>
    <bbb>ABC1</bbb>
    <bbb>ABC2</bbb>
  </aaa>
  <aaa>
    <bbb>ABC3</bbb>
  </aaa>
</top>
```

Also, the following XML file prints `[(DEF1)][(DEF1)]` by using an external XML file.

```
<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="application/xml" href="times.xsl"?>
<!-- times_f.xml -->
<top>
  <for times="2" file="external.xml">[<first path="//aaa/bbb"/>]</for>
  <!-- Outputs '[(DEF1)][(DEF1)]' -->
</top>
```

```
<?xml version="1.0" encoding="utf-8"?>
<!-- external.xml -->
<top>
  <aaa>
    <bbb>DEF1</bbb>
    <bbb>DEF2</bbb>
  </aaa>
  <aaa>
    <bbb>DEF3</bbb>
    <bbb>DEF4</bbb>
  </aaa>
</top>
```

## License

Copyright &copy; 2019-2020 Takayuki Sato

This program is free software under [MIT][mit-url] License.
See the file LICENSE in this distribution for more details.


[repo-url]: https://github.com/xslet/xsldo
[io-image]: https://img.shields.io/badge/HP-github.io-ff8888.svg
[io-url]: https://xslet.github.io/xsldo/
[ver-image]: https://img.shields.io/badge/version-1.0.0-blue.svg
[mit-image]: http://img.shields.io/badge/license-MIT-green.svg
[mit-url]: https://opensource.org/licenses/MIT
[api-url]: https://xslet.github.io/xsldo/api/xsldo.xml
