{:fileheader}
(function()
{
    $(document).ready(function()
    {
        $(document).fcs(".fcs");    // エンターキーで入力フォームを移動するプラグイン
        autosize($("textarea"));    // textareaの自動リサイズプラグイン
        
        $(".fixed-header").each(function()
        {
            var offset_top  = 46;
            if($(this).attr("data-offset-top") !== undefined)
            {
                offset_top  = parseInt($(this).attr("data-offset"), 10);
            }
            $(this).floatThead({ top: offset_top });    // テーブルヘッダー固定プラグイン
        });
        
        // JsRender のマークアップタグを変更
        // https://www.jsviews.com/#settings/delimiters
        // https://stackoverflow.com/questions/29493005/how-to-change-jsrender-template-tags
        $.views.settings.delimiters("[[", "]]");
        
        // Luminous
        // https://github.com/imgix/luminous
        // https://wemo.tech/1169        
        $(".luminous").each(function()
        {
           new Luminous($(this)[0]); 
        });
        
        // scroll to top
        $(document).on("scroll", function()
        {
            let posY    = $(window).scrollTop();
            if(posY > 200)
            {
                $(".scroll-top-area").fadeIn(1000);
            }
            else
            {
                $(".scroll-top-area").fadeOut(1000);
            }
        });
        $(document).on("click touchend", ".scroll-top", function()
        {
            $.focusscroll($("body"));
        });
    });
})();
