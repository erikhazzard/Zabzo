# ============================================================================
# animationes.coffee
#
# Contains code which handles zabzo's animations.  
# Each animation function is called from the animate() function in 
#   zabzo.coffee. Each function gets passed an options object which is the
#   same object passed into the animate() function in zabzo.coffee. 
#       It contains key isPopup: {Boolean} Specifies wheter this is a popup 
#       or not. If it is, the popup zabzo element will be animated
# ============================================================================
#----------------------------------------
#Animation functions - 1
#----------------------------------------
ZABZO.animate1 = (options)=>
    #Animation 1 - Zabzo moves left / right and up / down, like a frown
    #Get options
    options = options || {}
    isPopup = options.isPopup || false
    #set target ZABZO object
    targetObj= ZABZO
    
    #If this is popup, change the refrence from ZABO to ZABZO.popup
    if isPopup
        targetObj = ZABZO.popup

    #------------------------------------
    #Get Zabzo position
    pos = targetObj.svgVars.zabzoPosition

    #Store progress height
    progressHeight = targetObj.svgVars.progressHeight
    progressWidth = targetObj.svgVars.progressMaxWidth
    
    #How much to move zabzo
    if progressWidth > 800
        factorX = progressWidth / 6
    else
        factorX = progressWidth / 4

    factorY = progressHeight / 1.5

    #NOTE: currentProgress is always a pointer to ZABZO.currentProgress
    leftMovement = (factorX * ZABZO.currentProgress)
    topMovement = (factorY * ZABZO.currentProgress)

    #Get left and right position
    posLeft = [pos[0] - leftMovement, pos[1] + topMovement]
    posRight = [pos[0] + leftMovement, pos[1] + topMovement]

    #Store d3 selection reference
    zabzo = targetObj.d3Els.zabzo

    #Get the original scale (we don't want to change it)
    scale = zabzo.attr('transform').match(/scale\([^)]+\)/)
    #only set the scale the first match item (should always be only one)
    #   if there was a scale set to begin with (there should be)
    if scale and scale.length > 0
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
                                #Make sure to repass in the options object
                                ZABZO.animate(options)
                            )
                        )
                    )
                )

#----------------------------------------
#Animation functions - 2
#----------------------------------------
ZABZO.animate2 = (options)=>
    #Animation 2 - Zabzo moves up and down
    #Get options
    options = options || {}
    isPopup = options.isPopup || false
    #set target ZABZO object
    targetObj= ZABZO
    
    #If this is popup, change the refrence from ZABO to ZABZO.popup
    if isPopup
        targetObj = ZABZO.popup
    #------------------------------------
    
    #Store progress height
    progressHeight = targetObj.svgVars.progressHeight
    progressWidth = targetObj.svgVars.progressMaxWidth

    #Get Zabzo position
    pos = targetObj.svgVars.zabzoPosition

    #Set top left / right position
    posTop = [pos[0], pos[1] + progressHeight / 9]
    posBottom = [pos[0], pos[1] + ((progressHeight / 3) * ZABZO.currentProgress)]

    #Store d3 selection reference
    zabzo = targetObj.d3Els.zabzo

    #Get the original scale (we don't want to change it)
    scale = zabzo.attr('transform').match(/scale\([^)]+\)/)
    #only set the scale the first match item (should always be only one)
    #   if there was a scale set to begin with (there should be)
    if scale.length > 0
        scale = scale[0] + ' '
    else
        scale = ''

    #Tranisiton effects
    ease1 = 'quad'
    ease2 = 'elastic'

    duration1 = 950
    duration2 = 1600

    #Animates zabzo
    zabzo
        #To the bottom 
        .transition()
        .ease(ease1)
        .duration(duration1)
        .attr('transform', 'translate(' + posBottom + ') ' + scale + '')
            .each('end', ()=>
                #to the top 
                zabzo.transition()
                .ease(ease2)
                .duration(duration2)
                .attr('transform', 'translate(' + posTop + ') ' + scale + ' rotate(-40)')
                .each('end', ()=>
                    ZABZO.animate(options)
                )
            )

#----------------------------------------
#Animation functions - 3
#----------------------------------------
ZABZO.animate3 = (options)=>
    #Animation 3 - Zabzo does a swoop (smile)
    #Get options
    options = options || {}
    isPopup = options.isPopup || false
    #set target ZABZO object
    targetObj= ZABZO
    
    #If this is popup, change the refrence from ZABO to ZABZO.popup
    if isPopup
        targetObj = ZABZO.popup
    #------------------------------------

    #Get Zabzo position
    pos = targetObj.svgVars.zabzoPosition

    #Store progress height
    progressHeight = targetObj.svgVars.progressHeight
    progressWidth = targetObj.svgVars.progressMaxWidth

    #How much to move zabzo
    factorX = progressWidth / 10
    factorY = progressHeight / 3

    leftMovement = (factorX * ZABZO.currentProgress)
    topMovement = (factorY * ZABZO.currentProgress)

    #Set top left / right position
    posLeft = [pos[0] - leftMovement, pos[1] - topMovement]
    posRight = [pos[0] + leftMovement, pos[1] - topMovement]

    #Reset middle bottom position
    #   Move it down a bit more
    pos = [pos[0], pos[1] + progressHeight / 10]

    #Store d3 selection reference
    zabzo = targetObj.d3Els.zabzo

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
        #Set to 230 to have zabzo fly up
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
                        .attr('transform', 'translate(' + posRight + ') ' + scale + 'rotate(-90 ' + progressWidth / 10 + ' 100)')
                        .each('end', ()=>
                            #back to the top middle from bottom right
                            zabzo.transition()
                            .ease(ease2)
                            .duration(duration2)
                            .attr('transform', 'translate(' + pos + ') ' + scale)
                            .each('end', ()=>
                                ZABZO.animate(options)
                            )
                        )
                    )
                )

#----------------------------------------
#Animation 4 ( 100 % )
#----------------------------------------
ZABZO.animate4 = (options)=>
    #Animation 4 - Zabzo bounces off the walls and goes crazy
    #Get options
    options = options || {}
    isPopup = options.isPopup || false
    #set target ZABZO object
    targetObj= ZABZO
    
    #If this is popup, change the refrence from ZABO to ZABZO.popup
    if isPopup
        targetObj = ZABZO.popup
    #------------------------------------
    #Animates Zabzo
    zabzoBBox = targetObj.d3Els.zabzo.node().getBBox()

    #Get Zabzo position
    pos = targetObj.svgVars.zabzoPosition

    #Store progress height
    progressHeight = targetObj.svgVars.progressHeight
    progressWidth = targetObj.svgVars.progressMaxWidth

    #How much to move zabzo
    factorX = progressWidth / 14
    factorY = progressHeight / 12

    leftMovement = (factorX * ZABZO.currentProgress)
    topMovement = (factorY * ZABZO.currentProgress)

    #Set top left / right position
    posLeft = [pos[0] - leftMovement, pos[1] - topMovement]
    posRight = [pos[0] + leftMovement, pos[1] + topMovement]

    #Reset middle bottom position
    #   Move it down a bit more
    pos = [pos[0], pos[1] + progressHeight / 9]

    #Store d3 selection reference
    zabzo = targetObj.d3Els.zabzo

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

    duration1 = 520
    duration2 = 720

    #Animates zabzo
    zabzo
        #To the top left
        .transition()
        .ease('quad')
        .duration(550)
        #Set to 230 to have zabzo fly up
        .attr('transform', 'translate(' + [posLeft[0], posLeft[1] + progressHeight / 2] + ') ' + scale + 'rotate(230)')
            .each('end', ()=>
                #to the bottom middle
                zabzo.transition()
                    .ease('quad')
                    .duration(750)
                    .attr('transform', 'translate(' + [pos[0], pos[1] + progressHeight / 7] + ') ' + scale + 'rotate(110)')
                    .each('end', ()=>
                        #to the top right
                        zabzo.transition()
                        .ease(ease1)
                        .duration(duration1)
                        .attr('transform', 'translate(' + posRight + ') ' + scale + 'rotate(-90 ' + progressHeight / 2 + ' ' + progressHeight / 9 + ')')
                        .each('end', ()=>
                            #back to the top middle from bottom right
                            zabzo.transition()
                            .ease(ease2)
                            .duration(duration2)
                            .attr('transform', 'translate(' + pos + ') ' + scale + 'rotate(80 ' + progressHeight / 5 + ' ' + progressHeight / 10 + ')')
                            .each('end', ()=>
                                ZABZO.animate(options)
                            )
                        )
                    )
                )

