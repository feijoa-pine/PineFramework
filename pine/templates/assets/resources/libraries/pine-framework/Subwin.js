/**
 * Project Name: Pine Framework
 * Description : サブウィンドウ用スクリプト
 * Start Date  : 2019/03/12 16:34:11
 * Copyright   : Katsuhiko Miki　feijoa.striking-forces.jp
 * 
 * @author 三木　克彦
 */
var Subwin = {
    
    sub_windows:    [],         // サブウィンドウ用タスクボタンリスト
    callable:       null,       // onMessage時のコールバック
    target_origin:  "*",        // ターゲットオリジン
    /**
     * サブウィンドウオブジェクトのイニシャライズ
     * 
     * @param   {Callable}  callable
     * @returns {undefined}
     */
    init: function(callable)
    {
        Subwin.callable = callable;
        window.addEventListener("message", Subwin.onMessage, false);   // サブウィンドウからのメッセージイベントに対するリスナー登録
    },
    onMessage: function(e)
    {
        //if (e.origin !== "http://localhost:60132") {
        //  document.getElementById("output").innerHTML = e.origin + " から受信: " + e.data;
        //}
        Subwin.callable(e);
    },
    /**
     * サブウィンドウのオープン
     * 
     * @param   {Object}    obj
     * @returns {undefined}
     */
    open: function(obj)
    {
        // 既に同名のIDのウィンドウが開いていないか検査し、開いていた場合はフォーカスする
        var i = Subwin.get_subwin_idx(obj.subwin_id);
        if(i >= 0)
        {
            var subwin  = Subwin.sub_windows[i];
            subwin.sub_window.focus();
            return true;
        }
        
        var width       = (typeof obj.width !== "undefined") ? obj.width : 1000;
        var height      = (typeof obj.height !== "undefined") ? obj.height : 800;
        var left        = (window.parent.screen.width - width) / 2;
        var top         = (window.parent.screen.height - height) / 2 - 60;

        // サブウィンドウを開く
        var sub_window  = window.open(obj.url, "", "width=" + width + ",height=" + height + ",top=" + top + ",left=" + left + ",scrollbars=yes");
        $(sub_window).on("load", function()
        {
            $(sub_window).on("unload", function()
            {
                Subwin.removeTaskButton(obj.subwin_id);
            });
        });
        
        if(typeof obj.origin !== "undefined")   { Subwin.target_origin   = obj.origin; }
        
        // タスクバーにタスクボタンを追加
        var closebutton = $("<div/>")
                                .addClass("task_close")
                                .attr("data-subwin-id", obj.subwin_id)
                                .html("<i class='fas fa-times'></i>");
        var taskbutton  = $("<div/>").addClass("task").text(obj.label).append(closebutton);
        $("#taskbar").append(taskbutton);

        // タスクボタンのクリックイベント
        taskbutton.on("click touchend", function()
        {
            var closebutton = $(this).children(".task_close");
            var subwin_id   = closebutton.attr("data-subwin-id");
            var i = Subwin.get_subwin_idx(subwin_id);
            if(i === -1)    { return false; }
            
            // タスクボタンの対象サブウィンドウをフォーカス
            var subwin  = Subwin.sub_windows[i];
            subwin.sub_window.focus();
            return true;
        });
        // タスククローズボタンのクリックイベント
        closebutton.on("click touchend", function()
        {
            Subwin.removeTaskButton($(this).attr("data-subwin-id"));      // タスクボタンの削除
        });

        // サブウィンドウ用タスクボタンリストにタスクボタン情報を登録
        var subwin = { subwin_id: obj.subwin_id, taskbutton: taskbutton, sub_window: sub_window };
        Subwin.sub_windows.push(subwin);
    },
    /**
     * サブウィンドウのクローズ
     * 
     * @param   {mixed}         target
     * @returns {undefined}
     */
    close: function(target)
    {
        if(typeof target === "string")
        {
            let i = Subwin.get_subwin_idx(target);
            if(i === -1)    { return false; }

            var obj = Subwin.sub_windows[i];
            obj.sub_window.close();                 // タスクボタンの対象サブウィンドウをクローズ
            Subwin.sub_windows.splice(i, 1);        // タスクボタンへの参照を削除
        }
        else
        {
            window.opener.postMessage(target);
            window.close();
        }
    },
    /**
     * サブウィンドウのクローズ
     * 
     * @param   {Object}        obj
     * @returns {undefined}
     */
    report: function(obj)
    {
        window.opener.postMessage(obj);
    },
    /**
     * タスクボタンの消去
     * 
     * @param   {String}        subwin_id
     * @returns {Boolean}
     */
    removeTaskButton: function(subwin_id)
    {
        var i = Subwin.get_subwin_idx(subwin_id);
        if(i === -1)    { return false; }
        
        var obj = Subwin.sub_windows[i];
        obj.sub_window.close();                 // タスクボタンの対象サブウィンドウをクローズ
        obj.taskbutton.hide(500).remove();      // タスクボタンを消去
        Subwin.sub_windows.splice(i, 1);        // タスクボタンへの参照を削除
    },
    /**
     * サブウィンドウIDからWindowオブジェクトへの参照を取得する
     * 
     * @param   {String}        subwin_id
     * @returns {Number}
     */
    get_subwin_idx: function(subwin_id)
    {
        for(var i = Subwin.sub_windows.length - 1; i >= 0; i--)
        {
            var obj = Subwin.sub_windows[i];
            if(obj.subwin_id !== subwin_id)  { continue; }
            return i;
        }
        return -1;
    },
    
    /**
     * サブウィンドウへの、メッセージの送信
     * 
     * @param {type} message
     * @returns {undefined}
     */
    message: function(subwin_id, message)
    {
        // 既に同名のIDのウィンドウが開いているか検査し、開いていない場合はfalseを返す
        var i = Subwin.get_subwin_idx(subwin_id);
        if(i < 0)   { return false; }

        const subwin  = Subwin.sub_windows[i];
        console.log(subwin);
        subwin.postMessage(message, Subwin.target_origin);
        
        return true;
    }
};
