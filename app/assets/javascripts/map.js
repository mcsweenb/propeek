
var searchMap = (function () {

    return {
	setCenter : function () {
	    if ( _.isUndefined( search.results ) ) {
		this.center = new google.maps.LatLng(40.7127, -74.0059);
	    } else {
		with ( search.results[0] ) {
		    this.center = new google.maps.LatLng(lat, lon);
		}
	    }
	},

	resetCenter : function () {
	    if ( _.isUndefined( search.results ) ) {
		this.map.setCenter(new google.maps.LatLng(40.7127, -74.0059));
	    } else if ( _.isEmpty( search.results ) ) {
		//no op, don't pan map to anywhere
	    } else {
		with ( search.results[0] ) {
		    this.map.setCenter(new google.maps.LatLng(lat, lon));
		}
	    }
	},
	
	reload : function () {
	    if ( _.isUndefined( this.map ) ) {
		this.load();
		this.loadMarkers();
		this.setToBounds();
		this.setupMapSearch();
	    } else {
		this.loadMarkers();
		this.setToBounds();
	    }
	},

	setupMapSearch : function () {
	    google.maps.event.addListener(this.map, 'dragend', function() {
		search.doGeoSearch(searchMap.map.getBounds());
	    });
	    google.maps.event.addListener(this.map, 'zoom_changed', function() {
		search.doGeoSearch(searchMap.map.getBounds());
	    });
	},

	load : function () {
	    this.setCenter();
            this.mapOptions = {
		center: this.center,
		zoom: 14
            };
	    this.map = new google.maps.Map(document.getElementById("search-map"),
					   this.mapOptions);
	    this.markers = [];
	    this.bounds = new google.maps.LatLngBounds();
	},
	
	loadMarkers : function () {
	    this.resetCenter();
	    this.clearMarkers();
	    _.each( search.results , function ( result ) {
		var marker = new google.maps.Marker({
		    position: new google.maps.LatLng(result.lat, result.lon),
		    map: this.map,
		    title: result.fullname
		});
		google.maps.event.addListener(marker, 'click', function() {
		    var map_holder_offset = $("#search-map").position().top;
		    var result_element = $("#result-" + result.id);
		    $("html, body").animate({scrollTop: (result_element.position().top - map_holder_offset)}, function () {
			result_element.effect('highlight');
		    });
		});
		this.markers.push(marker);
		this.bounds.extend(marker.getPosition());
	    }, this);
	},

	clearMarkers : function () {
	    _.each( this.markers, function ( marker ) {
		marker.setMap(null);
	    }, this );
	    this.markers = [];
	    this.clearBounds();
	},
	
	clearBounds : function () {
	    this.bounds = new google.maps.LatLngBounds();
	},

	setToBounds : function () {
	    this.map.fitBounds(this.bounds);	    
	}
    };

})();
