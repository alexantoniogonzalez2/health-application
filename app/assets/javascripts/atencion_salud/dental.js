// Grab all elements with the class "hasTooltip"
$('.img_dental').each(function() { // Notice the .each() loop, discussed below
    $(this).qtip({
    		show: 'click',
    		hide: 'click',
        content: {
          text: $( "#tooltip_dental" ).html(),
          button: true
        }
        ,
	   		style: {
	        classes: 'qtip-rounded qtip-bootstrap'
	    	},
	    	 position: {
             target: 'mouse', // Use the mouse position as the position origin
             adjust: {
                 // Don't adjust continuously the mouse, just use initial position
                 mouse: false
             } 
         }
    });
});