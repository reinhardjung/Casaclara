<cfapplication name="#listLast(getDirectoryFromPath(getCurrentTemplatePath()),IIF(listLen(getCurrentTemplatePath(),":\") IS 1,DE("/"),DE("\")))#" sessionmanagement="true">


<cfparam name="url.event" type="string" default="address,list" />
<cfparam name="application.#application.applicationname#.design" type="boolean" default="false" />


<!--- docu:mgb_rjung/ 2006.10.05 14:13:09 PM  stellt den FORM und URL-Scope im REQUEST-scope zur Verfügung --->
<cfset request[application.applicationname] = duplicate(url) />
<cfset structAppend(request[application.applicationname],duplicate(form),true) />

<cfif isDefined("url.design")>
	<cfset application[application.applicationname].design = url.design />
</cfif>


<!--- docu:mgb_rjung/ 2006.10.05 14:15:44 PM  Erstelle alle ben�tigten Objekte (kommasepariert) --->
<cfset variables.createMyObjects('casaclara','M','gateway','address') />
<cfset variables.createMyObjects('casaclara','M','dao','address') />
<cfset variables.createMyObjects('casaclara','M','bean','address') />
<cfset variables.createMyObjects('casaclara','C','bo','address') />
<cfset variables.createMyObjects('casaclara','C','system','function') />


<!--- docu:mgb_rjung/ 2006.09.26 9:08:57 AM  SystemFunktion zum erstellen aller Objekte --->
<cffunction name="createMyObjects" returntype="void" access="private" output="false" displayname="erstellt alle Objekte" hint="die zu erstellenden Gateways k�nnen als CSV-List �bergeben werden">
	<cfargument name="datasource" type="string" required="true" />
	<cfargument name="objectMVC"  type="string" required="true" />
	<cfargument name="objectType" type="string" required="true" />
	<cfargument name="objectList" type="string" required="true" />

	<cfset var MVC = "model,view,controller" />
	<cfset var initParams = structNew() />

	<cfif arguments.objectMVC IS "M">
		<cfset initParams.datasource = arguments.datasource />
	</cfif>

	<!--- fixme:mgb_rjung-2006.10.05 15:08:45 PM  INIT(datasource="") wird nicht immer ben�tigt	 --->
	<cfloop list="#arguments.objectList#" index="myObject">
		<cfinvoke component="#application.applicationname#.#listGetAt(MVC,listContainsNoCase(MVC,arguments.objectMVC))#.#arguments.objectType#.#myObject#" method="init" argumentcollection="#initParams#" returnvariable="application.#application.applicationname#.#arguments.objectType#.#myObject#" />
	</cfloop>
</cffunction>

<!--- docu:mgb_rjung/ 2006.10.05 14:16:34 PM  Ist der Controller des jeweiligen Events (defaultwerte werden im Controller gesetzt) --->
<cfinvoke component="#application[application.applicationname].bo[listFirst(request[application.applicationname].event)]#" argumentcollection="#request[application.applicationname]#" method="#listLast(request[application.applicationname].event)#" />
