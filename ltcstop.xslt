<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="html" indent="yes"/>

  <xsl:param name="street"/>

  <xsl:template match="/">
    <html>
      <body>
        <h1>
         <xsl:if test="$street != ''">
           <font face="Verdana">
             LTC Stops on <xsl:value-of select="$street"/>
           </font>
          </xsl:if>
          
          <xsl:if test="$street=''">
            <font face="Verdana">
              All LTC Stops
            </font>
          </xsl:if>
       </h1>
        
        <h3>
          <xsl:value-of select="count(//stop[contains(@name , $street)])"/> stops found
        </h3>
        
        <table style="width:720px" border="5">
          <tr>
            <th>
              <font face="Verdana" size="4">Stop #</font>
            </th>
            <th>
              <font face="Verdana" size="4">Stop Name</font>
            </th>
            <th>
              <font face="Verdana" size="4">Latitude</font>
            </th>
            <th>
              <font face="Verdana" size="4">Longitude</font>
            </th>
            <th>
              <font face="Verdana" size="4">Routes</font>
            </th>
          </tr>
          <xsl:apply-templates select ="allstops" />
        </table>
        </body>
        </html>
    </xsl:template>


  <xsl:template match="allstops">
    <!--loop the content-->
   <xsl:for-each select="stop">
    <xsl:sort select="@number" data-type="number"/>
     <!--then, show the all or the special-->
     <xsl:if test="contains(@name, $street)">
      <xsl:element name="tr">
        <xsl:element name="td">
          <xsl:value-of select="@number"/>
        </xsl:element>
        <xsl:element name="td">
          <xsl:value-of select="@name"/>
        </xsl:element>
        <xsl:element name="td">
          <xsl:value-of select="location/latitude"/>
        </xsl:element>
        <xsl:element name="td">
          <xsl:value-of select="location/longitude"/>
        </xsl:element>
        <xsl:element name="td">
          <xsl:value-of select="routes"/>
        </xsl:element>
      </xsl:element>
     </xsl:if>
   </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
