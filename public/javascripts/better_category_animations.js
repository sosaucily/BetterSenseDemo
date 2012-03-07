  iter = 0;
  results_vals = {
  	0: [{"category":"Vehicles","accuracy":50},{"category":"Real Estate","accuracy":75},{"category":"Travel & Tourism","accuracy":50}],
  	1: [{"category":"Finance","accuracy":125},{"category":"Family & Community","accuracy":175},{"category":"News","accuracy":123}],
  	2: [{"category":"Beauty","accuracy":45},{"category":"Vehicles","accuracy":23},{"category":"Finance","accuracy":75}],
  	3: [{"category":"Arts & Entertainment","accuracy":123},{"category":"Sports","accuracy":53},{"category":"Apparel","accuracy":183}],
	4: [{"category":"Arts & Entertainment","accuracy":123},{"category":"Sports","accuracy":53},{"category":"Apparel","accuracy":183}],
	5: [{"category":"Arts & Entertainment","accuracy":123},{"category":"Sports","accuracy":53},{"category":"Apparel","accuracy":183}]
  };
  keywords = {
	0: "Car",
	1: "Library",
	2: "Dress",
	3: "Television",
	4: "Television",
	5: "Television"
  };
  keyword_relevance = {
	0: "73",
	1: "61",
	2: "43",
	3: "82",
	4: "82",
	5: "82"
  };
  scene_breaks = {
	0: "0.00",
	1: "1.11",
	2: "2.22",
	3: "3.33",
	4: "4.44",
	5: "5.55"
  };

  bars = ['#cBar1','#cBar2','#cBar3'];

  var t=setTimeout("categoryBarAnimate()",1000);

  var keyword_table = "";
  
  $(function() {
		$('#scene_table_div').html( '<table id="scene_table"></table>' );
		$('#scene_table').dataTable( {
			"sScrollY": "200px",
			"aoColumns": [
						{ "sTitle": "Start Time" },
						{ "sTitle": "End Time" },
						{ "sTitle": "Best Keyword" },
						{ "sTitle": "Best Category" },
						{ "sTitle": "Relevance" }
					],
			"asStripClasses": ['vodd','veven'],
			"bPaginate": false,
			"aaSorting": [[0,'desc']],
			"bScrollCollapse": false,
			"bFilter": false,
			"bInfo": false
		});
		scene_table = $('#scene_table').dataTable();

		$('#keyword_table_div').html( '<table id="matched_item_table"></table>' );
		$('#matched_item_table').dataTable( {
			"sScrollY": "200px",
			"aoColumns": [
						{ "sTitle": "Time" },
						{ "sTitle": "Best Keyword" },
						{ "sTitle": "Confidence" }
					],
			"asStripClasses": ['vodd','veven'],
			"bPaginate": false,
			"aaSorting": [[0,'desc']],
			"bScrollCollapse": false,
			"bFilter": false,
			"bInfo": false
		});
		keyword_table = $('#matched_item_table').dataTable();

	
    categoryBarAnimate = function() {
	  console.log("Running categoryBarAnimate.");
	  if (iter < Object.keys(results_vals).length)
	  {
		elem_id = keyword_table.fnAddData(
			[iter, keywords[iter], keyword_relevance[iter] + "%"]//results_vals[iter][0]["category"]]
		);
		if (iter == 0)
			elem_id = scene_table.fnAddData(
				["0:00.00","0:07.24","Television",results_vals[iter][0]["category"],results_vals[iter][0]["accuracy"]] );
		console.log("Current row id is: " + elem_id)
		curr_row = $("#matched_item_table tr")[1]
		$(curr_row).hide().show(1000);
			
      	//clearCategoryBarsAndRedraw(iter);
      	iter += 1;
	  	var t=setTimeout("categoryBarAnimate()",1000);
      }
	  else
		clearTimeout(t);
    };
  });
    
    clearCategoryBarsAndRedraw = function(my_iter) {
      for (i=0; i< bars.length; i++)
      {
        clearCategoryBar(i);
        drawCategoryBar(i, my_iter);
      }
    };
    
    clearCategoryBar = function(bar_num) {
	  $(bars[bar_num]).animate({
  		marginTop: '200',
  		height: '0'
  	  }, 200);
    };
    
    drawCategoryBar = function(bar_num, my_iter) {
      new_height = results_vals[my_iter][bar_num]["accuracy"]
      new_margin_top = 200 - new_height
      $(bars[bar_num]).animate({
  		marginTop: new_margin_top,
  		height: new_height
  	  }, 500);
    };