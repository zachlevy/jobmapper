// create the map on the page
function createLocator (url) {
  $('#map-container').storeLocator(
    {
      'dataType': 'json',
      'dataLocation': url,
      'slideMap' : false,
      'defaultLoc': true,
      'defaultLat': '43.655088',
      'defaultLng' : '-79.388349',
      'lengthUnit' : 'km',
      'zoomLevel': 9,
      'storeLimit' : -1,
    }
  );
}

$(function() {
	console.log("start");
	// dont forget to update the infowindow-description template for new products
	createLocator("http://lcbo.sagemixology.com/getlcbo.php?products=372078,372060");
});
