/**
 * Project Name: Pine Framework
 * Description : jQuery extends
 * Start Date  : 2019/03/12 16:34:11
 * Copyright   : Katsuhiko Miki. feijoa.striking-forces.jp
 * 
 * @author 三木　克彦
 */
(function()
{
    $.extend(
    {
        /**
         * $.ajax()のラッパー関数
         * 
         * @param {type} obj
         * @returns {undefined}
         */
        fetch: function(obj)
        {
            if(obj.icon !== false)
            {
                $.progress_show();  // プログレスアイコンの表示
            }
            
            // ワンタイムチケット
            if(obj.type.toUpperCase() === "POST")
            {
                obj.data[TICKET_KEY] = $("*[name=" + TICKET_KEY + "]").val();
            }
            
            $.ajax({ url: obj.url, type: obj.type, data: obj.data, dataType: obj.dataType })
            .fail(function(jqXHR, textStatus, errorThrown)  { $.progress_hide(); return $.show_communication_error(); })
            .done(function(response, textStatus, jqXHR)
            {
                $.progress_hide();
                
                if(typeof response[TICKET_KEY] !== "undefined")
                {
                    $("*[name=" + TICKET_KEY + "]").val(response[TICKET_KEY]);
                }
                
                if(typeof obj.done !== "undefined")
                {
                    if(!obj.done(response, textStatus, jqXHR))  { return false; }
                }
    
                if(response.status === false)
                {
                    $.show_error_message(response);
                    return false;
                }
                return obj.done(response, textStatus, jqXHR);
            });
        },
        /**
         * Ajaxのレスポンスを検査し、エラーがある場合はエラー内容を指定の手段で表示する
         * 
         * @param {type} str
         * @returns {String}
         */
        is_success: function(response, display_type)
        {
            // 通常エラー
            function error(response)
            {
                switch(display_type)
                {
                    case "neighbour":
                    case "neibor":
                    case "popup":       $.popalert("error", "エラー", response.message);    break;
                    case "message":
                    default:            $.show_error_message_area(response);    break;
                }
            }
            // バリデーションエラー
            function verror(response)
            {
                switch(display_type)
                {
                    case "neighbour":
                    case "neibor":      $.show_verror_neighbour(response);      break;
                    case "popup":       $.show_verror_popup(response);          break;
                    case "message":
                    default:            $.show_verror_message_area(response);   break;
                }
            }
            
            $.progress_hide();
            if(response.status === true)   { return true; }
            
            (typeof response.verror === "undefined") ? error(response) : verror(response);

            return false;
        },
        /**
         * スムーススクロール
         * 
         * @param   {jQueryObject}      obj
         * @returns {undefined}
         */
        focusscroll: function(obj)
        {
            if(obj[0] === undefined)            { return false; }
            if(obj.css("display") === "none")   { return false; }
            
            var speed       = 600;
            var heightstate = (screen.height / 3);
            var new_top     = obj.offset().top - heightstate;
            
            $("html, body").animate({ scrollTop: new_top }, speed, "swing");
            obj.focus();
            
            return true;
        },
        /**
         * jQueryオブジェクトのtext()について、改行コードを<br>タグに置き換え
         * 
         * @param   {jQueryObject}      obj
         */
        nl2br: function(obj)
        {
            if(typeof obj === "undefined")  { return; }
            if(typeof obj === "string")
            {
                return obj.replace(/[\n\r]/g, "<br>");
            }
            else
            {
                obj.html(obj.text().replace(/[\n\r]/g, "<br>"));
            }
        },
        /**
         * HTMLタグを実体参照に置き換え
         * 
         * @param   {String}        str
         * @returns {String}
         */
        escape: function(str)
        {
            str = str.replace(/</g, "&lt;");
            str = str.replace(/>/g, "&gt;");
            return str;
        },
        /**
         * unixタイムスタンプを返す
         * 
         * @returns {Number}
         */
        time: function()
        {
            var date = new Date();
            return Math.floor( date.getTime() / 1000 );
        },
        /**
         * mailaddressからsymbolを取り出す
         * 
         * @param   {String}    mailaddress
         * @returns {String}
         */
        get_symbol: function(mailaddress)
        {
            var stripped    = mailaddress.replace(/(\.|@|-|_)/g, "");
            var array       = stripped.split("");
            array.sort();

            return array.join("");
        }
    });
})();