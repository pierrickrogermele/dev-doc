<xsl:transform version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:mode on-no-match="shallow-copy" />
	<xsl:template match="b">
		<xsl:copy>
			<xsl:apply-templates select="*|@*"/>
			<xsl:value-of select='replace(., "Some","XXX")'/>
		</xsl:copy>
	</xsl:template>
</xsl:transform>
