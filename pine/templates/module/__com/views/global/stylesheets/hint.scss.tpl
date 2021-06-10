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
  background-color:   $dim;
  max-width:          300px;
  box-sizing:         border-box;
  padding:            4px 6px;
  box-shadow:         4px 4px 6px rgba(0,0,0,0.4), 2px 2px 2px rgba(0,0,0,0.4) inset;
  
  &.locked {
      background-color:     $heavy !important;
  }
}
