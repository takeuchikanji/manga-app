$(window).on('load', ()=> {

  function buildImg(url) {
    const html = `<div class="previews__field">
                    <img data-index="0" src="${url}" width="100px" height="100px">
                    <div class="edit_btn-box">
                      <span class="edit">画像を変更する</span>
                    </div>
                  </div>`;
    return html;
  }

  $('.field').on('change', '.form_image', function(e) {
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);


    if (img = $(`img[data-index="0"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {


      $('.preview').append(buildImg(blobUrl));

      $(`.fa-images`).hide();


    }
  });

  $('.field').on('click', '.edit', function() {
    $(`input[id="author_comics_attributes_0_image"]`).on('click', function(e){
      e.stopPropagation();
    });

    $(`input[id="author_comics_attributes_0_image"]`).trigger('click');

  });
});