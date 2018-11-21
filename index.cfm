<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><cfoutput>#application[application.applicationname].system.function.getSystemInfo('Name')# - [#application.applicationname#</cfoutput>]</title>
	<cfif application[application.applicationname].design>
		<link rel="stylesheet" media="screen" href="config/screen.css">
		<link rel="stylesheet" media="print"  href="config/print.css">
	</cfif>
</head>

<body>

<a id="homelink" href="index.cfm">/Home</a><br /><br />

<cfif FileExists("#getDirectoryFromPath(getCurrentTemplatePath())#view/#request[application.applicationname].view#.cfm")>
	<cfinclude template="view/#request[application.applicationname].view#.cfm">
</cfif>

<h6 onclick="if (document.getElementById('request_20061003').style.display=='none') {document.getElementById('request_20061003').style.display='inline'} else {document.getElementById('request_20061003').style.display='none'}" style="cursor:hand; display:inline;" id="cfwsDump">request</h6><div id="request_20061003" style="display:none;"><cfdump var="#request#" label="request [#lsDateFormat(now(),'dd.mm.yyyy')# #lsTimeFormat(now(),'HH:MM')#] #GetCurrentTemplatePath()#"><br /></div>&nbsp;&nbsp;
<h6 onclick="if (document.getElementById('application_20061005').style.display=='none') {document.getElementById('application_20061005').style.display='inline'} else {document.getElementById('application_20061005').style.display='none'}" style="cursor:hand; display:inline;" id="cfwsDump">application</h6><div id="application_20061005" style="display:none;"><cfdump var="#application#" label="application [#lsDateFormat(now(),'dd.mm.yyyy')# #lsTimeFormat(now(),'HH:MM')#] #GetCurrentTemplatePath()#"><br /></div>

</body>
</html>