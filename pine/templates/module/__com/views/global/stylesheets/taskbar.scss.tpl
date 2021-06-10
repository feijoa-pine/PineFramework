{:fileheader}
#taskbar {
    box-sizing:         border-box;
    position:           fixed;
    padding:            0 8px;
    width:              100%;
    bottom:             0;
    min-height:         26px;
    text-align:         left;
    
    .task {
        display:            inline-block;
        position:           relative;
        min-width:          100px;
        background-color:   $twilight;
        margin:             0 2px;
        padding:            8px 32px 0px 10px;
        height:             26px;
        border-radius:      4px 4px 0 0;
        cursor:             pointer;
        &:hover {
            background-color:   $light;
        }

        .task_close {
            display:            inline-block;
            position:           absolute;
            top:                7px;
            right:              6px;
            padding-top:        1px;
            padding-left:       1px;
            background-color:   $heavy;
            width:              18px;
            height:             18px;
            border-radius:      9px;
            color:              $twilight;
            text-align:         center;
            cursor:             pointer;
            &:hover,
            &:active {
                background-color:   $bright;
            }
            i {
                cursor:             pointer;
            }
        }
    }
}