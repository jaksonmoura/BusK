// When update routes
var days = [];
$('.days_of_week .week li').click( function(){
  if ($(this).css('opacity') != '1') {
    $(this).css({ opacity: 1.0 });
  } else {
    $(this).css({ opacity: 0.6 });
  }
});

function getWeek(){
  $('.days_of_week .week li').each(function (){
    if ($(this).css('opacity') == '1') {
      days.push($(this).html());
    }
  });
}

$('.return_form, .going_form').submit( function(){
  getWeek();
  var week = '';
  for (var i = 0; i <= days.length - 1; i++) {
    if (i == days.length - 1) {
      week += days[i];
    } else {
      week += days[i]+',';
    };
  };
  $('#return_days_of_week').val(week);
  $('#going_days_of_week').val(week);
});