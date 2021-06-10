/**
 * Project Name: 三木　克彦グループウェア
 * Description : モーダルプログレスアイコンスクリプト
 * Start Date  : 2019/03/29 14:41:15
 * Copyright   : Katsuhiko Miki. feijoa.striking-forces.jp
 * 
 * @author 三木　克彦
 */
(function()
{
    $.extend(
    {
        progress_hide: function()
        {
            $("#progress_loader").remove();
            $("#progress_cover").animate({ opacity: 0 }, 200, "linear", function()
            {
                $(this).remove();
            });
        },
        progress_show: function(target)
        {
            function choice(array)
            {
                var idx = Math.floor(Math.random() * Math.floor(array.length));
                return array[idx];
            }
            
            // 画面全体を覆う半透明幕
            array = (typeof target === "undefined" || target > 8 || target < 1)? [4, 5, 6, 7, 8, 1] : [target];
            var cover   = $("<div/>").attr("id", "progress_cover").addClass("progress" + choice(array));
            
            // プログレスアイコン
            var progress  = $("<div/>").attr("id", "progress_loader").addClass("loader").css({"top": "40%"}).text("Loading...");
            
            cover.append(progress);
            $("body").append(cover);
            
            // 半透明幕のアニメーションを開始
            cover.addClass("dark");
        }
    });
})();
