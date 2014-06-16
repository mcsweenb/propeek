$(document).ready( function () {
    var holder = document.getElementById('photo-drop-zone'),
    state = document.getElementById('status');
    
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
});
