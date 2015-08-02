Config { font = "xft:DejaVu Sans Mono:pixelsize=12:antialias=true:hinting=true"
    , bgColor = "#000000"
        , fgColor = "grey"
        , position = Static { xpos = 0 , ypos = 0, width = 1200, height = 16 }
    , commands = [
          Run MultiCpu [ "--template" , "<autototal>"
          , "--Low"      , "50"         -- units: %
          , "--High"     , "85"         -- units: %
          , "--low"      , "gray"
          , "--normal"   , "darkorange"
          , "--high"     , "darkred"
          , "-c"         , " "
          , "-w"         , "3"
          ] 10
        , Run Wireless "wlan0" [ "--template", "<essid> <quality>%"
        , "-L","50"
        , "-H","85"
        , "--low", "darkred"
        , "--normal", "grey"
        , "--high", "darkorange"
        ] 10
        , Run Memory [ "--template" ,"Mem: <usedratio>%"
        , "--Low"      , "50"        -- units: %
        , "--High"     , "85"        -- units: %
        , "--low"      , "grey"
        , "--normal"   , "darkorange"
        , "--high"     , "darkred"
        ] 10
        , Run Date "%H:%M][%a %b %_d.%m.%Y" "date" 10
        , Run Com "/home/den/.xmonad/scripts/volume.sh" [] "volume" 10
        , Run Kbd [("us(dvorak)", "DV"), ("us", "en")]
        , Run StdinReader
    ]  
    , sepChar = "%"
    , alignSep = "}{"
    , template = " %StdinReader%}{[<fc=#FFFFCC>Cpu:%multicpu%</fc> | <fc=#FFFFCC>%memory%</fc> | <fc=#FFFFCC>Wi-fi: %wlan0wi%</fc>]<fc=#FFFFCC>%volume%</fc><fc=#FFFFCC>[%date%]</fc><fc=#FFFFCC>[%kbd%]</fc>"
}
