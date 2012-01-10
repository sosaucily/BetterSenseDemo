  iter = 0;
  results_vals = {
  	0: [{"category":"Vehicles","accuracy":50},{"category":"Real Estate","accuracy":75},{"category":"Travel & Tourism","accuracy":50}],
  	1: [{"category":"Finance","accuracy":125},{"category":"Family & Community","accuracy":175},{"category":"News","accuracy":123}],
  	2: [{"category":"Beauty","accuracy":45},{"category":"Vehicles","accuracy":23},{"category":"Finance","accuracy":75}],
  	3: [{"category":"Arts & Entertainment","accuracy":123},{"category":"Sports","accuracy":53},{"category":"Apparel","accuracy":183}],
  };
  keywords = {
	0: "Car",
	1: "Library",
	2: "Dress",
	3: "Television"
  };
  bars = ['#cBar1','#cBar2','#cBar3'];

  var t=setTimeout("categoryBarAnimate()",1000);

  var keyword_table = "";
  
  $(function() {
	

		$('#keyword_table_div').html( '<table id="matched_item_table"></table>' );
		$('#matched_item_table').dataTable( {
			"sScrollY": "200px",
			"aoColumns": [
						{ "sTitle": "Keyword" },
						{ "sTitle": "Category" },
						{ "sTitle": "Time" }
					],
			"asStripClasses": ['vodd','veven'],
			"bPaginate": false,
			"aaSorting": [[2,'desc']],
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
			[keywords[iter], results_vals[iter][0]["category"], iter]
		);
		console.log("Current row id is: " + elem_id)
		curr_row = $("#matched_item_table tr")[1]
		$(curr_row).hide().show(1000);
			
      	clearCategoryBarsAndRedraw(iter);
      	iter += 1;
	  	var t=setTimeout("categoryBarAnimate()",2000);
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