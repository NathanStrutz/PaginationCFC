<cfcomponent extends="mxunit.framework.TestCase">

	<cffunction name="testComponent">
		<cfscript>
			var p = createObject("component","pagination").init();
			var data = queryNew("a,b,c");
			queryAddRow(data, 123);

			p.setQueryToPaginate(data);

			p.setItemsPerPage(19);
			assertEquals(19, p.getMaxRows());

			assertEquals(7, p.getTotalNumberOfPages());
			assertEquals(1, p.getCurrentPage());

		</cfscript>
	</cffunction>

	<cffunction name="testErrors">
		<cfscript>
			var p = createObject("component","pagination");

			try {
				p.getRenderedHTML();
				fail("getRenderedHTML did not produce an error");
			} catch (any err) { assertTrue(err.message contains "You must supply the"); }

			p.init();

			try {
				p.getQuery();
				fail("getQuery did not produce an error");
			} catch (any err) { assertTrue(err.message contains "you did not define"); }

			try {
				p.getArray();
				fail("getArray did not produce an error");
			} catch (any err) { assertTrue(err.message contains "you did not define"); }

			try {
				p.getStruct();
				fail("getStruct did not produce an error");
			} catch (any err) { assertTrue(err.message contains "you did not define"); }

			try {
				p.getRenderedHTML();
				fail("getRenderedHTML did not produce an error");
			} catch (any err) { assertTrue(err.message contains "You must supply the"); }

			try {
				p.getTotalNumberOfPages();
				fail("getTotalNumberOfPages did not produce an error");
			} catch (any err) { assertTrue(err.message contains "you did not define"); }

			try {
				p.getCurrentPage();
				fail("getCurrentPage did not produce an error");
			} catch (any err) { assertTrue(err.message contains "you did not define"); }

			try {
				p.getStartRow();
				fail("getStartRow did not produce an error");
			} catch (any err) { assertTrue(err.message contains "you did not define"); }

			try {
				p.getEndRow();
				fail("getEndRow did not produce an error");
			} catch (any err) { assertTrue(err.message contains "you did not define"); }

			try {
				p.getTotalNumberOfItems();
				fail("getTotalNumberOfItems did not produce an error");
			} catch (any err) { assertTrue(err.message contains "you did not define"); }

			try {
				p.getPreviousPageLink();
				fail("getPreviousPageLink did not produce an error");
			} catch (any err) { assertTrue(err.message contains "you did not define"); }

			try {
				p.getNextPageLink();
				fail("getNextPageLink did not produce an error");
			} catch (any err) { assertTrue(err.message contains "you did not define"); }

			try {
				p.getLastPageLink();
				fail("getLastPageLink did not produce an error");
			} catch (any err) { assertTrue(err.message contains "you did not define"); }
		</cfscript>
	</cffunction>

</cfcomponent>
