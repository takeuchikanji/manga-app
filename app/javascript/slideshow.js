$(window).on('load', ()=> {
  

  if ($(".slide__image")[0]){

    // 画像のスライドショー（タイマー単位はms）,演出はフェードインにする
    let num = 0;
    var slideshow_timer = function(){
      if (num == 2){
          num = 0;
      }else {
          num ++;
      }
      $(".slide__image").addClass("display_hide");
      $(".slide__image").removeClass("show");
      $(`li[data-index="${num}"]`).addClass("show");
      $(".circle__btn").removeClass('circle__active');
      $(`.circle__btn-box[data-index="${num}"]`).children().addClass('circle__active');     //対象のbtnに追加
    }
    var a = setInterval(slideshow_timer,2000);


    // 画像下の丸アイコン押したらそれに対応する画像に切り替える（上同様にフェードイン）
    $('.side__up__list').on('click', '.circle__btn', function() {
      let targetIndex = $(this).parent().data('index');
      $(".slide__image").addClass("display_hide");      
      $(".slide__image").removeClass("show");
      $(`li[data-index="${targetIndex}"]`).addClass("show");
      $(".circle__btn").removeClass('circle__active');
      $(this).addClass('circle__active');
    });

  }
});