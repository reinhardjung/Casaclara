<cfcomponent name="bean" extends="casaclara.model.model" displayname="SuperClass" hint="stellt dao-relevante Funktionen zur Verfügung">

<cffunction name="getInstanceData" returntype="any" output="false" access="public" hint="Variablen als Strukt ausgeben und den Flow unterbrechen">
	<cfargument name="abort" type="boolean" default="false" />

	<cfdump var="#variables.instance#" label="variables.instance with param.abort=#arguments.abort#" />
	<cfif arguments.abort><cfabort /></cfif>
</cffunction>


<cffunction name="populate" returntype="void" output="false" access="private" displayname="" hint="">
  <cfargument name="myBean"		type="struct" required="true" />
  <cfargument name="myBeanID"	type="numeric" required="false" default="1" />

	<cfloop collection="#variables.instance[1]#" item="myField">
		<cfinvoke component="#this#" method="set#myField#">
			<cfinvokeargument name="#myField#" value="#arguments.myBean[myField]#" />
			<cfinvokeargument name="beanID" value="#arguments.myBeanID#" />
		</cfinvoke>
	</cfloop>
</cffunction>


<cffunction name="save" returntype="struct" output="false" access="public" displayname="" hint="">
	<cfargument name="myForm" type="struct" required="true" displayname="Formulardaten" hint="die als Struct übergeben werden" />

	<cfloop collection="#variables.instance[1]#" item="myField">
		<cfif isDefined("arguments.myForm.#myField#")>
			<cfset variables.instance[1][myField] = arguments.myForm[myField] />
		</cfif>
	</cfloop>

	<cfreturn variables.instance[1] />
</cffunction>

</cfcomponent>