<cfcomponent name="system" output="false" displayname="Systemfunktionen" hint="stellt alle notwenigen Funktionen zur Verf�gung">

<cffunction name="init" access="public" displayname="System Funktionen" hint="Wird zum Handling der gesamten Application genutzt">
	<cfreturn this />
</cffunction>


<cffunction name="html2text" access="remote" returntype="string" output="false" hint="cleans a string from all html-tags">
	<cfargument name="htmlText" type="string" required="yes" hint="input-string with html-tags" />

	<cfset var text = reReplace(arguments.input, "<[^>]*>", "", "all") />
	<cfset var output = reReplace(text, "<[^>]*>", "", "all") />

	<cfreturn trim(output) />
</cffunction>


<cffunction name="getSystemInfo" access="public" returntype="Any" output="false" hint="returns the computers systemname and/or IP [:<cfoutput>##getSystemInfo('?')##</cfoutput><br /><br />]">
	<cfargument name="type" required="false" default="" hint="getSystemInfo('?')" />

	<cfset var mySystem = createObject('java','java.net.InetAddress').getLocalHost() />
	<cfset var mySystemInfo = "" />

	<cfswitch expression="#lCase(arguments.type)#">
	<cfcase value="?">
		<cfsavecontent variable="mySystemInfo">
			<cfoutput>
			<table>
			<tr>
				<td>getSystemInfo('Name')</td>
				<td>#getSystemInfo('Name')#</td>
				<td>returns the ComputerName of the Maschine</td>
			</tr>
			<tr>
				<td>getSystemInfo('IP')</td>
				<td>#getSystemInfo('IP')#</td>
				<td>returns the IP-Address from the Server</td>
			</tr>
			<tr>
				<td>getSystemInfo('!')</td>
				<td>#getSystemInfo('!')#</td>
				<td>cfDump from all Methods</td>
			</tr>
			<tr>
				<td>getSystemInfo('?')</td>
				<td>this Message</td>
			</tr>
			</table>
			</cfoutput>
		</cfsavecontent>
	</cfcase>
	<cfcase value="!">
		<cfsavecontent variable="mySystemInfo"><cfdump var="#mySystem#" label="mySystem" expand="false" /></cfsavecontent>
	</cfcase>
	<cfcase value="name">
		<cfset mySystemInfo = listFirst(mySystem.getHostName(),'/') />
	</cfcase>
	<cfcase value="ip">
		<cfset mySystemInfo = listLast(mySystem.getHostAddress(),'/') />
	</cfcase>
	<cfdefaultcase>
		<cfset mySystemInfo = mySystem.getLocalHost() />
	</cfdefaultcase>
	</cfswitch>

	<cfreturn mySystemInfo />
</cffunction>


</cfcomponent>
