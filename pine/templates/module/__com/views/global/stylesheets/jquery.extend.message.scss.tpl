{:fileheader}
div#message {
    box-sizing:         border-box;
    width:              100%;
    top:                90px;
    left:               0;
    right:              0;
    margin:             1em auto;
    padding:            0 20px;

    #error {
        width:              1000px;      // 450px;
        position:           relative;
        left:               50%;
        margin-left:        -500px;     // -225px;
        box-sizing:         border-box;
        background-color:   $error_back;
        padding:            6px;
        border:             solid 1px $error_color;
        border-radius:      4px;
        color:              $error_color;
        z-index:            65535;
        display:            none;
        &.show {
            display:        block !important;
        }
        
        p {
            padding:            2px 6px;    //8px 6px;
            text-align:         left;       // center;
        }
        
        ul {
            padding:            2px 6px 2px 10px;   // 8px 6px 8px 10px;
        }
        
        pre {
            box-sizing:         border-box;
            border:             solid 1px #999;
            border-radius:      6px;
            background-color:   #f0f0f0;
            margin:             0 10px 10px 10px;
            padding:            1em 1em 1em 2em;
            font-family:        'Lucida Console', Monaco, monospace;
            color:              #060;
            white-space:        pre-wrap;
            text-indent:        -1em;
        }
        
        &.spread {
            width:              1000px;
            margin-left:        -500px;
        }
    }
    
    .message_close {
        background-color:   #aaa;
        box-sizing:         border-box;
        padding-top:        2px;
        padding-left:       5px;
        width:              28px;
        height:             28px;
        border-radius:      14px;
        box-shadow:         4px 4px 4px rgba(0, 0, 0, 0.7);
        position:           fixed;
        margin-top:         -14px;
        margin-left:        -14px;
        color:              #666;
        border:             solid 2px #666;
        font-size:          21px;
        z-index:            65535;
    }
}
