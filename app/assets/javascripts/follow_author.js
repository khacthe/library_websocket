jQuery(document).ready(function() {
  $(document).on('click','.followauthor', function(){
    var url, type;
    var author_id = $(this).data('id');
    var status;
    if ($(this).hasClass('destroy')){
      url = '/follow_authors/' + author_id;
      type = 'delete';
      status = false;
    } else {
      url = '/follow_authors';
      type = 'POST';
      status = true;
    }
    $.ajax({
      url: url,
      type: type,
      data: {author_id: author_id},
      dataType: 'json',
      success: function(response){
        if(status == true){
          $('#follow_form_author_'+ author_id).html('<a href=""'
            + 'class = "followauthor destroy"'
            + 'data-id =' + author_id + ' remote= true >Unfollow</a>');
        }
        else{
          $('#follow_form_author_' + author_id).html('<a href=""'
            + 'class = "followauthor"'
            + 'data-id =' + author_id + ' remote = true >Follow</a>');
        }
      }
    })
  });
});
