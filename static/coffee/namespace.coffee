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
        setupDemo: false
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

        #CLASS progress related (for race to weekend page)
        #---------
        classProgress: {}
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

    #Setup demo events
    #NOTE: This call is not required - only used to show how you can access
    #   zabzo functionality
    ZABZO.setupDemo()


ZABZO.setupDemo = ()=>
    #Setup DOM events
    #------------------------------------
    #ZABZO
    #We can call updateProgress directly
    $('#task-small').click( ()=>
        ZABZO.updateProgress(5) )
    $('#task-medium').click( ()=>
        ZABZO.updateProgress(15) )
    #Or fire off events 
    $('#task-big').click( ()=>
        ZABZO.events.trigger('zabzo:finishtask:big') )
    $('#task-100').click( ()=>
        ZABZO.events.trigger('zabzo:finishtask:100') )
    $('#task-reset').click( ()=>
        ZABZO.events.trigger('zabzo:resetProgress') )
    #The animate() function is used 
    $('#animate').click( ()=>
        ZABZO.animate() )
    #CLASS Progress
    #------------------------------------
    $('#updatePhil').click( ()=>
        #Takes in a class ID (e.g., 'phil165' and a number from 0 to 1)
        ZABZO.classProgress.updateClass('phil165', Math.random() )
    )
    
    #------------------------------------
    #Listen for events
    #------------------------------------
    ZABZO.events.on('zabzo:finishtask:big', ()=>
        #Update progress by 30%
        ZABZO.updateProgress(30)
    )
    ZABZO.events.on('zabzo:finishtask:100', ()=>
        #Update set progress to 100
        ZABZO.updateProgress(100)
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
    #   Initialize Zabzo
    #   NOTE - needs to be called anywhere Zabzo is displayed
    ZABZO.init()

    #Initialize class Progress
    #   NOTE - only needs to be called on race to weekend page
    ZABZO.classProgress.init()
)
