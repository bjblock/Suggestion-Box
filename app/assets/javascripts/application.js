// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .

$(document).ready(function() {
	$('section h5.make_suggestion a').click(function(e) {
		e.preventDefault();
		$('section div.suggestion_form').slideDown(500);
		// $('section h5.make_suggestion a').hide();
	});
	$('section div.suggestion_form a').click(function(e) {
		e.preventDefault();
		$('section div.suggestion_form').slideUp(500);
		// $('section h5.make_suggestion a').show();
	});
	$('section div.comment_box a.show_comments').toggle(function(e) {
		e.preventDefault();
		$(this).next('div.hidden_comments').slideDown(500);		
		$(this).text('Hide Comments');
	}, function(e) {
		e.preventDefault();
		$(this).next('div.hidden_comments').slideUp(500);
		$(this).text('Show Comments');
	});
});