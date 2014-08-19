//= require map

var search = (function(){    

    return {

	load : function () {
	    $("select[name=profession]").minimalect(
		{
		    theme: "bubble", 
		    live: false,
		    placeholder: "Choose one...",
		    onchange: function (value, text) {
			$.get("/home/" + value + "/specialities", function ( data ) {
			    search.replaceSpecialities( data );
			});
		    }
		}
	    );
	    $("select[name=speciality]").minimalect(
		{
		    theme: "bubble",
		    placeholder: "Choose one...",
		    live: false,
		    onchange: search.doAjaxSearch
		});
	    search.setupSubmit();
	    search.doAjaxSearch();
	},

	doAjaxSearch : function () {
	    if ( $(".map-holder").length === 0 ) {
		return false;
	    }
	    $.get("/search/index.json", {
		profession: $("select[name=profession]").val(), 
		speciality: $("select[name=speciality]").val(), 
		city: $("input[name=city]").val()
	    }, search.renderMapSearchResults )
	},

	doGeoSearch : function ( bounds ) {
	    var ne = bounds.getNorthEast();
	    var sw = bounds.getSouthWest();
	    $.get("/search/index.json", {
		profession: $("select[name=profession]").val(),
		speciality: $("select[name=speciality]").val(), 		
		ne: {ne.lat(), ne.lng()},
		sw: {sw.lat(), sw.lng()}
	    }, search.renderMapSearchResults)
	},

	renderMapSearchResults : function ( data ) {
	    var template = $("#search_result\\.mustache_template").text();
	    var output = Mustache.render(template, data);
	    search.results = data.users;
	    $(".results ol").html(output);
	    searchMap.reload();
	},

	doMapSearch: function () {
	    if ( $("#c1").length !== 0 && $("#c1").prop("checked") ) {
	    }
	},

	replaceSpecialities : function ( specialities ) {
	    var specialitiesOptions = $("select[name=speciality]");
	    specialitiesOptions.empty();
	    $.each( specialities, function( index, speciality ) {
	    	specialitiesOptions.append($("<option></option>")
	    				    .attr("value", speciality.value).text(speciality.text));
	    });
	},

	setupSubmit : function () {
	    $("#search-form").on("click", "a.submit", function ( ev ) {
		$("#search-form").submit();
	    });
	    $(".filter-menu").on("click", "a.submit", function ( ev ) {
		search.doAjaxSearch();
	    });
	}
    }
})();

$(document).ready( function () {
    search.load();
});
