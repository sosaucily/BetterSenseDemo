/* DO NOT MODIFY. This file was compiled Fri, 18 Nov 2011 01:17:24 GMT from
 * /Users/jessesmith/Documents/BetterSense/www/BetterSenseDemoDev/BetterSenseDemo/app/coffeescripts/betterpic.coffee
 */

(function() {
  var root;
  root = typeof exports !== "undefined" && exports !== null ? exports : this;
  $(function() {
    var betterpic, clearSelectionBoxes, drawSelectionCircle, gCanvasElement, getRad, halmaOnClick, myCanvas, setSelectedTool, toolID;
    toolID = 1;
    gCanvasElement = root.$('#layer1');
    myCanvas = gCanvasElement[0].getContext('2d');
    betterpic = new Image;
    betterpic.onload = function() {
      return myCanvas.drawImage(betterpic, 0, 0, root.imagew, root.imageh);
    };
    betterpic.src = root.imagepath;
    halmaOnClick = function(e) {
      var coords, x, y;
      if ((e.pageX != null) && (e.pageY != null)) {
        x = e.pageX;
        y = e.pageY;
      } else {
        x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
        y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
      }
      x -= gCanvasElement[0].offsetLeft;
      y -= gCanvasElement[0].offsetTop;
      coords = gCanvasElement.offset();
      x -= coords["left"];
      y -= coords["top"];
      root.$('#iqeinfo_cx')[0].value = x;
      root.$('#iqeinfo_cy')[0].value = y;
      return drawSelectionCircle(x, y, myCanvas, toolID);
    };
    gCanvasElement[0].addEventListener('click', halmaOnClick, false);
    drawSelectionCircle = function(x, y, canvasContext, id) {
      canvasContext.clearRect(0, 0, root.imagew, root.imageh);
      myCanvas.drawImage(betterpic, 0, 0, root.imagew, root.imageh);
      canvasContext.beginPath();
      canvasContext.arc(x, y, getRad(id), 0, Math.PI * 2, false);
      canvasContext.closePath();
      canvasContext.strokeStyle = "#E89";
      canvasContext.lineWidth = "4";
      return canvasContext.stroke();
    };
    root.$('#circleToolBox1').click(function() {
      return setSelectedTool(1);
    });
    root.$('#circleToolBox2').click(function() {
      return setSelectedTool(2);
    });
    root.$('#circleToolBox3').click(function() {
      return setSelectedTool(3);
    });
    setSelectedTool = function(id) {
      toolID = id;
      clearSelectionBoxes();
      root.$('#iqeinfo_cradius').value = getRad(id);
      return root.$("#circleToolBox" + id)[0].style.border = "solid #000 4px";
    };
    clearSelectionBoxes = function() {
      var elem, _i, _len, _ref, _results;
      _ref = root.$('.toolselector');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        elem = _ref[_i];
        _results.push(elem.style.border = "solid #000 1px");
      }
      return _results;
    };
    getRad = function(id) {
      return 10 + (15 * id);
    };
    root.$('#cImageInfo').submit(function() {
      $('#layer1').hide("puff", {}, 600, function() {
        myCanvas.clearRect(0, 0, root.imagew, root.imageh);
        return $(this).show();
      });
    });
    root.clearAndNextPic = function(newImagePath, newimagew, newimageh) {
      root.imagew = newimagew;
      root.imageh = newimageh;
      gCanvasElement = root.$('#layer1');
      myCanvas = gCanvasElement[0].getContext('2d');
      myCanvas.clearRect(0, 0, root.imagew, root.imageh);
      betterpic = new Image;
      betterpic.onload = function() {
        return myCanvas.drawImage(betterpic, 0, 0, root.imagew, root.imageh);
      };
      betterpic.src = newImagePath;
    };
    return setSelectedTool(toolID);
  });
}).call(this);
