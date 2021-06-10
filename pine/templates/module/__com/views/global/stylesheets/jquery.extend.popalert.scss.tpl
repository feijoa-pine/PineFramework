{:fileheader}
#popalert_cover {
    background-color:   rgba(0, 0, 0, 0);
    width:              100%;
    height:             100%;
    position:           fixed;
    top:                0;
    left:               0;
    transition:         all 200ms ease;
    
    &.dark {
        background-color:   rgba(0, 0, 0, 0.7);
    }
    
    .popalert_dialog {
        background-color:   #efefef;
        box-sizing:         border-box;
        padding:            25px;
        width:              240px;
        min-height:         100px;
        border:             solid 1px #999;
        border-radius:      3px;
        box-shadow:         0px 0px 30px rgba(0, 0, 0, 0.7);
        position:           fixed;
        top:                50%;
        left:               50%;
        margin-top:         -50px;
        margin-left:        -120px;
        color:              #666;
        display:            none;
        overflow:           hidden;
        font-size:          14px;
        line-height:        1.5em;
        cursor:             pointer;
        
        h3 {
            text-align:     center;
            margin-bottom:  20px;
            
            i {
                display:            block;
                font-size:          2em;
                padding-bottom:     0.25em;
            }
            
            &.success {
                color:              $success_color;
            }
            &.error {
                color:              $error_color;
            }
        }
        
        div.btns {
            width:              100%;
            padding:            20px 0 0 0;
            text-align:         center;
            
            button {
                margin:         0 6px;
            }
        }
    }
    
    .validate-input {
        padding:            10px 0;
    }
    
    .popalert_close {
        background-color:   #aaa;
        box-sizing:         border-box;
        padding-top:        2px;
        padding-left:       5px;
        width:              27px;
        height:             27px;
        border-radius:      14px;
        box-shadow:         0px 0px 15px rgba(0, 0, 0, 0.7);
        position:           fixed;
        margin-top:         -14px;
        margin-left:        -14px;
        color:              #666;
        border:             solid 2px #666;
        font-size:          21px;

        i {
            vertical-align: top;
        }
    }
}
