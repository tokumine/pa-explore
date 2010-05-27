var map;
var projection;
var MERCATOR_RANGE = 256;
var infowindow;
var trackData = [
    {x:63517,y:51217,z:17,surprise:false},
    {x:63517,y:51218,z:17,surprise:false},
    {x:63517,y:51219,z:17,surprise:false},
    {x:63517,y:51220,z:17,surprise:false},
    {x:63518,y:51220,z:17,surprise:false},
    {x:63519,y:51220,z:17,surprise:false},
    {x:63520,y:51220,z:17,surprise:false}
];




 function bound(value, opt_min, opt_max) {
   if (opt_min != null) value = Math.max(value, opt_min);
   if (opt_max != null) value = Math.min(value, opt_max);
   return value;
 }


 function degreesToRadians(deg) {
   return deg * (Math.PI / 180);
 }

 function radiansToDegrees(rad) {
   return rad / (Math.PI / 180);
 }  

function MercatorProjection() {
  this.pixelOrigin_ = new google.maps.Point(
      MERCATOR_RANGE / 2, MERCATOR_RANGE / 2);
  this.pixelsPerLonDegree_ = MERCATOR_RANGE / 360;
  this.pixelsPerLonRadian_ = MERCATOR_RANGE / (2 * Math.PI);
};
MercatorProjection.prototype.fromLatLngToPoint = function(latLng, opt_point) {
  var me = this;

  var point = opt_point || new google.maps.Point(0, 0);

  var origin = me.pixelOrigin_;
  point.x = origin.x + latLng.lng() * me.pixelsPerLonDegree_;
  // NOTE(appleton): Truncating to 0.9999 effectively limits latitude to
  // 89.189.  This is about a third of a tile past the edge of the world tile.
  var siny = bound(Math.sin(degreesToRadians(latLng.lat())), -0.9999, 0.9999);
  point.y = origin.y + 0.5 * Math.log((1 + siny) / (1 - siny)) * -me.pixelsPerLonRadian_;
  return point;
}; 


MercatorProjection.prototype.fromPointToLatLng = function(point) {
  var me = this;

  var origin = me.pixelOrigin_;
  var lng = (point.x - origin.x) / me.pixelsPerLonDegree_;
  var latRadians = (point.y - origin.y) / -me.pixelsPerLonRadian_;
  var lat = radiansToDegrees(2 * Math.atan(Math.exp(latRadians)) - Math.PI / 2);
  return new google.maps.LatLng(lat, lng);
}; 


 function CoordMapType(tileSize) {
   this.tileSize = tileSize;
 }

 CoordMapType.prototype.getTile = function(coord, zoom, ownerDocument) {
   var canvas = document.createElement("canvas");
   var id = 'id-' + coord.x + '-' + coord.y + '-' + zoom;

   if (typeof G_vmlCanvasManager != 'undefined') 
     G_vmlCanvasManager.initElement(canvas);

   canvas.id = id;
   canvas.width = canvas.height = 256;
   canvas.style.width = '256px';
   canvas.style.height = '256px';	
   canvas.style.left = '0px';
   canvas.style.top =  '0px';
   canvas.style.position = "relative";    

   var ctx = canvas.getContext("2d");
		var cross = canvas.getContext('2d');

   ctx.strokeStyle = "#FFF";
   ctx.lineWidth   = 1;
   ctx.beginPath();

   var cells = 4;
   if(zoom==16) {
     cells = 2;
   }    
   if(zoom==17) {
     cells = 1;
   }    

   if(zoom==14) {
     cells = 8;
   }
   if(zoom==13) {
     cells = 16;
   }    


   var cellsSize = 256/cells;
   for (var i = 0; i < cells; i++) {
     ctx.moveTo(0, (cellsSize*i));
     ctx.lineTo(256,(cellsSize*i));
     ctx.moveTo((cellsSize*i),0);
     ctx.lineTo((cellsSize*i),256);  
   }        
   ctx.stroke();    

   // ctx.fillStyle    = '#d6d6d6';
   //    ctx.font         = 'bold 10px sans-serif'
   //    ctx.fillText(zoom + ' / '+coord.x+ ' / '+coord.y, 10, 10);


   cross.strokeStyle = "#FFF";
   cross.lineWidth   = 2;
   cross.beginPath();

   for (var i = 0; i < cells; i++) {
     cross.moveTo(0, (cellsSize*i));
     cross.lineTo(10,(cellsSize*i));

	    for (var j = 1; j < cells; j++) {
	      cross.moveTo((cellsSize*j)-10, cellsSize*i);
	      cross.lineTo((cellsSize*j)+10, cellsSize*i);
	    }

			cross.moveTo(256, (cellsSize*i));
     cross.lineTo(246,(cellsSize*i));


     cross.moveTo((cellsSize*i),0);
     cross.lineTo((cellsSize*i),10);

	    for (var j = 1; j < cells; j++) {
	      cross.moveTo(cellsSize*i, (cellsSize*j)-10 );
	      cross.lineTo(cellsSize*i,(cellsSize*j)+10);
	    }

			cross.moveTo((cellsSize*i), 256);
     cross.lineTo((cellsSize*i), 246);


   }        
   cross.stroke();



   return canvas;
 };


 function getTileByLatLng(latlng) {
   var worldCoordinate = projection.fromLatLngToPoint(latlng);
   var pixelCoordinate = new google.maps.Point(worldCoordinate.x * Math.pow(2, map.getZoom()), worldCoordinate.y * Math.pow(2, map.getZoom()));
   var tileCoordinate = new google.maps.Point(Math.floor(pixelCoordinate.x / MERCATOR_RANGE), Math.floor(pixelCoordinate.y / MERCATOR_RANGE));

   var tileCoordStr = "Tile Coordinate: " + tileCoordinate.x + " , " + tileCoordinate.y + " at Zoom Level: " + map.getZoom();
   console.log(tileCoordStr)
 }

 function getCellByLatLng(latlng) {
   var worldCoordinate = projection.fromLatLngToPoint(latlng);
   var pixelCoordinate = new google.maps.Point(worldCoordinate.x * Math.pow(2, 17), worldCoordinate.y * Math.pow(2, 17));
   var tileCoordinate = new google.maps.Point(Math.floor(pixelCoordinate.x / MERCATOR_RANGE), Math.floor(pixelCoordinate.y / MERCATOR_RANGE));

   var tileCoordStr = "Cell Coordinate: " + tileCoordinate.x + " , " + tileCoordinate.y + " at Zoom Level: 17";
   console.log(tileCoordStr) 
 }

 function getTileIdforCell(cell) {

 }


 function random_color(format)
 {
  var rint = Math.round(0xffffff * Math.random());
  switch(format)
  {
   case 'hex':
    return ('#0' + rint.toString(16)).replace(/^#0([0-9a-f]{6})$/i, '#$1');
   break;

   case 'rgb':
    return 'rgb(' + (rint >> 16) + ',' + (rint >> 8 & 255) + ',' + (rint & 255) + ')';
   break;

   default:
    return rint;
   break;
  }
 }


	
	function openInfoWindow(latlng) {
		if (infowindow!=null) {
			infowindow.moveTo(latlng);
		} else {
			infowindow = new InfoWindow( latlng, map);
		}
	}


	function initialize() {
	  var myLatlng = new google.maps.LatLng(-34.397, 150.644);


   var mapOptions = {
     zoom: 15,
     center: new google.maps.LatLng(36.54088231109613, -5.533879986309818),
     mapTypeId: google.maps.MapTypeId.SATELLITE,
     mapTypeControl: false,
     navigationControl: false,
     scaleControl: false
   };
   map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions);
   projection = new MercatorProjection();

	 infowindow = new InfoWindow( new google.maps.LatLng(36.54088231109613, -5.533879986309818), map);


   google.maps.event.addListener(map, "zoom_changed", function() {
       if (map.getZoom() > 17) map.setZoom(17);
       if (map.getZoom() < 13) map.setZoom(13);
   });

   google.maps.event.addListener(map, "click", function(event) {
       getTileByLatLng(event.latLng);
       getCellByLatLng(event.latLng);
   });    


   map.overlayMapTypes.insertAt(0, new CoordMapType(new google.maps.Size(256, 256)));
	}
