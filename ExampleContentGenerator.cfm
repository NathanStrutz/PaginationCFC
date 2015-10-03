<cfset numberOfRows = 123>
<cfsetting requesttimeout="300">



<!--- Sample Query Generator --->
<cfsavecontent variable="content"><cfoutput>
	sampleQuery = queryNew("id,col,data");
	queryAddRow(sampleQuery, #numberOfRows#);
	<cfloop from="1" to="#numberOfRows#" index="i">
		querySetCell(sampleQuery, "id", #i#, #i#);
		querySetCell(sampleQuery, "col", "Record Number " & #i#, #i#);
		querySetCell(sampleQuery, "data", "#createUUID()#", #i#);
	</cfloop>
</cfoutput></cfsavecontent>

<cfset content = "<cfscript>" & chr(10) & chr(13) & content & chr(10) & chr(13) & "</cfscript>">
<cffile action="write" file="#expandPath('examples/samplequery.cfm')#" output="#content#" />

Generated Query<br />
<cfflush>



<!--- Sample Array Generator --->
<cfsavecontent variable="content"><cfoutput>
	sampleArray = arrayNew(1);
	<cfloop from="1" to="#numberOfRows#" index="i">
		arrayAppend(sampleArray, #i# & " - " & "#createUUID()#");</cfloop>
</cfoutput></cfsavecontent>

<cfset content = "<cfscript>" & chr(10) & chr(13) & content & chr(10) & chr(13) & "</cfscript>">
<cffile action="write" file="#expandPath('examples/samplearray.cfm')#" output="#content#" />

Generated Array<br />
<cfflush>



<!--- Sample Struct Generator --->
<cfsavecontent variable="content"><cfoutput>
	sampleStruct = structNew();
	<cfloop from="1" to="#numberOfRows#" index="i">
		sampleStruct["abc" & #i#] = #i# & " - " & "#createUUID()#";</cfloop>

		sortedKeys = structSort(sampleStruct); // I think the default sort is alphabetical, so - 1, 10, 11, 2, 20, 21...
</cfoutput></cfsavecontent>

<cfset content = "<cfscript>" & chr(10) & chr(13) & content & chr(10) & chr(13) & "</cfscript>">
<cffile action="write" file="#expandPath('examples/samplestruct.cfm')#" output="#content#" />

Generated Struct & sort key

<br /><br />
Example content code generated. Check the <a href="examples/">examples</a> to see your new content.
