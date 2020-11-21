$(window).on('load', ()=> {
  

  if ($(".slide__image")[0]){
    // ここ要らなかった（参考サイトにはあったので書いた
    // let zero = $(`li[data-index="0"]`)
    // let one = $(`li[data-index="1"]`)
    // let two = $(`li[data-index="2"]`)
    // let three = $(`li[data-index="3"]`)
    // let four = $(`li[data-index="4"]`)
    // let count = [zero, one, two, three, four];

    // 画像のスライドショー（タイマー単位はms）,演出はフェードインにする
    let num = 0;
    var slideshow_timer = function(){
      if (num == 2){
          num = 0;
      }else {
          num ++;
      }
      $(".slide__image").addClass("display_hide");
      // $(`li[data-index="${num}"]`).removeClass("display_hide");   
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
      // $(`li[data-index="${targetIndex}"]`).removeClass("display_hide");
      $(".slide__image").removeClass("show");
      $(`li[data-index="${targetIndex}"]`).addClass("show");
      $(".circle__btn").removeClass('circle__active');
      $(this).addClass('circle__active');
    });

  }
});