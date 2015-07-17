function search_resubmit() {
  var cur_val = $("#listing_search_form input").val();
  if (cur_val !== window.last_listing_search_pattern) {
    window.last_listing_search_pattern = cur_val;

    var form = $("#listing_search_form");
    $.ajax({url: form.attr("action"), data: form.serialize()})
      .success(function(html) {
        $("#listing_table_container").html(html);
      });
  }
}

function prepare_for_search_resubmit() {
  clearTimeout(window.search_timeout);
  window.search_timeout = setTimeout(search_resubmit, 700);
}

$(function() {
  $("#listing_search_form input").change(prepare_for_search_resubmit);
  $("#listing_search_form input").keypress(prepare_for_search_resubmit);
  $("#listing_search_form").submit(function(ev) {
    ev.preventDefault();
  });
});