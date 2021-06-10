/**
 * Project Name: Pine Framework
 * Description : モーダルプログレスアイコンスクリプト
 * Start Date  : 2019/03/29 14:41:15
 * Copyright   : Katsuhiko Miki　feijoa.striking-forces.jp
 * 
 * @author 三木　克彦
 */
(function()
{
    $.extend(
    {
        clipboard:
        {
            copy: function(content)
            {
                // DOM::textarea を生成し、content として文字列を設定
                let textarea    = $("<textarea/>").css({"width":"3px","height":"3px"}).text(content);

                // DOM::textarea をドキュメントに追加
                $("body").append(textarea);

                // content を選択
                textarea.select();

                // クリップボードにコピー
                document.execCommand("copy");

                // DOM::textarea を削除
                textarea.remove();
            }
        }
    });
})();
