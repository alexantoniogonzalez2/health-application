$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#buscadorHora').fullCalendar({
       // will hide Saturdays and Sundays
        dayClick: function() {
       		alert('a day has been clicked!');
       		$('#buscadorHora').fullCalendar('next');
    		}

    })

});