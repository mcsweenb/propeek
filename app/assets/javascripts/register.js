var register = (function(){

    return {

	setup : function () {
	    register.setupButtons();
	    register.setupPhotoSelector();
	    register.setupRepeater();
	    register.setupDatepicker();
	},

	setupDatepicker : function () {
	    $(".datepicker").datepicker({ 
		dateFormat: "mm/dd/yy",
		showAnim: "slideDown",
		changeMonth: true,
		changeYear: true,
		yearRange: "c-50:c"
	    });
	},

	setupRepeater : function () {
	    $(".add-another a").click(function(e){
		var lastElement, cloned, lastIndex, addTo, newIndex;

		addTo = $(this).parent().siblings(".repeater");
		lastElement = addTo.find("fieldset:last")
		lastIndex = lastElement.data("index");

		newIndex = lastIndex + 1;
		$(".datepicker").datepicker("destroy");
		cloned = lastElement.clone();

		cloned.data("index", newIndex);

		cloned.find("input, textarea").each(function () {
		    $(this).attr('name', this.name.replace(/\[\d\]/, "[" + newIndex + "]"));
		    if ( $(this).attr('id').match(/\[id\]/) ) {
		    } else {
			$(this).attr('id', this.id.replace(/_\d/, '_' + newIndex));
		    }
		    $(this).val('');
		});

		addTo.append(cloned);
		$(".datepicker").datepicker();
		
		e.preventDefault();
		// var html = "<fieldset>"+$(this).parent().parent().find('fieldset').html()+"</fieldset>";
		// console.log($(this).parent().parent().find('.repeater'));
		// $(this).parent().parent().find('.repeater').append(html);
	    });
	},

	setupButtons : function () {
	    $(".register_form").on("click", "a.submit", function ( ev ) {
		ev.preventDefault();
		$(".register_form").submit();
	    });
	    $(".register_form").on("click", "a.skip", function ( ev ) {
		ev.preventDefault();
		document.location = $(this).attr('href');
	    });
	    $(".login_form").on("click", "a.previous", function ( ev ) {
		ev.preventDefault();
		$(".login_form").submit();
	    });
	},

	setupPhotoSelector: function () {
	    var holder = document.getElementById('photo-drop-zone'),
	    state = document.getElementById('status');
	    
	    if ( holder === null ) {
		return false;
	    }
	    
	    if (typeof window.FileReader === 'undefined') {
		state.className = 'fail';
	    } else {
		state.className = 'success';
		//state.innerHTML = 'File API & FileReader available';
		state.innerHTML = '';
	    }
	    
	    holder.ondragover = function () { $(this).addClass('hover'); return false; };
	    holder.ondragend = function () { $(this).removeClass('hover'); return false; };
	    holder.ondrop = function (e) {
		openWindow($('#crop-photo-holder'));
		e.preventDefault();
		handleFileSelect(e.dataTransfer.files,$('section.cropper'));
		$('#photo-drop-zone').removeClass('hover');
		
		return false;
		
	    };
	}
    }

})();

$(document).ready( function () {
    register.setup();
});
