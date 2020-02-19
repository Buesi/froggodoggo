$(document).on('turbolinks:load', function() {
  var currentForm;

	$("[data-popup-name]").click(function(e){
		e.preventDefault();
		var popupName = $(this).data("popup-name");
    $('.popup').css('display', 'flex');

    currentForm = $(this).closest("form");
	});

  $('.popupFormSubmitButton').click(function(){
    currentForm.submit();
  });

  $('.popupCloseButton').click(function(){
    $('.popup').css('display', 'none');
  });

});
