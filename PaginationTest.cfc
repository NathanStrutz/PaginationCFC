component extends="testbox.system.BaseSpec" {

	function testComponent(){
		var p = createObject("component","pagination").init();
		p.setNumberOfItems(123);

		p.setItemsPerPage(19);
		$assert.isEqual(19, p.getItemsPerPage());
		$assert.isEqual(7, p.getTotalNumberOfPages());
		$assert.isEqual(1, p.getCurrentPage());

		p.setNumberOfItems(1);
		$assert.isEqual(19, p.getItemsPerPage());
		$assert.isEqual(1, p.getTotalNumberOfPages());
	}

	function testErrors() {
		var p = createObject("component","pagination");

		$assert.throws(
			function(){ p.getRenderedHTML(); },
			"any",
			"You must supply the"
		);

	}

}