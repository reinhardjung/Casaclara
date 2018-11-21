<cfoutput>
<form name="myAddressRecord" action="index.cfm" method="post">
	Vorname <input id="vorname" name="Vorname" type="text" value="#application[application.applicationname].bean.address.getVorname()#" /><br />
	Nachname <input id="nachname" name="Nachname" type="text" value="#application[application.applicationname].bean.address.getNachname()#" /><br />
	<input name="sichern" type="submit" value="sichern" />&nbsp;&nbsp;
	<input type="button" value="Neu" onclick="document.getElementById('delete').style.display = 'none'; clearForm(); setFirst();" />&nbsp;&nbsp;
	<input id="delete" value="delete" type="button" onclick="self.location.href='index.cfm?event=address,delete&amp;Ident=' +document.getElementById('ident').value"
		<cfif application[application.applicationname].bean.address.getIdent() EQ 0>disabled</cfif> />
	<input id="ident" name="Ident" type="hidden" value="#application[application.applicationname].bean.address.getIdent()#" />
	<input id="event" name="Event" type="hidden" value="address,save" />
</form>
</cfoutput>

<script type="text/javascript">
 	function setFirst() { document.forms[0].elements[0].focus(); }
 	function clearForm() {
 		document.getElementById('ident').value		= 0;
 		document.getElementById('vorname').value	= '';
 		document.getElementById('nachname').value	= '';
 	}
	setFirst();
</script>