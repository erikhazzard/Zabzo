(function() {
  var _this = this;

  ZABZO.setupZabzo = function() {
    var currentProgress, progressBar, progressMaxWidth, svgEl, svgHeight, svgWidth, zabzoGroup, zabzoProgressGradient;
    svgEl = d3.select('#zabzo-svg');
    svgWidth = svgEl.attr('width');
    svgHeight = svgEl.attr('height');
    ZABZO.svgVars.progressHeight = svgHeight;
    ZABZO.svgVars.barWidthPadding = 90;
    progressMaxWidth = svgWidth - ZABZO.svgVars.barWidthPadding;
    ZABZO.svgVars.progressMaxWidth = progressMaxWidth;
    currentProgress = 0;
    ZABZO.currentProgress = currentProgress;
    zabzoProgressGradient = svgEl.append("svg:defs").append("svg:linearGradient").attr("id", "zabzoProgressGradient").attr("x1", "0%").attr("y1", "0%").attr("x2", "0%").attr("y2", "100%");
    zabzoProgressGradient.append("svg:stop").attr("offset", "50%").attr("stop-color", "#EE703E").attr("stop-opacity", 1);
    zabzoProgressGradient.append("svg:stop").attr("offset", "50%").attr("stop-color", "#EC5F27").attr("stop-opacity", 1);
    progressBar = svgEl.append('svg:rect').attr('class', 'progress-bar').attr('width', progressMaxWidth * currentProgress).attr('height', svgHeight * .5).attr('x', 0).attr('y', svgHeight / 4).attr('rx', 10).attr('ry', 10).style('box-shadow', '0 0 4px #343434').style('fill', 'url(#zabzoProgressGradient)').style('stroke', '#b8b8b8');
    ZABZO.d3Els.progressBar = progressBar;
    zabzoGroup = svgEl.append('svg:g').attr('class', 'zabzo');
    ZABZO.d3Els.zabzo = zabzoGroup;
    return d3.json("/static/json/svg.json", function(json) {
      var startScale, translate;
      ZABZO.svgVars['zabzo-main'] = json['zabzo-main'];
      ZABZO.svgVars['zabzo-eyes-closed'] = json['zabzo-eyes-closed'];
      zabzoGroup.selectAll('path.zabzo').data(json['zabzo-main']).enter().append('svg:path').attr('d', function(d) {
        return d.path;
      }).attr('fill', function(d) {
        return d.fill;
      }).attr('class', 'zabzo');
      startScale = .1;
      translate = [(currentProgress * progressMaxWidth) - ZABZO.svgVars.barWidthPadding, 50];
      zabzoGroup.attr('transform', 'translate(' + translate + ') scale(.2)');
      return ZABZO.svgVars.zabzoPosition = translate;
    });
  };

  ZABZO.animate = function() {
    if (ZABZO.currentProgress < 0.34) {
      return ZABZO.animate1();
    } else if (ZABZO.currentProgress > 0.33 && ZABZO.currentProgress < 0.67) {
      return ZABZO.animate2();
    } else if (ZABZO.currentProgress > 0.36 && ZABZO.currentProgress < 1.0) {
      return ZABZO.animate3();
    } else if (ZABZO.currentProgress > .99) {
      return ZABZO.animate4();
    }
  };

  ZABZO.updateProgress = function(progressAmount) {
    var curY, currentProgress, firstTransitionOffsetX, scaleFactor, svgEl, translate, xOffset;
    svgEl = d3.select('#zabzo-svg');
    if (progressAmount === -1) {
      currentProgress = 0;
    } else {
      currentProgress = ZABZO.currentProgress + (progressAmount / 100);
    }
    if (currentProgress > 1) return false;
    ZABZO.domEls.progress.html(parseInt(currentProgress * 100, 10) + '%');
    ZABZO.currentProgress = currentProgress;
    ZABZO.d3Els.progressBar.transition().duration(1000).ease('elastic').attr('width', ZABZO.svgVars.progressMaxWidth * currentProgress);
    scaleFactor = (.72 * (currentProgress + .4)) * (ZABZO.svgVars.progressHeight / 180);
    curY = (ZABZO.svgVars.progressHeight / 2) - ((ZABZO.svgVars.progressHeight / 4) * (currentProgress + .6));
    xOffset = (ZABZO.svgVars.barWidthPadding * (currentProgress + .2)) * (ZABZO.svgVars.progressHeight / 200);
    firstTransitionOffsetX = 90 * (currentProgress + .2);
    translate = [(currentProgress * ZABZO.svgVars.progressMaxWidth) - xOffset, curY];
    ZABZO.svgVars.zabzoPosition = translate;
    return ZABZO.d3Els.zabzo.transition().ease('circle').attr('transform', 'translate(' + [translate[0] - firstTransitionOffsetX, translate[1]] + ') scale(' + scaleFactor + ') rotate(60, 50, 50)').each('end', function() {
      return ZABZO.d3Els.zabzo.transition().ease('exp').attr('transform', 'translate(' + translate + ') scale(' + scaleFactor + ')');
    });
  };

  return this;

}).call(this);
