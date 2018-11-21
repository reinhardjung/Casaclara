<cfcomponent name="address" extends="dao" displayname="AddressDAO" hint="sichert und liest die Adressdaten">

<cffunction name="init" returntype="address" output="false" access="public" displayname="Initialisierung des Objectes" hint="stellt alle Parameter als instance-Variablen im 'this.scope' zur Verf�gung">
	<cfargument name="datasource" type="string" required="true" default="" />

	<cfset variables.instance.datasource	= arguments.datasource />

 <cfreturn this />
</cffunction>


<cffunction name="read" returntype="query" output="false" access="public" displayname="liest einen Adressdatensatz" hint="wenn Ident gr�sser 0, andernfalls eine leere Query">
	<cfargument name="Ident" type="numeric" required="true" />

	<cfset var myQuery = queryNew('empty,query') />
	<cfquery name="myQuery" datasource="#variables.instance.datasource#">
		SELECT * FROM adr_address WHERE Ident = #arguments.Ident#
	</cfquery>

	<cfreturn myQuery />
</cffunction>


<cffunction name="save" returntype="numeric" output="false" access="public" displayname="liest einen Adressdatensatz" hint="wenn Ident gr�sser 0, andernfalls eine leere Query">
	<cfargument name="myBean" type="struct" required="true" displayname="" hint="" />

	<cfset var myIdent = arguments.myBean.ident />

	<cfif arguments.myBean.ident GT 0>
		<cfset update(arguments.myBean) />
	<cfelse>
		<cfset myIdent = create(arguments.myBean) />
	</cfif>

	<cfreturn myIdent />
</cffunction>


<cffunction name="create" returntype="numeric" output="false" access="private" displayname="" hint="">
	<cfargument name="myBean" type="struct" required="true" displayname="" hint="" />

	<cfquery name="setAddress" datasource="#variables.instance.datasource#">
		INSERT INTO adr_address (Vorname, Nachname)
			VALUES ('#arguments.myBean.Vorname#', '#IIF(len(arguments.myBean.Nachname) EQ 0,de("Nachname fehlt!"),de("#arguments.myBean.Nachname#"))#');
		SELECT SCOPE_IDENTITY() AS newAddressID;
	</cfquery>

	<cfreturn setAddress.newAddressID />
</cffunction>


<cffunction name="update" returntype="numeric" output="false" access="private" displayname="" hint="">
	<cfargument name="myBean" type="struct" required="true" displayname="" hint="" />

	<cfquery name="setAddress" datasource="#variables.instance.datasource#">
		UPDATE adr_address SET
			Vorname = '#arguments.myBean.Vorname#',
			Nachname = '#arguments.myBean.Nachname#'
		WHERE Ident = #arguments.myBean.Ident#;
	</cfquery>

	<cfreturn arguments.myBean.Ident />
</cffunction>


<cffunction name="delete" returntype="numeric" output="false" access="public" displayname="liest einen Adressdatensatz" hint="wenn Ident gr�sser 0, andernfalls eine leere Query">
	<cfargument name="Ident" type="numeric" required="true" />

	<cfset var delAddress = queryNew('empty,query') />
	<cfquery name="delAddress" datasource="#variables.instance.datasource#">
		DELETE FROM adr_address
			WHERE Ident = #arguments.Ident#
	</cfquery>

	<cfreturn arguments.Ident />
</cffunction>

</cfcomponent>