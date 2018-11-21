<cfcomponent name="address" extends="bean" displayname="AddressBean" hint="dient auch als als TO-Ersatz">

<cffunction name="init" returntype="address" output="false" access="public" displayname="Initialisierung des Objectes" hint="stellt alle Parameter als instance-Variablen im 'this.scope' zur Verfügung">

	<cfset structDelete(variables,"instance") />
	<cfset variables.instance			= arrayNew(1) />
	<cfset variables.instance[1]	= structNew() />

	<cfparam name="variables.instance[1].Ident"			type="numeric" default="0" />
	<cfparam name="variables.instance[1].Vorname"		type="string"  default="" />
	<cfparam name="variables.instance[1].Nachname"	type="string"  default="" />

	<cfreturn this />
</cffunction>


<cffunction name="validate" returntype="boolean" output="false" access="public" displayname="prüft FormFields" hint="Prüft nur gülte Formular-Felder auf FeldType">
	<cfargument name="myFormValues" type="struct" required="true" />
	<cfargument name="myFieldNames" type="string" required="false" default="Ident,Vorname,Nachname" />

	<cfset var hasError = false />

	<cfloop list="#arguments.myFieldNames#" index="myField">
		<cfif isDefined('arguments.myFormValues.#myField#')>
			<cfset variables.instance[1][myField] = arguments.myFormValues[myField] />
			<cfswitch expression="#myField#">
			<cfcase value="Ident">
				<cfif NOT isValid("Numeric",arguments.myFormValues[myField])>
					<cfset hasError = true />
					<!--- fixme:RJung-2006.11.26 16:31:12 PM  Error-Handling --->
				</cfif>
			</cfcase>
			<cfcase value="Vorname">
				<cfif NOT isValid("String",arguments.myFormValues[myField])>
					<cfset hasError = true />
					<!--- fixme:RJung-2006.11.26 16:31:12 PM  Error-Handling --->
				</cfif>
			</cfcase>
			<cfcase value="Nachname">
				<cfif NOT isValid("String",arguments.myFormValues[myField])>
					<cfset hasError = true />
					<!--- fixme:RJung-2006.11.26 16:31:12 PM  Error-Handling --->
				</cfif>
				<cfset arguments.myFormValues[myField] = iIF(len(arguments.myFormValues[myField]) EQ 0,de("Nachname fehlt!"),de("#arguments.myFormValues[myField]#")) />
			</cfcase>
			</cfswitch>
		</cfif>
	</cfloop>

	<cfreturn NOT hasError />
</cffunction>


<cffunction name="read" returntype="void" output="false" access="public" displayname="ReadDAO" hint="Lesen und in BEAN-Konforme Structur bringen">
  <cfargument name="Ident"   type="numeric" required="false" default="0" displayname="Eindeutiger Schlüssel" hint="grösser 0 wird das DAO angesprochen, sonst das Gateway" />
	<cfargument name="orderBy" type="string"  required="false" default=""  displayname="Reihenfolge" hint="Reihenfolge der Datensätze" />
	<cfargument name="sortBy"  type="string"  required="false" default=""  displayname="Sortierung"  hint="Sortierung der Datensätze" />

	<cfset var myStruct	= structNew() />
	<cfset var myQuery	= queryNew('empty,query') />

	<cfif arguments.Ident GT 0>
		<cfset myQuery = application[application.applicationname].dao.address.read(arguments.Ident) />
	<cfelse>
		<cfset myQuery = application[application.applicationname].gateway.address.read(arguments.orderBy,arguments.sortBy) />
	</cfif>

	<cfloop query="myQuery">
		<cfloop collection="#variables.instance[1]#" item="myField">
			<cfif listFindNoCase(myQuery.columnList,myField)>
				<cfset myStruct[myField] = myQuery[myField][myQuery.currentRow] />
			</cfif>
		</cfloop>
		<cfset populate(myStruct,myQuery.currentRow) />
		<cfset myStruct	= structNew() />
	</cfloop>
</cffunction>


<cffunction name="load" returntype="array" output="false" access="public" displayname="" hint="">
	<cfargument name="keyField" type="string"  required="false" default="Ident" displayname="" hint="" />
	<cfargument name="keyID"    type="numeric" required="false" default="0" displayname="" hint="" />
	<!--- fixme:RJung-2006.12.12 16:29:11 PM  Wenn BeanID dann diese im BeanArray suchen und das entsprechende Feld übernehmen --->

	<cfreturn variables.instance />
</cffunction>


<cffunction name="setVorname" returntype="void" output="false" access="public" displayname="setzt Vorname" hint="setzt den Vornamen zur Adresse">
  <cfargument name="Vorname" type="string" required="true" />
  <cfargument name="beanID" type="numeric" required="false" default="1" />

	<cfset variables.instance[arguments.beanID]['Vorname'] = arguments.Vorname />
</cffunction>


<cffunction name="getVorname" returntype="string" output="false" access="public" displayname="holt den Vornamen" hint="setzt den Vornamen zur Adresse">
  <cfargument name="beanID" type="numeric" required="false" default="1" />

	<cfreturn variables.instance[arguments.beanID].Vorname />
</cffunction>


<cffunction name="setNachname" returntype="void" output="false" access="public" displayname="setzt Nachname" hint="setzt den Nachnamen zur Adresse">
  <cfargument name="Nachname" type="string" required="true" />
  <cfargument name="beanID" type="numeric" required="false" default="1" />

	<cfset variables.instance[arguments.beanID]['Nachname'] = arguments.Nachname />

	<!--- docu:RJung/ 2006.12.12 12:51:13 PM  or just append --->
	<!---
	<cfif arguments.beanID LTE arrayLen(variables.instance)>
		<cfset variables.instance[arguments.beanID]['Nachname'] = arguments.Nachname />
	<cfelse>
		<cfset variables.instance[arrayLen(variables.instance)+1]['Nachname'] = arguments.Nachname />
	</cfif>
	 --->
</cffunction>


<cffunction name="getNachname" returntype="string" output="false" access="public" displayname="holt den Nachnamen" hint="setzt den Nachnamen zur Adresse">
  <cfargument name="beanID" type="numeric" required="false" default="1" />

	<cfreturn variables.instance[arguments.beanID].Nachname />
</cffunction>


<cffunction name="setIdent" returntype="void" output="false" access="public" displayname="setzt die Ident" hint="setzt den Ident zur Adresse">
  <cfargument name="Ident"  type="numeric" required="true" />
  <cfargument name="beanID" type="numeric" required="false" default="1" />

	<cfset variables.instance[arguments.beanID]['Ident'] = arguments.Ident />
</cffunction>


<cffunction name="getIdent" returntype="numeric" output="false" access="public" displayname="holt die Ident" hint="setzt den Ident zur Adresse">
  <cfargument name="beanID" type="numeric" required="false" default="1" />

	<cfreturn variables.instance[arguments.beanID].Ident />
</cffunction>

</cfcomponent>