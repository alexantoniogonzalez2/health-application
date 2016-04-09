// Grab all elements with the class "hasTooltip"
$('.img_dental').each(function() { // Notice the .each() loop, discussed below
    $(this).qtip({
    		show: 'click',
    		hide: {
                fixed: true,
                delay: 300
        },
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
	          mouse: false
	        } 
	      },
    });
});
