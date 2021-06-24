{:fileheader}
(function()
{
    /**
     * メッセージのクローズボタン表示
     * 
     * @param   {jQuery DOM Object}     div
     * @param   {jQuery DOM Object}     parent
     * @returns {undefined}
     */
    function show_close_button(div, parent)
    {
        // クローズボタン表示
        var top     = parent.offset().top - $(window).scrollTop();
        var left    = (parent.outerWidth() / 2) + (div.outerWidth() / 2) + parseInt($("#wrapper").css("padding-left"), 10);
        
        var close_style = {
              "top":                top + "px"
            , "left":               left + "px"
        };
        var close   = $("<div/>").addClass("message_close").css(close_style).html("<i class='fas fa-times'></i>");
        parent.append(close);

        // ポップアラートの削除イベントを登録
        close.on("click touchend", function()
        {
            $(this).remove();
            div.empty().hide(300);
        });
        div.on("dblclick", function()
        {
            close.remove();
            div.empty().hide(300);
        });
    }
    
    $.extend(
    {
        /**
         * メッセージボックスの初期化
         */
        init_messagebox: function()
        {
            $("#message > .message_close").remove();
            $("#success").removeClass("spread").empty().hide();
            $("#error").removeClass("spread").empty().hide();
        },
        /**
         * サーバー問い合わせエラー、またはレスポンスJSONパースエラー時のエラー表示
         */
        show_communication_error: function()
        {
            $.progress_hide();
            $.popalert("error", "通信エラー", "サーバーとの通信に問題が発生しました。");
            
            return true;
        },
        /**
         * ajax成功時の正常系標準のメッセージ表示共通
         */
        show_success_message: function(response)
        {
            $.progress_hide();
            var p   = $("<p/>").text(response.message);
            $("#success").append(p);
            $.focusscroll($("#success"));
        },
        /**
         * バリデーションエラーを表示し、スムーズスクロールする
         */
        show_verror_neighbour: function(response)
        {
             for(var key in response.verror)
            {
                var ve = response.verror[key];
                $("." + key + "_error").text(ve).show();
            }
            $(".error").each(function()
            {
                return $.focusscroll($(this)) ? false : true;
            });
        },
        /**
         * バリデーションエラーをポップアップで表示する
         */
        show_verror_popup: function(response)
        {
            var verrors = [];
            for(var key in response.verror)
            {
                var ve = response.verror[key];
                verrors.push(ve);
            }
            var message = verrors.join("\n");
            $.popalert("error", "エラー", message);
        },
        /**
         * バリデーションエラーをメッセージエリア内に表示すし、スムーズスクロールする
         */
        show_verror_message_area: function(response)
        {
            var ul  = $("<ul/>");
            for(var key in response.verror)
            {
                for(var i = 0, max = response.verror[key].length; i < max; i++)
                {
                    var li  = $("<li/>").text(response.verror[key]);
                    ul.append(li);
                }
            }
            $("#error").append(ul);
            
            $("#error").show(100, show_close_button($("#error"), $("#message")));
            $.focusscroll($("#error"));
        },
        /**
         * エラーをメッセージエリア内に表示すし、スムーズスクロールする
         */
        show_error_message_area: function(response)
        {
            var p           = $("<p/>").addClass("acenter").text(response.message);
            $("#error").append(p);

            if(typeof response.stack_trace !== "undefined" && response.stack_trace !== "")
            {
                var stack   = $("<pre/>").text(response.stack_trace);
                $("#error").addClass("spread").append(stack);
            }

            if(typeof response.last_query !== "undefined" && response.last_query !== "")
            {
                var pre     = $("<pre/>").text(response.last_query);
                $("#error").addClass("spread").append(pre);
            }

            $("#error").show(100, show_close_button($("#error"), $("#message")));
            $.focusscroll($("#error"));
        },
        
        /**
         * ajax成功時の異常系標準のメッセージ表示共通
         */
        show_error_message: function(response)
        {
            $.progress_hide();
            (typeof response.verror === "undefined")
                    ? $.show_error_message_area(response)
                    : $.show_verror_message_area(response)
                    ;
        }
    });
})();
