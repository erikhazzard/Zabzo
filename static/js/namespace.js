(function() {
  var ZABZO,
    _this = this;

  ZABZO = (function() {
    var publicAPI;
    publicAPI = {
      events: _.extend({}, Backbone.Events),
      init: false,
      setupZabzo: false,
      updateProgrses: false,
      animate: false,
      currentProgress: 0,
      d3Els: {},
      domEls: {},
      svgVars: {}
    };
    return publicAPI;
  })();

  window.ZABZO = ZABZO;

  ZABZO.init = function() {
    ZABZO.setupZabzo();
    ZABZO.domEls.progress = $('#progress-val');
    $('#task-small').click(function() {
      return ZABZO.events.trigger('zabzo:finishtask:small');
    });
    $('#task-medium').click(function() {
      return ZABZO.events.trigger('zabzo:finishtask:medium');
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
    ZABZO.events.on('zabzo:finishtask:small', function() {
      return ZABZO.updateProgress(5);
    });
    ZABZO.events.on('zabzo:finishtask:medium', function() {
      return ZABZO.updateProgress(15);
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
    return ZABZO.init();
  });

}).call(this);
