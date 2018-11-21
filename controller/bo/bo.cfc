<cfcomponent name="bo" extends="casaclara.model.model" displayname="SuperClass" hint="stellt bo-relevante Funktionen zur Verf�gung">

<cffunction name="clear" displayname="" hint="">
	<cfargument name="Scope" type="string" required="false" default="url,form" displayname="" hint="" />

	<cfset request[application.applicationname] = structNew() />

	<cfset structClear(url) />
	<cfset structClear(form) />
	<cfset request[application.applicationname].clear	= true />

<!---
	<cfloop list="#arguments.Scope#" index="myScope">
		<cfset structClear(myScope) />
	</cfloop>
 --->
</cffunction>

</cfcomponent>