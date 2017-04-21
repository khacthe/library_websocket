jQuery(document).ready(function() {
  /* update read notification */
  $(document).on('click','.dropdown-notification li a', function(){
    var url, type;
    var id = $(this).data('id');
    url = '/notifications/'+ id;
    type = 'PUT';
    $.ajax({
      url: url,
      type: type,
      data: {id: id},
      dataType: 'script',
      success: function(response){
      }
    })
  });

  $(document).on('click','#noti-count', function(){ /* update count checked */
    var url, type;
    var id = $(this).attr('aria-data-id');
    url = '/check_notification';
    type = 'PUT';
    $.ajax({
      url: url,
      type: type,
      data: {},
      dataType: 'script',
      success: function(response){
        $('#badge-dange_'+id).text(0);
      }
    })
  });
});
