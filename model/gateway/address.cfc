<cfcomponent name="address" extends="casaclara.model.model" displayname="AddressGateway" hint="Liefert oder speichert die Adressdaten">
<cffunction name="init" returntype="address" output="false" access="public" displayname="Initialisierung des Adressobjectes" hint="stellt alle Parameter als instance-Variablen im 'this.scope' zur Verf�gung">
	<cfargument name="datasource" type="string" required="true" />

	<cfset variables.instance.datasource	= arguments.datasource />
	
 <cfreturn this />
</cffunction>


<cffunction name="read" returntype="Query" output="false" access="public" displayname="liefert alle Adressen" hint="ohne weitere Filterkriterien">
	<cfargument name="orderBy" type="string" required="false" default="Nachname" displayname="Reihenfolge" hint="Reihenfolge der Datens�tze" />
	<cfargument name="sortBy"  type="string" required="false" default="ASC" displayname="Sortierung"  hint="Sortierung der Datens�tze" />

	<cfset var myQuery = queryNew('empty,query') />

	<cfquery name="myQuery" datasource="#variables.instance.datasource#">
		SELECT * FROM adr_address
			<cfif len(arguments.orderBy)>ORDER BY #arguments.orderBy#</cfif>
			<cfif len(arguments.orderBy) AND len(arguments.sortBy)>#arguments.sortBy#</cfif>
	</cfquery>

	<cfreturn myQuery />
</cffunction>


<cffunction name="search" returntype="Query" output="false" access="public" displayname="liefert alle Adressen" hint="mit Filterkriterien">
</cffunction>

</cfcomponent>