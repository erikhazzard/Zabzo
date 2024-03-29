# ============================================================================
# demo_init
# NOTE: For most cases, all you will need to call is setupZabzo({ })
#   and pass in the 'svgId' ({String} containing the reference to the SVG 
#   element ) and isPopup ({Boolean} specifying if you're setting up a popup)
#    
# Functions
#
# ============================================================================
# Init
# ---------------------------------------
ZABZO.init = ()=>
    #Setup zabzo. This is required anywhere you want Zabzo
    #   Note: Must pass in svgId. Points to the SVG element which zabzo lives
    #   in
    ZABZO.setupZabzo({svgId: "#zabzo-svg"})

    #Specify the DOM elment the progress % will go inside.  This is optional
    #   Use it if you want to display the current progress % as text
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
    $('#task-big').click( ()=>
        ZABZO.updateProgress(30)
    )
    $('#task-100').click( ()=>
        ZABZO.updateProgress(100)
    )
    $('#task-reset').click( ()=>
        ZABZO.updateProgress(-1)
    )
    #The animate() function is used 
    $('#animate').click( ()=>
        ZABZO.animate() )
    #CLASS Progress
    #------------------------------------
    $('#updatePhil').click( ()=>
        #Takes in a class ID (e.g., 'phil165' and a number from 0 to 1)
        ZABZO.classProgress.updateClass('phil165', Math.random() )
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

    if $('#class-progress-svg-wrapper').length > 0
        #Initialize class Progress
        #   NOTE - Call this function on the race to weekend page
        ZABZO.classProgress.init({
            targetId: '#class-progress-svg-wrapper'
        })
)
