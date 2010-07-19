	
	var map;
	
	function initialize() {
		alert('jamon');
		var mapOptions = {
     zoom: 15,
		 scrollwheel: false,
     center: new google.maps.LatLng(40.4166,-3.7),
     mapTypeId: google.maps.MapTypeId.SATELLITE,
     mapTypeControl: false,
     navigationControl: false,
     scaleControl: false,
   	 disableDoubleClickZoom: true};


   	map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions);
	}