var ZABZO,
  _this = this;

ZABZO = (function() {
  var publicAPI;
  publicAPI = {
    events: _.extend({}, Backbone.Events),
    init: false,
    setupDemo: false,
    setupZabzo: false,
    updateProgrses: false,
    animate: false,
    currentProgress: 0,
    d3Els: {},
    domEls: {},
    svgVars: {},
    classProgress: {}
  };
  return publicAPI;
})();

window.ZABZO = ZABZO;

ZABZO.init = function() {
  ZABZO.setupZabzo();
  ZABZO.domEls.progress = $('#progress-val');
  return ZABZO.setupDemo();
};

ZABZO.setupDemo = function() {
  $('#task-small').click(function() {
    return ZABZO.updateProgress(5);
  });
  $('#task-medium').click(function() {
    return ZABZO.updateProgress(15);
  });
  $('#task-big').click(function() {
    return ZABZO.events.trigger('zabzo:finishtask:big');
  });
  $('#task-100').click(function() {
    return ZABZO.events.trigger('zabzo:finishtask:100');
  });
  $('#task-reset').click(function() {
    return ZABZO.events.trigger('zabzo:resetProgress');
  });
  $('#animate').click(function() {
    return ZABZO.animate();
  });
  $('#updatePhil').click(function() {
    return ZABZO.classProgress.updateClass('phil165', Math.random());
  });
  ZABZO.events.on('zabzo:finishtask:big', function() {
    return ZABZO.updateProgress(30);
  });
  ZABZO.events.on('zabzo:finishtask:100', function() {
    return ZABZO.updateProgress(100);
  });
  return ZABZO.events.on('zabzo:resetProgress', function() {
    return ZABZO.updateProgress(-1);
  });
};

$(document).ready(function() {
  ZABZO.init();
  return ZABZO.classProgress.init();
});
