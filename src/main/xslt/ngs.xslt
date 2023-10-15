<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"  indent="yes"
                doctype-public = "-//W3C//DTD HTML 4.01 Transitional//EN"
                omit-xml-declaration="yes"/> 

    
    <xsl:param name="project" select="'mysettings'"/>
    <xsl:param name="blob" select="'BlobStoreManager.DEFAULT_BLOBSTORE_NAME'"/>

    <xsl:template match="/settings">
        
        import org.sonatype.nexus.blobstore.api.BlobStoreManager
        import org.sonatype.nexus.repository.maven.VersionPolicy
        import org.sonatype.nexus.repository.maven.LayoutPolicy
        import java.util.ArrayList

        <xsl:text>List members = new ArrayList()</xsl:text>
        <xsl:apply-templates select="//repository"/>

        <xsl:text>
            repository.createMavenGroup('</xsl:text>
        <xsl:value-of select="$project"/>
        <xsl:text>', members, </xsl:text>
        <xsl:value-of select="$blob"/>
        <xsl:text>)
        </xsl:text>


        <xsl:text>
            //TODO unsupported - task.importRepo('</xsl:text>
        <xsl:value-of select="localRepository"/>
        <xsl:text>')
        </xsl:text>

    </xsl:template>

    <xsl:template match="repository">
        <xsl:if test="releases/enabled='true'">
            <xsl:call-template name="create">
                <xsl:with-param name="name" select="normalize-space(id)"/>
                <xsl:with-param name="url" select="normalize-space(url)"/>
                <xsl:with-param name="classifier" select="'_releases'"/>
            </xsl:call-template>
        </xsl:if>

        <xsl:if test="snapshots/enabled='true'">
            <xsl:call-template name="create">
                <xsl:with-param name="name" select="normalize-space(id)"/>
                <xsl:with-param name="url" select="normalize-space(url)"/>
                <xsl:with-param name="classifier" select="'_snapshots'"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="create" mode="create">
        <xsl:param name="name"/>
        <xsl:param name="url"/>
        <xsl:param name="classifier"/>
        <xsl:text>
            repository.createMavenProxy('</xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:value-of select="$classifier"/>
        <xsl:text>', '</xsl:text>
        <xsl:value-of select="$url"/>
        <xsl:text>', </xsl:text>
        <xsl:value-of select="$blob"/>
        <xsl:text>, false, VersionPolicy.RELEASE, LayoutPolicy.STRICT)
            members.add('</xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:value-of select="$classifier"/>
        <xsl:text>')
        </xsl:text>
    </xsl:template>
</xsl:stylesheet>