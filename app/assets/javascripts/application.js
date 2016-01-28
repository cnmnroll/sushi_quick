// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .


$(function () {
	$('#merchandise_uploaded_image').change(
		function () {
			if (this.files.length) {
				var file = $(this).prop('files')[0];
				var fr = new FileReader();
				fr.onload = function () {
					$('#uploaded_image_confirm').html($('<img></img>', {
						src: fr.result
					}))
				}
				fr.readAsDataURL(file);
			}
		}
	)
})
