<cfset styles = "default,google,yahoo,live,black,blackred,digg,flickr,gray,gray2,green,greenblack,jogger,meneame,misalgoritmos,sabros.us,technorati,youtube" />
<cfparam name="url.style" default="default" />

<html>
<head>
	<style type="text/css" media="all">
		<cfoutput>@import url("styles/#url.style#.css");</cfoutput>

		/* general */
		* {
			font-family:sans-serif;
			font-size:1em;
		}
		h4 {
			margin:0;
		}
		a {
			color:blue;
		}

		/* specific elements */
		#stylepicker, #datasource {
			float:left;
			margin-right:15px;
		}
		#stylepicker a, #datasource a {
			display:block;
			background:#EEF;
			padding:4px;
			font-size:0.8em;
			text-decoration:none;
			color:#333;
			border:1px solid #FFF;
		}
		#stylepicker a:hover, #datasource a:hover {
			background:#DDF;
			border:1px solid #BBB;
		}
		#stylepicker a.selected, #datasource a.selected {
			border:1px solid #666;
			background:#DFD;
		}

		#paginationTestArea {
			float:left;
		}
		#paginationTestArea table {
			clear:both;
		}

		.cfdebug {clear:both;}

	</style>



</head>
<body>

<h2>Pagination Samples</h2>

<cfparam name="use" default="query" />

<cfset paginationPath = reReplace(replace(getDirectoryFromPath(cgi.script_name), "/", ".", "ALL"), "(^\.|\.examples\.?$)", "", "ALL") />

<cfset 	pagination = createObject("component", "#paginationPath#.Pagination").init() />

<cfif use EQ "query">
	<cfinclude template="samplequery.cfm">
	<cfset pagination.setQueryToPaginate(sampleQuery) />
<cfelseif use EQ "array">
	<cfinclude template="samplearray.cfm">
	<cfset pagination.setArrayToPaginate(sampleArray) />
<cfelseif use EQ "struct">
	<cfinclude template="samplestruct.cfm">
	<cfset pagination.setStructToPaginate(sampleStruct, arrayToList(sortedKeys)) />
</cfif>

<cfscript>

	pagination.setItemsPerPage(4);
	pagination.setClassName(url.style);

	// pick your style
	if (url.style EQ "default") {
		// default behavior
	} else if (url.style EQ "google") {
		// like google
		pagination.setShowNumericLinks(true);
		pagination.setNumericDistanceFromCurrentPageVisible(10);
		pagination.setNumericEndBufferCount(0);
		pagination.setShowMissingNumbersHTML(false);
		pagination.setURLPageIndicator("page");
		pagination.setPreviousLinkHTML("Previous");
		pagination.setNextLinkHTML("Next");
		pagination.setPreviousLinkDisabledHTML("&nbsp;");
		pagination.setNextLinkDisabledHTML("&nbsp;");

	} else if (url.style EQ "yahoo") {
		// like Yahoo
		/*
			Yahoo & Flickr need some kind of "show maximum of this many numbers"
			option, which should be 10 or 11.
			I think setNumericDistanceFromCurrentPagevisible(10) along with
			setFixedMaximumNumbersShown(11) should solve it.
		*/
		pagination.setShowNumericLinks(true);
		pagination.setNumericDistanceFromCurrentPageVisible(5);
		pagination.setNumericEndBufferCount(0);
		pagination.setShowMissingNumbersHTML(false);
		pagination.setURLPageIndicator("start");
		pagination.setShowPrevNextDisabledHTML(false);
		pagination.setPreviousLinkHTML("&lt; Prev");

	} else if (url.style EQ "live") {
		// like MSN Live Search
		pagination.setShowNumericLinks(true);
		pagination.setNumericDistanceFromCurrentPageVisible(4);
		pagination.setNumericEndBufferCount(0);
		pagination.setShowMissingNumbersHTML(false);
		pagination.setURLPageIndicator("first");
		pagination.setShowPrevNextDisabledHTML(false);
		pagination.setPreviousLinkHTML("Prev");
		pagination.setNextLinkHTML("Next");

	} else if (url.style EQ "amazon1") {

		// Like Amazon
		// « Previous|Page:1 2 3 |Next »            page 1, 3 pages total
		// « Previous|Page:1 2 3 ... |Next »        page 1, 1000 pages total
		// « Previous|Page:1 2 3 4 5 ... |Next »    page 4    <--- is this a sticky #2? show if it bridges the gap?
		// « Previous|Page:1 ... 5 6 7 ... |Next »  page 6

		pagination.setShowNumericLinks(true);
		pagination.setNumericDistanceFromCurrentPageVisible(1);
		pagination.setNumericEndBufferCount(1);
		pagination.setShowMissingNumbersHTML(true);
		pagination.setShowPrevNextDisabledHTML(true);
		pagination.setPreviousLinkHTML("&laquo; Previous");
		pagination.setPreviousLinkDisabledHTML("&laquo; Previous");
		pagination.setNextLinkHTML("Next &raquo;");
		pagination.setNextLinkDisabledHTML("Next &raquo;");
		pagination.setBeforeNumericLinksHTML("| Page:");
		pagination.setAfterNumericLinksHTML("|");


	} else if (url.style EQ "amazon2") {

		// Like amazon, certain results
		//	Showing 1 - 28 of 64 Results
		//	Page:  1  2  3  Next >

		//	Showing 57 - 64 of 64 Results
		//	Page: 	< Previous  1  2  3

		pagination.setShowNumericLinks(true);
		pagination.setNumericDistanceFromCurrentPageVisible(1);
		pagination.setNumericEndBufferCount(1);
		pagination.setShowMissingNumbersHTML(true);
		pagination.setShowPrevNextDisabledHTML(true);
		pagination.setPreviousLinkHTML("&lt; Previous");
		pagination.setPreviousLinkDisabledHTML("&lt; Previous");
		pagination.setNextLinkHTML("Next &gt;");
		pagination.setNextLinkDisabledHTML("Next &gt;");
//		pagination.setPaginationTextMask("Showing ${firstitem} - ${lastitem} of ${totalitems} Results");

	} else {
		pagination.setShowNumericLinks(true);
	}
/*
	} else if (url.style EQ "amazon3") {

		// Like amazon wish lists
		// Total Items: 60                                        Page 1 of 3 | Next >>
		// ----------------------------------------------------------------------------

	} else if (url.style EQ "youtube") {

		// like Youtube
		// Pages: 1 2 3 4 5 6 7 ... Next                page 1 (always show 7)
		// Pages: Previous 4 5 6 7 8 9 10 ... Next        page 7 (border of 3, dots at the end)

	} else if (url.style EQ "ebay") {

		// like Ebay
		// Page 1 of 14,098                                            Go to page
		// Previous 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 Next             [____] {Go}        <--- like yahoo, always 9
		// Page 9 of 14,093
		// Previous 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 Next                            <--- page 9, has a border of 4

	}
*/
</cfscript>






<cfoutput>
<div id="stylepicker">
	<h4>Styles</h4>
	<cfloop list="#styles#" index="i">
		<a href="#cgi.script_name#?use=#use#&style=#i#&#pagination.getUrlPageIndicator()#=#pagination.getCurrentPage()#"<cfif i EQ url.style> class="selected"</cfif>>#i#</a>
	</cfloop>
</div>


<div id="datasource">
	<h4>Data Source</h4>
	<a href="#cgi.script_name#?use=query&style=#url.style#&#pagination.getUrlPageIndicator()#=#pagination.getCurrentPage()#"<cfif use EQ "query"> class="selected"</cfif>>Query</a>
	<a href="#cgi.script_name#?use=array&style=#url.style#&#pagination.getUrlPageIndicator()#=#pagination.getCurrentPage()#"<cfif use EQ "array"> class="selected"</cfif>>Array</a>
	<a href="#cgi.script_name#?use=struct&style=#url.style#&#pagination.getUrlPageIndicator()#=#pagination.getCurrentPage()#"<cfif use EQ "struct"> class="selected"</cfif>>Struct</a>
</div>

</cfoutput>

<div id="paginationTestArea">
	<h4>Test Data</h4>

	<cfoutput>
		#pagination.getRenderedHTML()#
	</cfoutput>

	<table border="1" cellspacing="0" cellpadding="3">
		<thead>
			<tr>
				<th>ID</th>
				<th>Junk</th>
				<th>Random</th>
			</tr>
		</thead>
		<tbody>
		<cfif use EQ "query">
			<!--- simple CF 101 query output with start/max controls --->
			<cfoutput query="sampleQuery" startrow="#pagination.getStartRow()#" maxrows="#pagination.getMaxRows()#">
				<tr>
					<td>#id#</td>
					<td>#col#</td>
					<td>#data#</td>
				</tr>
			</cfoutput>
		<cfelseif use EQ "array">
			<cfoutput>
			<!--- simple from/to loop based on values from the array passed in --->
			<cfloop from="#pagination.getStartRow()#" to="#pagination.getEndRow()#" index="i">
				<tr>
					<td colspan="3">#sampleArray[i]#</td>
				</tr>
			</cfloop>
			</cfoutput>
		<cfelseif use EQ "struct">
			<cfoutput>
			<!--- notice the use of the sortedKeys array we created when we setStructToPaginate()
					- this method seemed to produce the least amount of code --->
			<cfloop from="#pagination.getStartRow()#" to="#pagination.getEndRow()#" index="i">
				<tr>
					<td colspan="3">#sampleStruct[sortedKeys[i]]#</td>
				</tr>
			</cfloop>
			</cfoutput>
		</cfif>
		</tbody>
	</table>

	<cfoutput>
		#pagination.getRenderedHTML()#
	</cfoutput>

</div>

</body>
</html>
