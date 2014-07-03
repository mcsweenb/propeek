var register = (function(){

    return {

	setup : function () {
	    register.setup_buttons();
	    register.setup_photo_selector();
	    register.setup_repeater();
	},

	setup_repeater : function () {
	    $(".add-another a").click(function(e){
		var last_element, cloned, last_index, add_to, new_index;

		add_to = $(this).parent().siblings(".repeater");
		last_element = add_to.find("fieldset:last")
		last_index = last_element.data("index");

		new_index = last_index + 1;
		cloned = last_element.clone(true);

		cloned.data("index", new_index);

		cloned.find("input, textarea").each(function () {
		    $(this).attr('name', this.name.replace(/\[\d\]/, "[" + new_index + "]"));
		    $(this).attr('id', this.id.replace(/_\d/, '_' + new_index));
		});

		add_to.append(cloned);
		
		e.preventDefault();
		// var html = "<fieldset>"+$(this).parent().parent().find('fieldset').html()+"</fieldset>";
		// console.log($(this).parent().parent().find('.repeater'));
		// $(this).parent().parent().find('.repeater').append(html);
	    });
	},

	setup_buttons : function () {
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

	setup_photo_selector: function () {
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
