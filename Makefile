SHELL=/bin/bash

build: 
	~/code/runner/runner.sh make run <<< `find . | grep -v .git | grep -v target`
run: 

	mvn -s ~/.m2/settings.xml.none test 
	#cat $(realpath target/generated-resources/xml/xslt/resources/settings.xml)

settings: 
	#mvn org.sonatype.plugins:nexus-m2settings-maven-plugin:download -DnexusUrl=http://localhost:8081 -Dsecure=false -Dusername=admin -Dpassword=admin -Dtemplate=default
	curl -u admin:admin -X GET "http://localhost:8081/nexus/service/local/templates/settings/default/content" 
	

