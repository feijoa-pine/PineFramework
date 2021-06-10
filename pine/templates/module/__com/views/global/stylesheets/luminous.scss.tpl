{:fileheader}
div.lum-lightbox {
    z-index:    65550;
}

/* 800px以以下で適用する内容 */
@media screen and (max-width: 800px){
    .lum-lightbox {
        box-sizing:     border-box;
        
        .lum-lightbox-inner {
            width:  100vw;
            left:   0;
            right:  0;
        }
    }
}

@media screen and (max-width: 460px) {
    .lum-lightbox-inner img {
        max-width: 85vw !important;  /* 軽くスワイプで左端から右端まで動かせる量 */
        max-height: 85vh !important;  /* 上下に適度に余白 */
    }
}