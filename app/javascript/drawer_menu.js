$(window).on('load', ()=> {

  // MENUボタンがクリックされたときの処理
  $('#menu_btn').on('click', function(){
    $('#menu').addClass('open'); // #menuに.openを追加
    $('.menu-background').addClass('open'); // .menu-backgroundに.openを追加
    $('.maru_btn').addClass('open'); //  .maru_btnにopenクラス追加してbtnの色を変更
    $('.peke').removeClass('peke-none');  // .pekeにつけてるpeke-none(display隠してる)を消してアイコンを表示
    
  });

  $('.peke').on('click', function(){
    // .menu-backgroundに.openがあるかどうか
    $('#menu').removeClass('open'); // #menuの.openを削除
    $('.menu-background').removeClass('open'); // .menu-backgroundの.openを削除
    $('.maru_btn').removeClass('open');
    $('.peke').addClass('peke-none');
  });

  // メニューの背景がクリックされたときの処理
  $('.menu-background').on('click', function(){
    // .menu-backgroundに.openがあるかどうか
    if($(this).hasClass('open')) {
      // .openがあるときの処理
      $(this).removeClass('open'); // .menu-backgroundの.openを削除
      $('#menu').removeClass('open'); // #menuの.openを削除
      $('.maru_btn').removeClass('open');
      $('.peke').addClass('peke-none');
    }
  });

});