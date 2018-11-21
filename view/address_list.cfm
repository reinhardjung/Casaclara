<!--- fixme:RJung-2006.12.12 19:26:47 PM  reload vermeiden --->
<cfif len(cgi.QUERY_STRING) AND (isDefined("request.#application.applicationname#.clear") AND request[application.applicationname].clear)>
	<script>self.location.replace('index.cfm')</script>
</cfif>

<cfparam name="variables.orderBy" type="string"  default="nachname" />
<cfparam name="variables.sortBy"  type="string"  default="asc" />
<cfparam name="variables.design"  type="boolean" default="false" />

<cfloop list="design" index="myVAR">
	<cfif isDefined("application.#application.applicationname#.#myVAR#")>
		<cfset variables[myVAR] = application[application.applicationname][myVAR] />
	</cfif>
</cfloop>
<cfloop list="orderBy,sortBy" index="myVAR">
	<cfif isDefined("request.#application.applicationname#.#myVAR#")>
		<cfset variables[myVAR] = request[application.applicationname][myVAR] />
	</cfif>
</cfloop>
<cfset variables.sortBy = iIF(variables.sortBy IS 'asc',de('desc'),de('asc')) />


<cfoutput>
<table id="myAddress" <cfif NOT variables.design>border="1"<cfelse>border="0" cellpadding="10" cellspacing="0"</cfif>
<caption><a href="index.cfm?design=#iIF(variables.design,de('false'),de('true'))#"><h1>Adressliste</h1></a></caption>
<colgroup>
	<col width="100">
	<col width="120">
	<col width="50" align="center">
</colgroup>
<thead id="myAddres">
<tr>
	<td><a href="index.cfm?orderBy=Vorname&amp;sortBy=#variables.sortBy#"><cfif variables.design><h2>Vorname</h2><cfelse>Vorname</cfif></a></td>	<!--- ?view=#request[application.applicationname].event# ist DEFAULT --->
	<td><a href="index.cfm?orderBy=Nachname&amp;sortBy=#variables.sortBy#"><cfif variables.design><h2>Nachname</h2><cfelse>Nachname</cfif></a></td>	<!--- ?view=#request[application.applicationname].event# ist DEFAULT --->
	<td><a href="index.cfm?event=address,new" title="neu"><cfif variables.design><img src="config/images/ico_new.png" width="50px" alt="neu" /><cfelse>Neu</cfif></a></td>	<!--- &Ident=0 ist DEFAULT --->
</tr>
</thead>
<tfoot id="myAddre">
<tr>
	<td colspan="2">Anzahl Datens&auml;tze</td>
	<td align="right">(#arrayLen(application[application.applicationname].bean.address.load())#)</td>
</tr>
</tfoot>
<tbody>

<cfloop from="1" to="#arrayLen(application[application.applicationname].bean.address.load())#" index="myBeanRecord">
<tr id="#IIF(myBeanRecord MOD 2,de('high'),de('low'))#">
	<td><cfif variables.design><h3><a href="index.cfm?event=address,edit&amp;Ident=#application[application.applicationname].bean.address.getIdent(myBeanRecord)#" title="editieren">#application[application.applicationname].bean.address.getVorname(myBeanRecord)#</a></h3><cfelse>#application[application.applicationname].bean.address.getVorname(myBeanRecord)#</cfif></td>
	<td><cfif variables.design><h3><a href="index.cfm?event=address,edit&amp;Ident=#application[application.applicationname].bean.address.getIdent(myBeanRecord)#" title="editieren">#application[application.applicationname].bean.address.getNachname(myBeanRecord)#</a></h3><cfelse>#application[application.applicationname].bean.address.getNachname(myBeanRecord)#</cfif></td>
	<td nowrap="nowrap">
		<a href="index.cfm?event=address,edit&amp;Ident=#application[application.applicationname].bean.address.getIdent(myBeanRecord)#" title="editieren"><cfif NOT(variables.design)>E</cfif></a>
		<a href="index.cfm?event=address,delete&amp;Ident=#application[application.applicationname].bean.address.getIdent(myBeanRecord)#" title="l&ouml;schen"><cfif variables.design><img src="config/images/ico_delete.png" width="50px" alt="l&ouml;schen" /><cfelse>X</cfif></a>
	</td>
</tr>
</cfloop>

</tbody>
</table>
</cfoutput>