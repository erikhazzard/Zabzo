(function() {
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
      popup: {
        d3Els: {},
        svgVars: {}
      },
      classProgress: {}
    };
    return publicAPI;
  })();

  window.ZABZO = ZABZO;

}).call(this);
