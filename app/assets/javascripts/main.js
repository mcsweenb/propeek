$(document).ready(function(){
	
	$("select").minimalect({ theme: "bubble", placeholder: "Choose one..." });
	
	/* jQuery('#home-featured-carousel').jcarousel(); */
	
	$(".profile-link.logged-in a.menu-toggle").click(function(e){
		$(".profile-link.logged-in .menu").fadeToggle('fast');
		e.preventDefault();
	});
	
	//if page is shorter than the viewport, make it a bit taller
	if( $('body').height() < $(document).height() ) {
		$('.main-container').height( $(document).height() - $('.footer-container').height() );
	}
	
	//modal window
	$(".modal-window-holder > .bg").click(function(){
		closeWindow($(this).parent());
	});
	$(".modal-window-holder a.close").click(function(){
		closeWindow($(this).parent().parent().parent());
	});
	$(".review-cta-holder a").click(function(){
		openWindow($("#submit-review-holder"));
	});
	
	//star ratings slider
	if ($('#raty').length) {
		$('#raty').raty({
			path: 'assets/raty/',
			width: '250px'
		});
	}
	
	
	//profile template
	$(".profile .tab-bar a").click(function(){
		var tabIndex = $(this).parent().index();
		
		$(".profile .tab-bar li").removeClass("active");
		$(this).parent().addClass("active");
		
		$(".tab-content").hide(0);
		$(".profile .tab"+tabIndex).fadeIn("fast");
	});
	
	$(".notification-banner .close").click(function(e){
		e.preventDefault();
		$(this).parent().fadeOut(0);
	});
	
	$(".profile .controls a.edit").click(function(e){
		e.preventDefault();
		$(this).parent().parent().addClass('edit-mode');
	});
	$(".profile .controls a.cancel, .profile .controls a.save").click(function(e){
		e.preventDefault();
		$(this).parent().parent().removeClass('edit-mode');
	});
	
	//search template
	$(".search .more-filters").click(function(e){
		if($(".search .search-fields-holder").css('position') == 'absolute'){ //if on mobile, hide the search fields menu
			$(".search .search-fields-holder").hide();
		}
		$(".search .filter-menu").fadeToggle('fast');
		e.preventDefault();

	});
	$(".search .search-fields-summary").click(function(e){
		$(".search .filter-menu").hide();
		$(".search .search-fields-holder").fadeToggle('fast');
		e.preventDefault();

	});
	$(".search .filter-menu a.submit").click(function(e){
		$(".search .filter-menu").fadeToggle('fast');
		e.preventDefault();
	});
	$(".search .view-toggle-bar .tabs a.map-view").click(function(e){
		$(".results").fadeOut('fast');
		$(".map-holder").fadeIn('fast');
		$(".search .view-toggle-bar .tabs a").removeClass('active');
		$(this).addClass('active');
		e.preventDefault();
	});
	$(".search .view-toggle-bar .tabs a.list-view").click(function(e){
		$(".map-holder").fadeOut('fast');
		$(".results").fadeIn('fast');
		$(".search .view-toggle-bar .tabs a").removeClass('active');
		$(this).addClass('active');
		e.preventDefault();
	});
	
	// //register template
	// $(".add-another a").click(function(e){
		
	// 	var html = "<fieldset>"+$(this).parent().parent().find('fieldset').html()+"</fieldset>";
	// 	console.log($(this).parent().parent().find('.repeater'));
	// 	$(this).parent().parent().find('.repeater').append(html);
		
	// 	e.preventDefault();
	// });
	
	$("#files").change(function(e){
		openWindow($('#crop-photo-holder'));
		handleFileSelect(e.target.files,$('section.cropper'));
	});
	
	if ($('#specialities_tags').length) {
		$('#specialities_tags').tagsInput({width:'auto',
						   defaultText:'add a specialty',
						   placeholderColor:'#AAAAAA',
						   height:'64px'
						  });
	}
	if ($('#memberships_tags').length) {
		$('#memberships_tags').tagsInput({width:'auto',
						  defaultText:'add a membership',
						  placeholderColor:'#AAAAAA',
						  height:'64px'
						 });
	}
	if ($('#languages_tags').length) {
		$('#languages_tags').tagsInput({width:'auto',
						defaultText:'add a language',
						placeholderColor:'#AAAAAA',
						height:'64px'
					       });
	}

});

function closeWindow($window) {
	$window.fadeOut("fast");
	
}
function openWindow($window) {
	$window.fadeIn("fast");
	
}
function handleFileSelect(files,$target) {
	//var files = evt.target.files; // FileList object
	//var files = evt.dataTransfer.files;
	//console.log(files);
 // Loop through the FileList and render image files as thumbnails.
 for (var i = 0, f; f = files[i]; i++) {


   var reader = new FileReader();

   // Closure to capture the file information.
   reader.onload = (function(theFile) {
     return function(e) {
        // Render thumbnail.
        var span = document.createElement('span');
        
        span.innerHTML = ['<img class="thumb" id="crop-target" src="', e.target.result,
                      '" title="', escape(theFile.name), '" width="500" />'].join('');
        
        $($target).html(span); 
        //determine if it's portrait or landscape and set max height / width accordingly
        var pic_real_width, pic_real_height;
        $("<img/>") // Make in memory copy of image to avoid css issues
			    .attr("src", $('#crop-target').attr("src"))
			    .load(function() {
			        pic_real_width = this.width;   // Note: $(this).width() will not
			        pic_real_height = this.height; // work for in memory images.
			        console.log('width: '+pic_real_width);
			        console.log('height: '+pic_real_height);
			        
							if( pic_real_width >= pic_real_height) {
				        //$('#crop-target').attr('width','100%');
				        $('#crop-target').attr('width','100%');
				        
								$('#crop-target').attr('height',($('#crop-target').width()*pic_real_height)/pic_real_width);
			        }else {
								$('#crop-target').attr('height','500');
				        $('#crop-target').attr('width',(pic_real_width*$('#crop-target').height())/pic_real_height);
								
				        
			        }
			        initJcrop(); 
			    });
        
  };
    })(f);

    // Read in the image file as a data URL.
    reader.readAsDataURL(f);
  }
}

var jcrop_api; 
function initJcrop()//{{{
{
  // Hide any interface elements that require Jcrop
  // (This is for the local user interface portion.)
  $('.requiresjcrop').hide();

  // Invoke Jcrop in typical fashion
  $('#crop-target').Jcrop({
    onRelease: releaseCheck,
    aspectRatio: 1/1
  },function(){

    jcrop_api = this;
    jcrop_api.animateTo([50,50,300,300]);

  });

};
function releaseCheck()
{
  jcrop_api.setOptions({ allowSelect: true });
  $('#can_click').attr('checked',false);
};

 
 
