var _this = this;

ZABZO.setupZabzo = function() {
  var currentProgress, progressBar, progressMaxWidth, svgEl, svgHeight, svgWidth, zabzoGroup;
  svgEl = d3.select('#zabzo-svg');
  svgWidth = svgEl.attr('width');
  svgHeight = svgEl.attr('height');
  progressMaxWidth = svgWidth - 80;
  ZABZO.svgVars.progressMaxWidth = progressMaxWidth;
  currentProgress = 0;
  ZABZO.currentProgress = currentProgress;
  progressBar = svgEl.append('svg:rect').attr('class', 'progress-bar').attr('width', progressMaxWidth * currentProgress).attr('height', svgHeight * .5).attr('x', 0).attr('y', svgHeight / 5).style('fill', '#4477aa').style('stroke', '#336699');
  ZABZO.d3Els.progressBar = progressBar;
  zabzoGroup = svgEl.append('svg:g').attr('class', 'zabzo');
  ZABZO.d3Els.zabzo = zabzoGroup;
  return d3.json("/static/json/svg.json", function(json) {
    var startScale, translate;
    ZABZO.svgVars['zabzo-main'] = json['zabzo-main'];
    ZABZO.svgVars['zabzo-main-left'] = json['zabzo-main-left'];
    zabzoGroup.selectAll('path.zabzo').data(json['zabzo-main']).enter().append('svg:path').attr('d', function(d) {
      return d.path;
    }).attr('fill', function(d) {
      return d.fill;
    }).attr('class', 'zabzo');
    startScale = .1;
    translate = [(currentProgress * progressMaxWidth) - 80, 50];
    zabzoGroup.attr('transform', 'translate(' + translate + ') scale(.2)');
    return ZABZO.svgVars.zabzoPosition = translate;
  });
};

ZABZO.animate = function(direction) {
  var factorX, factorY, leftMovement, pos, posLeft, posRight, scale, topMovement, zabzo, zabzoBBox;
  zabzoBBox = ZABZO.d3Els.zabzo.node().getBBox();
  pos = ZABZO.svgVars.zabzoPosition;
  factorX = 80;
  factorY = 50;
  leftMovement = factorX * ZABZO.currentProgress;
  topMovement = factorY * ZABZO.currentProgress;
  posLeft = [pos[0] - leftMovement, pos[1] + topMovement];
  posRight = [pos[0] + leftMovement, pos[1] + topMovement];
  zabzo = ZABZO.d3Els.zabzo;
  scale = zabzo.attr('transform').match(/scale\([^)]+\)/);
  if (scale.length > 0) scale = scale[0];
  return zabzo.transition().ease('sin').duration(400).attr('transform', 'translate(' + posLeft + ') ' + scale).each('end', function() {
    return zabzo.transition().ease('quad').duration(500).attr('transform', 'translate(' + pos + ') ' + scale).each('end', function() {
      return zabzo.transition().ease('sin').duration(400).attr('transform', 'translate(' + posRight + ') ' + scale).each('end', function() {
        return zabzo.transition().ease('quad').duration(500).attr('transform', 'translate(' + pos + ') ' + scale).each('end', function() {
          return ZABZO.animate();
        });
      });
    });
  });
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
  scaleFactor = 1 * (currentProgress + .2);
  curY = 70 - (50 * (currentProgress + .2));
  xOffset = 80 * (currentProgress + .2);
  firstTransitionOffsetX = 90 * (currentProgress + .2);
  translate = [(currentProgress * ZABZO.svgVars.progressMaxWidth) - xOffset, curY];
  ZABZO.svgVars.zabzoPosition = translate;
  return ZABZO.d3Els.zabzo.transition().ease('circle').attr('transform', 'translate(' + [translate[0] - firstTransitionOffsetX, translate[1]] + ') scale(' + scaleFactor + ') rotate(60, 50, 50)').each('end', function() {
    return ZABZO.d3Els.zabzo.transition().ease('exp').attr('transform', 'translate(' + translate + ') scale(' + scaleFactor + ')');
  });
};

return this;
