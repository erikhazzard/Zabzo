# ============================================================================
# clsasProgress.coffee
#
# Contains the code to update class progress bars
# ============================================================================
# ============================================================================
# Setup Call to create class progress bars
# ============================================================================
ZABZO.classProgress.init = ()=>
    #description: Initial setup for class progresses.  Only needs to be called
    #   once on the 'Race to Weekend' page.
    #Takes in a JSON file of class names / current progress and draws graphs
    #   for them
    
    #Configs
    #Padding around the bar, [top, right, bottom, left]
    padding = [0, 46, 0, 150]
    ZABZO.classProgress.padding = padding
    #This is a configurable number which will affect how tall each bar is
    wrapperHeight = 100

    #TODO: This would all be wrapped in an AJAX call and fired off as a 
    #   callback when the data returns
    
    #Dummy JSON data.  Expecting it to look something like this:
    #   name, id, and progress are used throughout this function.  id can
    #   be generated from the name if need be(no spaces, alphanumeric
    #   characters)
    #Replace classJson with returned data
    classJson = {"classes": [
        {"name": "Phil 165",
        "id": "phil165",
        "progress": 1.0 },
        {"name": "Ed 111",
        "id":"ed111",
        "progress": 0.6 },
        {"name": "CS 106B",
        "id":"cs106b",
        "progress": 0.7 },
        {"name": "Anthro 78",
        "id":"anthro78",
        "progress": 0.4 }
    ]}

    #Store reference to it
    ZABZO.classProgress.data = classJson

    #Store ref to dom node which class bars will go in
    wrapperId = "#class-progress-svg-wrapper"
    wrapperEl = $(wrapperId)
    #Remove everything
    wrapperEl.empty()

    wrapperWidth = wrapperEl.width()

    #Create an Xscale which we'll use to set the bar width
    xScale = d3.scale.linear()
        #Subtract 46 from the width to give some padding at the right side
        .range([0, wrapperWidth - (padding[1] + padding[3])])
        .domain([0, 1.0])
    #Store reference to it
    ZABZO.classProgress.xScale = xScale
    
    #Loop through each class and create progress bars for them
    for curClass in classJson.classes
        #Get the ID.  Assumming that there is a .id property for each
        #   class and that it only contains alphanumeric characters (no spaces)
        #   (a-zA-Z0-9)
        curId = curClass.id.replace(/\ /,"")

        #Append a SVG element
        svgEl = d3.select(wrapperId).append("svg")
            .attr("id", 'svg-' + curId)
            .attr("class", "classProgressViz")
            .attr('width', wrapperWidth)
            .attr('height', wrapperHeight)

        #Add gradient
        #   We add a gradient to each class wrapper, which allows us
        #   to have different gradients for different classes if we wanted
        progressGradient = svgEl.append("svg:defs")
          .append("svg:linearGradient")
            .attr("id", "gradient-" + curId)
            .attr("x1", "0%")
            .attr("y1", "0%")
            .attr("x2", "0%")
            .attr("y2", "100%")

        #Add stops (configure these to change the gradient color
        progressGradient.append("svg:stop")
            .attr("offset", "0%")
            .attr("stop-color", "#e0e0e0")
            .attr("stop-opacity", 1)
        progressGradient.append("svg:stop")
            .attr("offset", "100%")
            .attr("stop-color", "#cdcdcd")
            .attr("stop-opacity", 1)

        #Add the progress bar
        classWrapper = svgEl.append("svg:g")
            #Add group
            .attr("class", "classBarWrapper")


        #Set total width 
        #   Add 46px of padding on the right for space for % label
        progressWidth = xScale(curClass.progress)

        #Add the bar for class progress
        classWrapper
            .append("svg:rect")
            .attr("x", padding[3])
            .attr("y", 0)
            #multiply the curClass"s progress attribute by the 
            #   total width to get the width
            .attr("width", progressWidth)
            .attr("height", wrapperHeight)
            .style("fill", "url(#gradient-" + curId + ")")
            .style("stroke", "#b0b0b0")

        #Add label for class name
        classFontSize = 12
        classWrapper
            .append("svg:text")
            .attr("class", "className")
            .attr("x", padding[3] - 4)
            .attr("y", (wrapperHeight / 2) + (classFontSize / 2))
            .text( curClass.name )
            .style('text-anchor', 'end')
            #multiply the curClass"s progress attribute by the 
            #   total width to get the width
            .style("fill", "#232323")
            .style("font-size", classFontSize)
            .style("text-align", 'right')
        
        #Add % label
        progressFontSize = 18
        classWrapper
            .append("svg:text")
            .attr("class", "progressLabel")
            .attr("x", padding[3] + (progressWidth + 2))
            .attr("y", (wrapperHeight / 2) + (progressFontSize / 2))
            .text( d3.round((curClass.progress * 100), 2) + '%' )
            #multiply the curClass"s progress attribute by the 
            #   total width to get the width
            .style("fill", "#232323")
            .style("font-size", progressFontSize)

    #All done
    return true

# ============================================================================
#
# Function which will update an individual class bar width
#
# ============================================================================
ZABZO.classProgress.updateClass = (classId, progress)=>
    #parameters: classId: {String} ID of class (e.g., 'phil165')
    #            progress: {Float} Number 0 to 1 to set the progress of
    #            the passed int class to
    #description: Updates the progress for a specific class
    #usage: Call this function to update the progress.  For instance,
    #   a function could be written that gets the progress from the
    #   server then calls this function to update it
    
    #Get the element for the passed in class
    svgEl = d3.select('#svg-' + classId)

    #Recall the padding
    padding = ZABZO.classProgress.padding

    #Get width
    progressWidth = ZABZO.classProgress.xScale(progress)

    #Update the progress bar
    svgEl.selectAll('rect')
        .transition()
            .attr('width', progressWidth)

    #Update the % label
    svgEl.selectAll('text.progressLabel')
        .transition()
            .attr('x', padding[3] + (progressWidth + 2))
            .text( d3.round((progress * 100), 2) + '%')

    return true
