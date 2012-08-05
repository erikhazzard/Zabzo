# ============================================================================
# namespace.coffee
#
# Contains the code to make zabzo do stuff
# ============================================================================
# ============================================================================
# Setup Zabzo
# ============================================================================
ZABZO.setupZabzo = ()=>
    #Sets up the progress bar and zabzo mascot. Handles the initial render
    
    #get the Svg el
    svgEl = d3.select('#zabzo-svg')
    
    #Get width / height
    svgWidth = svgEl.attr('width')
    svgHeight = svgEl.attr('height')

    progressMaxWidth = svgWidth - 80
    ZABZO.svgVars.progressMaxWidth = progressMaxWidth

    #TOTAL PROGRESS VARIABLE (from 0 to 1, 0 to 100%)
    currentProgress = 0
    ZABZO.currentProgress = currentProgress

    #Draw the progress bar
    #TODO: function to draw just progress bar
    progressBar = svgEl.append('svg:rect')
        .attr('class', 'progress-bar')
        .attr('width', progressMaxWidth * currentProgress)
        .attr('height', svgHeight * .5)
        .attr('x', 0)
        .attr('y', svgHeight / 5)
        .style('fill', '#4477aa')
        .style('stroke', '#336699')

    #Store ref to it
    ZABZO.d3Els.progressBar = progressBar

    #Draw Zabzo
    #TODO: function to draw just zabzo
    zabzoGroup = svgEl.append('svg:g')
        .attr('class', 'zabzo')
    ZABZO.d3Els.zabzo = zabzoGroup
        
    #------------------------------------
    #Get Zabzo SVG
    #------------------------------------
    d3.json("/static/json/svg.json", (json)=>
        #Store zabzo path
        ZABZO.svgVars['zabzo-main'] = json['zabzo-main']
        ZABZO.svgVars['zabzo-eyes-closed'] = json['zabzo-eyes-closed']

        #Draw it
        zabzoGroup.selectAll('path.zabzo')
            .data(json['zabzo-main'])
            .enter()
            .append('svg:path')
                .attr('d', (d)=>
                    return d.path
                ).attr('fill', (d)=>
                    return d.fill
                ).attr('class', 'zabzo')

        startScale = .1
        translate = [(currentProgress * progressMaxWidth) - 80, 50]

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
    #   Animates based on current progress
    if ZABZO.currentProgress < 0.34
        return ZABZO.animate1()
    else if ZABZO.currentProgress > 0.33 && ZABZO.currentProgress < 0.67
        return ZABZO.animate2()

#----------------------------------------
#Animation functions - 1
#----------------------------------------
ZABZO.animate1 = ()=>
    #Animates Zabzo
    zabzoBBox = ZABZO.d3Els.zabzo.node().getBBox()

    #Get Zabzo position
    pos = ZABZO.svgVars.zabzoPosition
    factorX = 80
    factorY = 80

    leftMovement = (factorX * ZABZO.currentProgress)
    topMovement = (factorY * ZABZO.currentProgress)

    posLeft = [pos[0] - leftMovement, pos[1] + topMovement]
    posRight = [pos[0] + leftMovement, pos[1] + topMovement]

    #Store d3 selection reference
    zabzo = ZABZO.d3Els.zabzo

    #Get the original scale (we don't want to change it)
    scale = zabzo.attr('transform').match(/scale\([^)]+\)/)
    #only set the scale the first match item (should always be only one)
    #   if there was a scale set to begin with (there should be)
    if scale.length > 0
        scale = scale[0] + ' '
    else
        scale = ''

    ease1 = 'linear'
    ease2 = 'linear'

    duration1 = 500
    duration2 = 650

    #Animates zabzo
    zabzo
        #To the bottom left
        .transition()
        .ease(ease1)
        .duration(duration1)
        .attr('transform', 'translate(' + posLeft + ') ' + scale)
            .each('end', ()=>
                #to the top middle
                zabzo.transition()
                    .ease(ease2)
                    .duration(duration2)
                    .attr('transform', 'translate(' + pos + ') ' + scale)
                    .each('end', ()=>
                        #to the bottom right
                        zabzo.transition()
                        .ease(ease1)
                        .duration(duration1)
                        .attr('transform', 'translate(' + posRight + ') ' + scale)
                        .each('end', ()=>
                            #back to the top middle from bottom right
                            zabzo.transition()
                            .ease(ease2)
                            .duration(duration2)
                            .attr('transform', 'translate(' + pos + ') ' + scale)
                            .each('end', ()=>
                                ZABZO.animate()
                            )
                        )
                    )
                )

#----------------------------------------
#Animation functions - 2
#----------------------------------------
ZABZO.animate2 = ()=>
    #Animates Zabzo
    #Zabzo will move up and down
    zabzoBBox = ZABZO.d3Els.zabzo.node().getBBox()

    #Get Zabzo position
    pos = ZABZO.svgVars.zabzoPosition
    factorX = 10

    leftMovement = (factorX * ZABZO.currentProgress)

    #Set top left / right position
    #Original (from animate1)
    #posTop = [pos[0] + leftMovement, pos[1] - topMovement]
    #posBottom = [pos[0] - leftMovement, pos[1] - topMovement]

    posTop = [pos[0] + leftMovement, pos[1] + 30]
    posBottom = [pos[0] - leftMovement, pos[1] + (120 * ZABZO.currentProgress)]

    #Store d3 selection reference
    zabzo = ZABZO.d3Els.zabzo

    #Get the original scale (we don't want to change it)
    scale = zabzo.attr('transform').match(/scale\([^)]+\)/)
    #only set the scale the first match item (should always be only one)
    #   if there was a scale set to begin with (there should be)
    if scale.length > 0
        scale = scale[0] + ' '
    else
        scale = ''

    #Tranisiton effects
    ease1 = 'elastic'
    ease2 = 'quad'

    duration1 = 1600
    duration2 = 950

    '''
    zz = zabzo.selectAll('path.zabzo')
        .data(ZABZO.svgVars['zabzo-eyes-closed'])
        .enter()
    console.log(ZABZO.svgVars['zabzo-eyes-closed'])

    console.log(zz)
    zz.transition()
            .attr('d', (d)=>
                return d.path
            ).attr('fill', (d)=>
                return d.fill
            ).attr('class', 'zabzo')
    '''

    '''
    #Animates zabzo
    zabzo
        #To the top 
        .transition()
        .ease(ease1)
        .duration(duration1)
        .attr('transform', 'translate(' + posTop + ') ' + scale + ' rotate(-40)')
            .each('end', ()=>
                #to the bottom
                zabzo.transition()
                .ease(ease2)
                .duration(duration2)
                .attr('transform', 'translate(' + posBottom + ') ' + scale + '')
                .each('end', ()=>
                    ZABZO.animate()
                )
            )
    '''

#----------------------------------------
#Animation functions - 3
#----------------------------------------
ZABZO.animate3 = ()=>
    #Animates Zabzo
    zabzoBBox = ZABZO.d3Els.zabzo.node().getBBox()

    #Get Zabzo position
    pos = ZABZO.svgVars.zabzoPosition
    factorX = 80
    factorY = 60

    leftMovement = (factorX * ZABZO.currentProgress)
    topMovement = (factorY * ZABZO.currentProgress)

    #Set top left / right position
    posLeft = [pos[0] - leftMovement, pos[1] - topMovement]
    posRight = [pos[0] + leftMovement, pos[1] - topMovement]

    #Reset middle bottom position
    #   Move it down a bit more
    pos = [pos[0], pos[1] + 30]

    #Store d3 selection reference
    zabzo = ZABZO.d3Els.zabzo

    #Get the original scale (we don't want to change it)
    scale = zabzo.attr('transform').match(/scale\([^)]+\)/)
    #only set the scale the first match item (should always be only one)
    #   if there was a scale set to begin with (there should be)
    if scale.length > 0
        scale = scale[0] + ' '
    else
        scale = ''

    ease1 = 'linear'
    ease2 = 'linear'

    duration1 = 500
    duration2 = 650

    #Animates zabzo
    zabzo
        #To the top left
        .transition()
        .ease(ease1)
        .duration(duration1)
        .attr('transform', 'translate(' + posLeft + ') ' + scale + 'rotate(30)')
            .each('end', ()=>
                #to the bottom middle
                zabzo.transition()
                    .ease(ease2)
                    .duration(duration2)
                    .attr('transform', 'translate(' + pos + ') ' + scale + 'rotate(60)')
                    .each('end', ()=>
                        #to the top right
                        zabzo.transition()
                        .ease(ease1)
                        .duration(duration1)
                        .attr('transform', 'translate(' + posRight + ') ' + scale + 'rotate(-90 100 100)')
                        .each('end', ()=>
                            #back to the top middle from bottom right
                            zabzo.transition()
                            .ease(ease2)
                            .duration(duration2)
                            .attr('transform', 'translate(' + pos + ') ' + scale)
                            .each('end', ()=>
                                ZABZO.animate()
                            )
                        )
                    )
                )

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
        .ease('elastic')
        .attr('width', ZABZO.svgVars.progressMaxWidth * currentProgress)

    scaleFactor = 1 * (currentProgress + .2)
    curY = 70 - (50 * (currentProgress + .2))

    #XOffset
    xOffset = 80 * (currentProgress + .2)
    firstTransitionOffsetX = 90  * (currentProgress + .2)

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
