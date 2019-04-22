// AJAX Form Submit
  $(".submit").on("change click", 
    function(event) {
      // Show Progress Indicator
      $(".ajax-progress").show();

      // Set Timeout Callback
      window.setTimeout(function() {
        if ($(".ajax-progress").is(":visible")) {
            $(".ajax-progress").hide();
            // Show Error Window
            $(".modal-body > p").text("Request Timeout.");
            $("#ajax-error").modal("show");
        }
      }, 20000);

      // Very specific
      //$(this).closest("tr").find("form").submit();

      // Doesn't work for tables
      //$(this).closest("form").submit();

      // The most correct - only on change, not on submit
      if (event.type == "change") {
        $(this).parent().parent().find("form").submit();
      }
    });
// END
