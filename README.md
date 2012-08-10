# Zabzo Animations
Animations for Zabzo! Using SVG elements

## Dependencies
D3, JQuery

(Optional) (For running make)- Node, NPM ( Node package manager - http://npmjs.org/ ) - used to compile Less and minify JS

## Getting Started
-----------------------------------------
Run the files from a web server (e.g., in this directory type `python -m SimpleHTTPServer 9000`) and then access url (e.g., http://localhost:9000)

## General Notes
-----------------------------------------
View static/coffee/demo_init.coffee for examples of how to update Zabzo's progress and animate him (by calling updateProgress(N) and animate())
View static/coffee/ files for source code behind Zabzo

## Required Files
-----------------------------------------
Check the index files for examples.  You will need D3 and Jquery as the libraries. Here is a list of all required files:
`
<!-- Third party -->
<script src='static/lib/d3.js'></script>
<script src='static/lib/jquery.js'></script>

<!-- Zabzo script -->
<!-- Must be included on every page zabzo is shown -->
<script src='static/js/namespace.js'></script>
<!-- contains svg definition of zabzo -->
<script src='static/js/zabzo.js'></script>
<script src='static/js/zabzoSvg.js'></script>
<script src='static/js/animations.js'></script>

<!-- Class progress
    Needs to be included wherever class progress is shown (mainly, on the race 
    to weekend page) -->
<script src='static/js/classProgress.js'></script>
`

## Setting up Zabzo
-----------------------------------------
To setup Zabzo with the progress bar background, you need to have the following:
1. A <svg> element with an ID and width and height. See index.html for an example
2. A function call to ZABZO.setupZabzo({ svgId: "#zabzo-svg-popup" }). You must pass in the ID of the SVG element from step 1
That's it!

### Popups
-----------------------------------------
Note: You may setup the popup yourself using whatever code / plugins you'd like.  All that you need to do to get Zabzo to show is descibed here.  To setup Zabzo in a standalone popup window, do the following:
1. A <svg> element with an ID and width and height. See index_popup.html for an example
2. A function call to `ZABZO.setupZabzo({ svgId: "#zabzo-svg-popup", isPopup:true, callback: function(){
                //After zabzo is setup, animate him
                ZABZO.animate({isPopup:true});
            }
        })`
You must pass in the ID of the SVG element from step 1. 
You must also pass in isPopup: true.  
You may also pass in a callback function. If you want Zabzo to animate as soon as he is setup (as soon as you show a popup), just pass in a callback function which will call `animate({isPopup:true});`
That's it!

Note: When closing your popup, you should call `ZABZO.animateEnd({ isPopup: true });` to kill the animation


## Setting up Class progress bars
-----------------------------------------
Note: You must include the classProgress.js file
Call the following code to setup the class progress wrappers
`
        ZABZO.classProgress.init({
            targetId: '#class-progress-svg-wrapper'
        })
`
Note: #class-progress-svg-wrapper is assumed to be a <div> tag that will be populate with SVG elements.  This div should be empty, as it gets auto populates when calling init().

To update a specific class' progress, call
`
        ZABZO.classProgress.updateClass('phil165', 0.5);
`
where 'phil165' is the class ID and 0.5 is the progress to set the bar to
