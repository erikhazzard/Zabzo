(function() {
  var _this = this;

  ZABZO.init = function() {
    ZABZO.setupZabzo({
      svgId: "#zabzo-svg"
    });
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
      return ZABZO.updateProgress(30);
    });
    $('#task-100').click(function() {
      return ZABZO.updateProgress(100);
    });
    $('#task-reset').click(function() {
      return ZABZO.updateProgress(-1);
    });
    $('#animate').click(function() {
      return ZABZO.animate();
    });
    return $('#updatePhil').click(function() {
      return ZABZO.classProgress.updateClass('phil165', Math.random());
    });
  };

  $(document).ready(function() {
    ZABZO.init();
    if ($('#class-progress-svg-wrapper').length > 0) {
      return ZABZO.classProgress.init({
        targetId: '#class-progress-svg-wrapper'
      });
    }
  });

}).call(this);
