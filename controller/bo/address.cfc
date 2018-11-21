<cfcomponent name="address" extends="bo" displayname="AddressController" hint="Steuert die Adressdaten">

<cffunction name="init" returntype="address" output="false" access="public" displayname="EventController" hint="Wird zur Steuerung des WorkFlows benötigt">
	<cfset variables.instance.view	= "address_list" />

	<cfreturn this />
</cffunction>


<cffunction name="validate" displayname="validate Rights" hint="like loggedIn etc.">
	<cfset var isAuthorised = true />

	<cfreturn isAuthorised />
</cffunction>


<cffunction name="delete" returntype="void" output="false" access="public" displayname="bedient das DAO" hint="löscht einen Datensatz">
	<cfargument name="Ident" required="true" displayname="Database-ID" hint="Ident aus der Tabelle" />

	<cfif validate()>	<!--- fixme:RJung-2006.11.26 16:50:34 PM  UserName, Password übergeben?! --->
		<cfset application[application.applicationname].dao.address.delete(arguments.Ident) />
		<cfset application[application.applicationname].bean.address.init() />
	</cfif>

	<cfset clear() />
	<cfset list() />
</cffunction>


<cffunction name="view" returntype="void" output="false" access="private" displayname="steuert alle Views vom Controller aus" hint="+cfset view('address_list')+">
	<cfargument name="myView" type="string" required="false" default="#variables.instance.view#" displayname="" hint="" />

	<cfset request[application.applicationname].view = arguments.myView />
</cffunction>


<cffunction name="list" returntype="void" output="false" access="public" displayname="bedient das Gateway" hint="liefert 'alle' Adressen aus dem Gateway">
	<cfargument name="orderBy" type="string" required="false" default="" displayname="Reihenfolge" hint="Reihenfolge der Datensätze" />
	<cfargument name="sortBy"  type="string" required="false" default="" displayname="Sortierung"  hint="Sortierung der Datensätze" />

	<!--- fixme:RJung-2006.12.12 13:14:28 PM  kommt noch ins Bean und nicht in den request-Scope  --->
	<!--- fixme:RJung-2006.12.12 13:14:28 PM  sollte über das Bean gelesen werden?!  --->
	<!--- <cfset request[application.applicationname]['controller']['address'] = application[application.applicationname].gateway.address.read(arguments.orderBy,arguments.sortBy) /> --->
	<cfinvoke component="#application[application.applicationname].bean.address#" method="read">
		<cfinvokeargument name="orderBy" value="#arguments.orderBy#" />
		<cfinvokeargument name="sortBy" value="#arguments.sortBy#" />
	</cfinvoke>

	<cfset view() />
</cffunction>


<cffunction name="edit" returntype="void" output="false" access="public" displayname="bedient das DAO" hint="liefert eine Adresse aus dem DAO">
	<cfargument name="Ident" required="true" displayname="Database-ID" hint="Ident aus der Tabelle" />

	<cfset application[application.applicationname].bean.address.read(arguments.Ident) />

	<cfset view('address_edit') />
</cffunction>


<cffunction name="new" returntype="void" output="false" access="public" displayname="bedient das DAO" hint="liefert eine Adresse aus dem DAO">
	<cfset application[application.applicationname].bean.address.init() />

	<cfset view('address_edit') />
</cffunction>


<cffunction name="save" returntype="void" output="false" access="public" displayname="bedient das DAO" hint="liefert eine Adresse aus dem DAO">
	<cfif application[application.applicationname].bean.address.validate(arguments)>
		<cfset application[application.applicationname].bean.address.setIdent(application[application.applicationname].dao.address.save(application[application.applicationname].bean.address.save(arguments))) />	<!--- Daten ins Bean und ins DAO --->

		<cfset view('address_edit') />
	</cfif>	<!--- fixme:RJung-2006.11.26 16:30:42 PM  else ERROR-Handling zur "Anzeige" --->
</cffunction>

</cfcomponent>