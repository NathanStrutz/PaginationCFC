<cfcomponent extends="Pagination">


	<cffunction name="renderHTML" returntype="string" output="false" hint="Creates the pagination HTML output.">
		<cfset var renderedOutput = "" />

		<cfsavecontent variable="renderedOutput">
			<cfoutput>
				Page #getCurrentPage()# of #getTotalNumberOfPages()#<br />
				#super.renderHTML()#
			</cfoutput>
		</cfsavecontent>

		<cfreturn renderedOutput />
	</cffunction>

</cfcomponent>
