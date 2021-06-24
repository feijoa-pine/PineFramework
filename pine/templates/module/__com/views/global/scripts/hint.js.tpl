{:fileheader}
$(function()
{
    var HINT_DISPLAY_DILAY  = 1000;
    var hint_timer  = null;
    var mouseX      = 0;
    var mouseY      = 0;
    var hint_opener = null;
    var remove_lock = false;
    
    document.body.addEventListener("mousemove", function(e)
    {
        mouseX = e.clientX;
        mouseY = e.clientY;
    });

    $(document).on("click touchend", ".hint", function(e)
    {
        if(hint_opener !== $(this)[0])   { return false; }

        remove_lock = ! remove_lock;

        (remove_lock)
            ? $(".hint-window").addClass("locked")
            : $(".hint-window").removeClass("locked")
            ;
    });

    $(document).on("mouseover touchstart", ".hint", function(e)
    {
        if(remove_lock) { return false; }

        var hint_source = $(this);

        clearTimeout(hint_timer);
        hint_timer = setTimeout(function()
        {
            $(".hint-window").remove();
            hint_opener = hint_source[0];
            remove_lock = false;

            var pos_x = mouseX + $(window).scrollLeft() + 30;
            var pos_y = mouseY + $(window).scrollTop() - 55;
            var span = $("<div/>")
                            .addClass("hint-window")
                            .html(hint_source.attr("data-hint-string"))
                            .css("left", pos_x + "px")
                            .css("top", pos_y + "px")
                            ;
            $("body").append(span);
        }
        , HINT_DISPLAY_DILAY);
    });

    $(document).on("mouseleave touchend", ".hint", function(e)
    {
        clearTimeout(hint_timer);
        if(remove_lock) { return false; }
        hint_opener = null
        $(".hint-window").remove();
    });
});
