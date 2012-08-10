var _this = this;

ZABZO.animate1 = function(options) {
  var duration1, duration2, ease1, ease2, factorX, factorY, isPopup, leftMovement, pos, posLeft, posRight, progressHeight, progressWidth, scale, targetObj, topMovement, zabzo;
  options = options || {};
  isPopup = options.isPopup || false;
  targetObj = ZABZO;
  if (isPopup) targetObj = ZABZO.popup;
  pos = targetObj.svgVars.zabzoPosition;
  progressHeight = targetObj.svgVars.progressHeight;
  progressWidth = targetObj.svgVars.progressMaxWidth;
  if (progressWidth > 800) {
    factorX = progressWidth / 6;
  } else {
    factorX = progressWidth / 4;
  }
  factorY = progressHeight / 1.5;
  leftMovement = factorX * ZABZO.currentProgress;
  topMovement = factorY * ZABZO.currentProgress;
  posLeft = [pos[0] - leftMovement, pos[1] + topMovement];
  posRight = [pos[0] + leftMovement, pos[1] + topMovement];
  zabzo = targetObj.d3Els.zabzo;
  scale = zabzo.attr('transform').match(/scale\([^)]+\)/);
  if (scale && scale.length > 0) {
    scale = scale[0] + ' ';
  } else {
    scale = '';
  }
  ease1 = 'linear';
  ease2 = 'linear';
  duration1 = 500;
  duration2 = 650;
  return zabzo.transition().ease(ease1).duration(duration1).attr('transform', 'translate(' + posLeft + ') ' + scale).each('end', function() {
    return zabzo.transition().ease(ease2).duration(duration2).attr('transform', 'translate(' + pos + ') ' + scale).each('end', function() {
      return zabzo.transition().ease(ease1).duration(duration1).attr('transform', 'translate(' + posRight + ') ' + scale).each('end', function() {
        return zabzo.transition().ease(ease2).duration(duration2).attr('transform', 'translate(' + pos + ') ' + scale).each('end', function() {
          return ZABZO.animate(options);
        });
      });
    });
  });
};

ZABZO.animate2 = function(options) {
  var duration1, duration2, ease1, ease2, isPopup, pos, posBottom, posTop, progressHeight, progressWidth, scale, targetObj, zabzo;
  options = options || {};
  isPopup = options.isPopup || false;
  targetObj = ZABZO;
  if (isPopup) targetObj = ZABZO.popup;
  progressHeight = targetObj.svgVars.progressHeight;
  progressWidth = targetObj.svgVars.progressMaxWidth;
  pos = targetObj.svgVars.zabzoPosition;
  posTop = [pos[0], pos[1] + progressHeight / 9];
  posBottom = [pos[0], pos[1] + ((progressHeight / 3) * ZABZO.currentProgress)];
  zabzo = targetObj.d3Els.zabzo;
  scale = zabzo.attr('transform').match(/scale\([^)]+\)/);
  if (scale.length > 0) {
    scale = scale[0] + ' ';
  } else {
    scale = '';
  }
  ease1 = 'quad';
  ease2 = 'elastic';
  duration1 = 950;
  duration2 = 1600;
  return zabzo.transition().ease(ease1).duration(duration1).attr('transform', 'translate(' + posBottom + ') ' + scale + '').each('end', function() {
    return zabzo.transition().ease(ease2).duration(duration2).attr('transform', 'translate(' + posTop + ') ' + scale + ' rotate(-40)').each('end', function() {
      return ZABZO.animate(options);
    });
  });
};

ZABZO.animate3 = function(options) {
  var duration1, duration2, ease1, ease2, factorX, factorY, isPopup, leftMovement, pos, posLeft, posRight, progressHeight, progressWidth, scale, targetObj, topMovement, zabzo;
  options = options || {};
  isPopup = options.isPopup || false;
  targetObj = ZABZO;
  if (isPopup) targetObj = ZABZO.popup;
  pos = targetObj.svgVars.zabzoPosition;
  progressHeight = targetObj.svgVars.progressHeight;
  progressWidth = targetObj.svgVars.progressMaxWidth;
  factorX = progressWidth / 10;
  factorY = progressHeight / 3;
  leftMovement = factorX * ZABZO.currentProgress;
  topMovement = factorY * ZABZO.currentProgress;
  posLeft = [pos[0] - leftMovement, pos[1] - topMovement];
  posRight = [pos[0] + leftMovement, pos[1] - topMovement];
  pos = [pos[0], pos[1] + progressHeight / 10];
  zabzo = targetObj.d3Els.zabzo;
  scale = zabzo.attr('transform').match(/scale\([^)]+\)/);
  if (scale.length > 0) {
    scale = scale[0] + ' ';
  } else {
    scale = '';
  }
  ease1 = 'linear';
  ease2 = 'linear';
  duration1 = 500;
  duration2 = 650;
  return zabzo.transition().ease(ease1).duration(duration1).attr('transform', 'translate(' + posLeft + ') ' + scale + 'rotate(30)').each('end', function() {
    return zabzo.transition().ease(ease2).duration(duration2).attr('transform', 'translate(' + pos + ') ' + scale + 'rotate(60)').each('end', function() {
      return zabzo.transition().ease(ease1).duration(duration1).attr('transform', 'translate(' + posRight + ') ' + scale + 'rotate(-90 ' + progressWidth / 10 + ' 100)').each('end', function() {
        return zabzo.transition().ease(ease2).duration(duration2).attr('transform', 'translate(' + pos + ') ' + scale).each('end', function() {
          return ZABZO.animate(options);
        });
      });
    });
  });
};

ZABZO.animate4 = function(options) {
  var duration1, duration2, ease1, ease2, factorX, factorY, isPopup, leftMovement, pos, posLeft, posRight, progressHeight, progressWidth, scale, targetObj, topMovement, zabzo, zabzoBBox;
  options = options || {};
  isPopup = options.isPopup || false;
  targetObj = ZABZO;
  if (isPopup) targetObj = ZABZO.popup;
  zabzoBBox = targetObj.d3Els.zabzo.node().getBBox();
  pos = targetObj.svgVars.zabzoPosition;
  progressHeight = targetObj.svgVars.progressHeight;
  progressWidth = targetObj.svgVars.progressMaxWidth;
  factorX = progressWidth / 7;
  factorY = progressHeight / 11;
  leftMovement = factorX * ZABZO.currentProgress;
  topMovement = factorY * ZABZO.currentProgress;
  posLeft = [pos[0] - leftMovement, pos[1] - topMovement];
  posRight = [pos[0] + leftMovement, pos[1] + topMovement];
  pos = [pos[0], pos[1] + progressHeight / 9];
  zabzo = targetObj.d3Els.zabzo;
  scale = zabzo.attr('transform').match(/scale\([^)]+\)/);
  if (scale.length > 0) {
    scale = scale[0] + ' ';
  } else {
    scale = '';
  }
  ease1 = 'linear';
  ease2 = 'linear';
  duration1 = 520;
  duration2 = 720;
  return zabzo.transition().ease('quad').duration(550).attr('transform', 'translate(' + [posLeft[0], posLeft[1] + progressHeight / 2] + ') ' + scale + 'rotate(230)').each('end', function() {
    return zabzo.transition().ease('quad').duration(750).attr('transform', 'translate(' + [pos[0], pos[1] + progressHeight / 7] + ') ' + scale + 'rotate(110)').each('end', function() {
      return zabzo.transition().ease(ease1).duration(duration1).attr('transform', 'translate(' + posRight + ') ' + scale + 'rotate(-90 ' + progressHeight / 2 + ' ' + progressHeight / 9 + ')').each('end', function() {
        return zabzo.transition().ease(ease2).duration(duration2).attr('transform', 'translate(' + pos + ') ' + scale + 'rotate(80 ' + progressHeight / 5 + ' ' + progressHeight / 10 + ')').each('end', function() {
          return ZABZO.animate(options);
        });
      });
    });
  });
};
