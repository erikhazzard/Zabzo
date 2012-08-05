# ============================================================================
# namespace.coffee
#
# Contains the code to make zabzo do stuff
# ============================================================================
# ============================================================================
# Setup Namespace
# ============================================================================
ZABZO = (()=>
    publicAPI = {

        #Global events
        events: _.extend({}, Backbone.Events)

        #Functions
        #---------
        init: false
        #Placeholder function to setup zabzo
        setupZabzo: false
        updateProgrses: false
        animate: false

        #References / saved variables
        #---------
        currentProgress: 0
        d3Els: {}
        domEls: {}
        svgVars: {}

    }
    return publicAPI
)()
window.ZABZO = ZABZO

# ============================================================================
#    
# Functions
#
# ============================================================================
# Init
# ---------------------------------------
ZABZO.init = ()=>
    #Setup zabzo svg stuff
    ZABZO.setupZabzo()

    #Get dom els
    ZABZO.domEls.progress = $('#progress-val')

    #Setup DOM events
    $('#task-small').click( ()=>
        ZABZO.events.trigger('zabzo:finishtask:small') )
    $('#task-medium').click( ()=>
        ZABZO.events.trigger('zabzo:finishtask:medium') )
    $('#task-big').click( ()=>
        ZABZO.events.trigger('zabzo:finishtask:big') )

    $('#task-reset').click( ()=>
        ZABZO.events.trigger('zabzo:resetProgress') )

    $('#animate-1').click( ()=>
        ZABZO.animate()
    )
    $('#animate-2').click( ()=>
        ZABZO.animate2()
    )

    #------------------------------------
    #Listen for events
    #------------------------------------
    ZABZO.events.on('zabzo:finishtask:small', ()=>
        #Update progress by 5%
        ZABZO.updateProgress(5)
    )
    ZABZO.events.on('zabzo:finishtask:medium', ()=>
        #Update progress by 15%
        ZABZO.updateProgress(15)
    )
    ZABZO.events.on('zabzo:finishtask:big', ()=>
        #Update progress by 30%
        ZABZO.updateProgress(30)
    )
    ZABZO.events.on('zabzo:resetProgress', ()=>
        #Update progress by 5%
        ZABZO.updateProgress(-1)
    )

# ============================================================================
#    
# Init
#
# ============================================================================
$(document).ready(()=>
    #Setup everything
    ZABZO.init()
)
