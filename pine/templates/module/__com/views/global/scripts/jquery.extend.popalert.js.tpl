/**
 * Project Name: 三木　克彦グループウェア
 * Description : モーダルポップアップアラートスクリプト
 * Start Date  : 2019/03/29 10:17:51
 * Copyright   : Katsuhiko Miki. feijoa.striking-forces.jp
 * 
 * @author 三木　克彦
 */
(function()
{
    $.extend(
    {
        popalert: function(type, title, message, cancelable, executable, options)
        {
            // ダイアログアニメーション用変数
            var width           = 0;
            var height          = 0;
            var target_width    = 0;
            var target_height   = 0;
            var timer;
            var IVAL            = 1;    // アニメーションインターバル ms
            var SCALE           = 4;    // アニメーションイージング用初期パラメター
            var close           = null; // クローズボタン
            
            // ポップアラートの削除
            function dismiss_popalert()
            {
                close.remove();
                dialog.remove();
                cover.animate({ opacity: 0 }, 200, "linear", function()
                {
                    cover.remove();

                    if(typeof cancelable === "function")   { cancelable(); }
                });
            }
            
            function execute_popalert()
            {
                dismiss_popalert();
                
                if(typeof executable === "function")   { executable(); }
            }
            
            // ダイアログのズームアニメーション処理
            function zoomin()
            {
                // ダイアログのサイズ変更
                width   = Math.min(target_width, width + (target_width / SCALE));
                height  = Math.min(target_height, height + (target_height / SCALE));
                var new_style = {
                      "width":          width + "px"
                    , "height":         height + "px"
                    , "margin-left":    "-" + (width / 2) + "px"
                    , "margin-top":     "-" + (height / 2) + "px"
                };
                dialog.css(new_style);
                
                // ダイアログサイズが目標に到達していない場合は再帰
                if(width < target_width || height < target_height)
                {
                    timer = setTimeout(zoomin, IVAL);
                    SCALE += 4;
                    return;
                }
                
                ////////////////////////////////////////////////////////////////
                // 
                // ダイアログアニメーション終了
                
                // クローズボタン表示
                var top     = dialog.offset().top - $(window).scrollTop();
                var left    = dialog.offset().left + dialog.outerWidth();
                var close_style = {
                      "top":                top + "px"
                    , "left":               left + "px"
                };

                close   = $("<div/>").addClass("popalert_close").css(close_style).html("<i class='fas fa-times'></i>");
                cover.append(close);
                
                // ポップアラートの削除イベントを登録
                close.on("click touchend", function(){ dismiss_popalert(); });
                if(type !== "confirm" && type !== "validate-password")
                {
                    dialog.on("click touchend", function(){ dismiss_popalert(); });
                }
                if(type === "validate-password")
                {
                    $("#validate-password").focus();
                    $("#validate-password").on("keypress", function(e)
                    {
                        if(e.keyCode === 13)
                        {
                            var value   = $(this).val();
                            dismiss_popalert();
                            if(typeof executable === "function")   { executable(value); }
                        }
                    });
                }
                //cover.on("click touchend", function(){ dismiss_popalert(); });
            }
            
            var dialog_width = Math.min(350, window.innerWidth * 0.9);
            var dialog_style = {
                  "width":          dialog_width  + "px"
                , "margin-left":    "-" + (dialog_width / 2) + "px"
            };
            
            // 画面全体を覆う半透明幕
            var cover   = $("<div/>").attr("id", "popalert_cover");
            
            // ポップアップダイアログ
            var h3      = "";
            var buttons = "";
            switch(type)
            {
                case "fail":
                case "error":
                    h3 = "<h3 class='error'><i class='fas fa-exclamation-triangle'></i>" + title + "</h3>";
                    break;
                
                case "success":
                case "done":
                    h3 = "<h3 class='success'><i class='fas fa-check-circle'></i>" + title + "</h3>";
                    break;
                
                case "validate-password":
                    h3          = "<h3 class='success'><i class='fas fa-keyboard'></i>" + title + "</h3>";
                    buttons     = "<div class='btns'></div>";
                    break;
                
                case "confirm":
                    h3          = "<h3 class='success'><i class='fas fa-question-circle'></i>" + title + "</h3>";
                    buttons     = "<div class='btns'></div>";
                    break;
                    
                case "info":
                case "message":
                default:
                    h3 = "<h3 class='info'><i class='fas fa-info-circle'></i>" + title + "</h3>";
                    break;
            }
            
            if(typeof message !== "string")
            {
                var dialog  = $("<div/>").addClass("popalert_dialog").css(dialog_style).html(h3).append(message).append($(buttons));
            }
            else
            {
                var dialog  = $("<div/>").addClass("popalert_dialog").css(dialog_style).html(h3 + $.nl2br(message) + buttons);
            }
            
            cover.append(dialog);
            $("body").append(cover);
            
            ////////////////////////////////////////////////////////////////////
            // コントロールボタンの表示
            
            // パスワード確認ダイアログ
            if(type === "validate-password")
            {
                var cancel  = $("<button/>").attr("type", "button").addClass("cancel").text("キャンセル");
                $(".popalert_dialog .btns").append(cancel);
                cancel.on("click touchend", function(){ dismiss_popalert(); });
                
                var area    = $("<div/>").addClass("validate-input");
                var input   = $("<input/>").attr("type", "password").attr("id", "validate-password").addClass("full_width").addClass("acenter");
                area.append(input);
                $(".popalert_dialog .btns").before(area);
            }
            
            // 確認ダイアログ
            if(type === "confirm")
            {
                var cancel  = $("<button/>").attr("type", "button").addClass("cancel").text("キャンセル");
                $(".popalert_dialog .btns").append(cancel);
                cancel.on("click touchend", function(){ dismiss_popalert(); });
                
                if(typeof executable !== "undefined")
                {
                    var execute = $("<button/>").attr("type", "button").addClass("submit").text("実行");
                    $(".popalert_dialog .btns").append(execute);
                    execute.on("click touchend", function(){ execute_popalert(); });
                }
            }
            
            // アニメーションに先立ってポップアップダイアログサイズを初期化
            width           = 0;
            height          = 0;
            target_width    = (typeof options === "object" && options.width > 0)? options.width : dialog.outerWidth();
            target_height   = dialog.outerHeight();
            var new_style = {
                      "width":          "0px"
                    , "height":         "0px"
                    , "margin-left":    "0px"
                    , "margin-top":     "0px"
                    , "display":        "block"
                };
            dialog.css(new_style);
            
            // 半透明幕のアニメーションを開始
            cover.addClass("dark");
        
            // ダイアログアニメーションの開始
            timer = setTimeout(zoomin, IVAL);
        }
    });
})();
