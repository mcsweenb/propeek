var review = (function(){

    return {

	load : function () {
	    $("#submit-review-holder").on("click", ".submit", function () {
		$("#review-form").submit();
	    });
	},
    }
})();

$(document).ready( function () {
    review.load();
});
