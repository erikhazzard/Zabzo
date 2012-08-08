# ============================================================================
# zabzo.coffee
#
# Contains the code to setup Zabzo and move him whenever progress is updated
# ============================================================================
# ============================================================================
# Setup Zabzo
# ============================================================================
ZABZO.setupZabzo = ()=>
    #------------------------------------
    #Sets up the progress bar and zabzo mascot. Handles the initial render
    #------------------------------------
    
    #get the Svg el
    svgEl = d3.select('#zabzo-svg')
    
    #Get width / height
    svgWidth = svgEl.attr('width')
    svgHeight = svgEl.attr('height')

    #Store ref to height (we'll store ref to width later)
    ZABZO.svgVars.progressHeight = svgHeight

    #Get the max width for the progress bar
    #   Don't make it cover the entire SVG's width, but close to it
    ZABZO.svgVars.barWidthPadding = 90
    progressMaxWidth = svgWidth - ZABZO.svgVars.barWidthPadding
    #Store a reference to it, we'll need it laster when updating the
    #   progress bar
    ZABZO.svgVars.progressMaxWidth = progressMaxWidth

    #TOTAL PROGRESS VARIABLE (from 0 to 1, 0 to 100%)
    currentProgress = 0
    ZABZO.currentProgress = currentProgress

    #------------------------------------
    #Add gradients for progress bars
    #------------------------------------
    zabzoProgressGradient = svgEl.append("svg:defs")
      .append("svg:linearGradient")
        .attr("id", "zabzoProgressGradient")
        .attr("x1", "0%")
        .attr("y1", "0%")
        .attr("x2", "0%")
        .attr("y2", "100%")

    #Change these stops to configure color
    zabzoProgressGradient.append("svg:stop")
        .attr("offset", "50%")
        .attr("stop-color", "#EE703E")
        .attr("stop-opacity", 1)
    zabzoProgressGradient.append("svg:stop")
        .attr("offset", "50%")
        .attr("stop-color", "#EC5F27")
        .attr("stop-opacity", 1)

    #------------------------------------
    #Draw the progress bar
    #------------------------------------
    progressBar = svgEl.append('svg:rect')
        .attr('class', 'progress-bar')
        .attr('width', progressMaxWidth * currentProgress)
        .attr('height', svgHeight * .5)
        .attr('x', 0)
        .attr('y', svgHeight / 4)
        #round it
        .attr('rx', 10)
        .attr('ry', 10)
        .style('box-shadow', '0 0 4px #343434')
        .style('fill', 'url(#zabzoProgressGradient)')
        .style('stroke', '#b8b8b8')

    #Store reference to the D3 selection
    ZABZO.d3Els.progressBar = progressBar

    #Draw Zabzo
    zabzoGroup = svgEl.append('svg:g')
        .attr('class', 'zabzo')
    #Store a reference to zabzo d3 selection 
    ZABZO.d3Els.zabzo = zabzoGroup
        
    #------------------------------------
    #Get Zabzo SVG
    #------------------------------------
    #NOTE: When in production, use amazon s3 OR /static/json/svg.json
    d3.json("static/json/svg.json", (json)=>
        #Store zabzo paths
        ZABZO.svgVars['zabzo-main'] = json['zabzo-main']
        #TODO: implementing different path transformations. Can be added in 
        #   version 2
        ZABZO.svgVars['zabzo-eyes-closed'] = json['zabzo-eyes-closed']

        #Draw zabzo
        zabzoGroup.selectAll('path.zabzo')
            .data(json['zabzo-main'])
            .enter()
            .append('svg:path')
                .attr('d', (d)=>
                    return d.path
                ).attr('fill', (d)=>
                    return d.fill
                ).attr('class', 'zabzo')

        #Start it small
        startScale = .1
        #Initial starting location (off screen)
        translate = [(currentProgress * progressMaxWidth) - ZABZO.svgVars.barWidthPadding, 50]

        #Start zabzo initially to be off the screen and tiny
        zabzoGroup.attr('transform',
            'translate(' + translate + ') scale(.2)')

        ZABZO.svgVars.zabzoPosition = translate
    )
    
#----------------------------------------
#
#Animate Zabzo
#
#----------------------------------------
ZABZO.animate = ()=>
    #Function call to animate zabo
    #This will call the coresponding zabzo animation function based on
    #   the user's current rogress
    if ZABZO.currentProgress < 0.34
        return ZABZO.animate1()
    else if ZABZO.currentProgress > 0.33 && ZABZO.currentProgress < 0.67
        return ZABZO.animate2()
    else if ZABZO.currentProgress > 0.36 && ZABZO.currentProgress < 1.0
        return ZABZO.animate3()
    else if ZABZO.currentProgress > .99
        return ZABZO.animate4()

#----------------------------------------
#
#Update Zabzo / progress bar functions
#
#----------------------------------------
ZABZO.updateProgress = (progressAmount)=>
    #Updates the progress bar and animates Zabzo
    #   parameters: progressAmount { Int } number from 0 to 100
    svgEl = d3.select('#zabzo-svg')

    if progressAmount == -1
        #If they reset progress, set to 9
        currentProgress = 0
    else
        #Get current progress and add the passed in progress amount
        #   to it (divide it by 100 so we get a percentage
        currentProgress = ZABZO.currentProgress + (progressAmount / 100)

    #Don't update the progress bar if they are already at (or above) 100%
    if currentProgress > 1
        #Already at max
        return false

    #Update HTML
    ZABZO.domEls.progress.html(
        parseInt(currentProgress * 100, 10) + '%')

    #Update stored progress
    ZABZO.currentProgress = currentProgress

    #Move the progress bar
    ZABZO.d3Els.progressBar
        .transition()
        .duration(1000)
        #Give it an elastic transition so we get a bounce type effect
        #   that isn't as bouncy as the "bounce" transition
        .ease('elastic')
        .attr('width', ZABZO.svgVars.progressMaxWidth * currentProgress)

    #------------------------------------
    #Scale factor is how much to resize Zabzo
    #NOTE: This controls how big zabzo gets during the entire process
    #------------------------------------
    #Scale zabo by the current progress and add a multiplier
    #   based on the progress bar's height so zabzo isn't bigger than the height
    scaleFactor = (.72 * (currentProgress + .4)) * (ZABZO.svgVars.progressHeight / 180)

    #If this is used on the header, we want zabzo to appear bigger the entire time
    if ZABZO.svgVars.progressHeight < 80
        scaleFactor = .17 + (currentProgress * .1)

    #Current y position
    #   We get the height of the progress bar and divide it by two, then 
    #   subtract the multiplier of the scale factor so Zabzo appears in
    #   the middle of the bar
    curY = (ZABZO.svgVars.progressHeight / 2) - ((ZABZO.svgVars.progressHeight / 4) * (currentProgress + .6))

    #XOffset
    xOffset = (ZABZO.svgVars.barWidthPadding * (currentProgress + .2)) * (ZABZO.svgVars.progressHeight / 200)

    #Specifies where to start the first transition animation at
    firstTransitionOffsetX = (ZABZO.svgVars.progressMaxWidth / 9 ) * (currentProgress + .2)

    #Specifies where to move Zabzo to
    translate = [
        ((currentProgress * ZABZO.svgVars.progressMaxWidth) - xOffset),
        curY
    ]

    #Save Zabzo position
    ZABZO.svgVars.zabzoPosition = translate

    #Move and Scale zabzo
    ZABZO.d3Els.zabzo
        .transition()
        .ease('circle')
        .attr('transform',
        'translate(' + [translate[0] - firstTransitionOffsetX , translate[1]] + ') scale(' + scaleFactor + ') rotate(60, 50, 50)')
            .each('end', ()=>
                ZABZO.d3Els.zabzo.transition()
                    .ease('exp')
                    .attr('transform', 'translate(' + translate + ') scale(' + scaleFactor + ')')
            )
   
   return @
