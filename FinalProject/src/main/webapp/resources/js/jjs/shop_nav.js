$(function(){
	var pageName = $('#pageName').val();
	$('.shop-link').removeClass('active');
	$('#' + pageName).addClass('active');
});