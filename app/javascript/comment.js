$(function(){
  function buildHTML(comment){
    let html = `<div class="comment-info" data-index="${comment.comment_id}">
                  <div class="comment__name__time">
                    <div class="comment__name">
                      ${comment.user_name}
                    </div>
                    <div class="comment__time">
                      ${comment.created_at}
                    </div>
                  </div>
                  <div class="comment__text">${comment.text}</div>
                  <div class="comment__delete">
                    <a data-remote="true" rel="nofollow" data-method="delete" href="/comics/${comment.comic_id}/comments/${comment.comment_id}"
                      <i class="fas fa-trash-alt trash-icon"></i>
                    </a>
                  </div>
                </div>`
    return html;
  }

  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })

    .done(function(data){
      let html = buildHTML(data);
      $('.comments__list').prepend(html);
      $('.textbox').val('');
      $('.send__comment').prop('disabled', false);
    })

    .fail(function(){
      alert('error');
    })
  })
});