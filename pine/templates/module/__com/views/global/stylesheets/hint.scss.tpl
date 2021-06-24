{:fileheader}
.hint
{
    cursor:     help;
}

div.hint-window
{
    display:            block;
    position:           absolute;
    z-index:            1005;
    border:             solid 1px #aabbc6;
    max-width:          400px;
    box-sizing:         border-box;
    padding:            4px 6px;
    box-shadow:         4px 4px 6px rgba(0,0,0,0.4);

    font-size:          10px;
    background-color:   white;

    &.locked {
        background-color:     lightgray !important;
    }
}
