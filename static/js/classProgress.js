(function() {
  var _this = this;

  ZABZO.classProgress.init = function(options) {
    var classFontSize, classJson, classWrapper, curClass, curId, padding, progressFontSize, progressGradient, progressWidth, svgEl, wrapperEl, wrapperHeight, wrapperId, wrapperWidth, xScale, _i, _len, _ref;
    padding = [0, 46, 0, 150];
    ZABZO.classProgress.padding = padding;
    wrapperHeight = 100;
    classJson = {
      "classes": [
        {
          "name": "Phil 165",
          "id": "phil165",
          "progress": 1.0
        }, {
          "name": "Ed 111",
          "id": "ed111",
          "progress": 0.6
        }, {
          "name": "CS 106B",
          "id": "cs106b",
          "progress": 0.7
        }, {
          "name": "Anthro 78",
          "id": "anthro78",
          "progress": 0.4
        }
      ]
    };
    ZABZO.classProgress.data = classJson;
    wrapperId = "#class-progress-svg-wrapper";
    wrapperEl = $(wrapperId);
    wrapperEl.empty();
    wrapperWidth = wrapperEl.width();
    xScale = d3.scale.linear().range([0, wrapperWidth - (padding[1] + padding[3])]).domain([0, 1.0]);
    ZABZO.classProgress.xScale = xScale;
    _ref = classJson.classes;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      curClass = _ref[_i];
      curId = curClass.id.replace(/\ /, "");
      svgEl = d3.select(wrapperId).append("svg").attr("id", 'svg-' + curId).attr("class", "classProgressViz").attr('width', wrapperWidth).attr('height', wrapperHeight);
      progressGradient = svgEl.append("svg:defs").append("svg:linearGradient").attr("id", "gradient-" + curId).attr("x1", "0%").attr("y1", "0%").attr("x2", "0%").attr("y2", "100%");
      progressGradient.append("svg:stop").attr("offset", "0%").attr("stop-color", "#e0e0e0").attr("stop-opacity", 1);
      progressGradient.append("svg:stop").attr("offset", "100%").attr("stop-color", "#cdcdcd").attr("stop-opacity", 1);
      classWrapper = svgEl.append("svg:g").attr("class", "classBarWrapper");
      progressWidth = xScale(curClass.progress);
      classWrapper.append("svg:rect").attr("x", padding[3]).attr("y", 0).attr("width", progressWidth).attr("height", wrapperHeight).style("fill", "url(#gradient-" + curId + ")").style("stroke", "#b0b0b0");
      classFontSize = 12;
      classWrapper.append("svg:text").attr("class", "className").attr("x", padding[3] - 4).attr("y", (wrapperHeight / 2) + (classFontSize / 2)).text(curClass.name).style('text-anchor', 'end').style("fill", "#232323").style("font-size", classFontSize).style("text-align", 'right');
      progressFontSize = 18;
      classWrapper.append("svg:text").attr("class", "progressLabel").attr("x", padding[3] + (progressWidth + 2)).attr("y", (wrapperHeight / 2) + (progressFontSize / 2)).text(d3.round(curClass.progress * 100, 2) + '%').style("fill", "#232323").style("font-size", progressFontSize);
    }
    return true;
  };

  ZABZO.classProgress.updateClass = function(classId, progress) {
    var padding, progressWidth, svgEl;
    svgEl = d3.select('#svg-' + classId);
    padding = ZABZO.classProgress.padding;
    progressWidth = ZABZO.classProgress.xScale(progress);
    svgEl.selectAll('rect').transition().attr('width', progressWidth);
    svgEl.selectAll('text.progressLabel').transition().attr('x', padding[3] + (progressWidth + 2)).text(d3.round(progress * 100, 2) + '%');
    return true;
  };

}).call(this);
