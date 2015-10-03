<cfcomponent extends="Pagination">

	<cffunction name="renderHTML" returntype="string" output="false" hint="Creates the pagination HTML output.">
		<cfset var renderedOutput = "" />

		<cfsavecontent variable="renderedOutput">
			<cfoutput>
				<a href="#getFirstPageLink()#">&lt;&lt;</a>
				<a href="#getPreviousPageLink()#">&lt;</a>
				Page #getCurrentPage()# of #getTotalNumberOfPages()#
				<a href="#getNextPageLink()#">&gt;</a>
				<a href="#getLastPageLink()#">&gt;&gt;</a>
			</cfoutput>
		</cfsavecontent>

		<cfreturn renderedOutput />
	</cffunction>

</cfcomponent>
