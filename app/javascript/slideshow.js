$(document).on('turbolinks:load', ()=> {

  // ここ要らなかった（参考サイトにはあったので書いた
  // let zero = $(`li[data-index="0"]`)
  // let one = $(`li[data-index="1"]`)
  // let two = $(`li[data-index="2"]`)
  // let three = $(`li[data-index="3"]`)
  // let four = $(`li[data-index="4"]`)
  // let count = [zero, one, two, three, four];

  // 画像のスライドショー（タイマー単位はms）
  let num = -1;
  var slideshow_timer = function(){
    if (num == 4){
        num = 0;
    }else {
        num ++;
    }
    $(".slide__image").addClass("display_hide");
    $(`li[data-index="${num}"]`).removeClass("display_hide");
  }
  setInterval(slideshow_timer,4000);


  // 画像下の丸アイコン押したらそれに対応する画像に切り替える
  $('.side__up__list').on('click', '.circle__btn', function() {
    let targetIndex = $(this).parent().data('index');
    $(".slide__image").addClass("display_hide");
    $(`li[data-index="${targetIndex}"]`).removeClass("display_hide");
  });

});