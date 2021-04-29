$(document).on("change","#profile_image_upload",function(e){
  if (e.target.files.length){

    let reader = new FileReader;

    reader.onload = function(e){
      // これで隠れていたプレビュー要素を出現
      $('.hidden').removeClass();
      // これでデフォルトで表示される画像を消す
      $('.profile-default-img').removeClass();
      // これで自身のプロフィール画像を消す
      $('#profile-img').remove();
      // これで隠れてたプレビュー欄にfilereaderで読み込んだ画像を挿入。
      $('#profile-img-prev').attr("src", e.target.result);
    };

    reader.readAsDataURL(e.target.files[0]);
  };
})