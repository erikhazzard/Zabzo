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

        #Variables we'll store related to popups
        #   NOTE: Shares similar references as ZABZO object
        popup: {
            d3Els: {},
            svgVars: {}
        }

        #CLASS progress related (for race to weekend page)
        #---------
        classProgress: {}
    }
    return publicAPI
)()
window.ZABZO = ZABZO
