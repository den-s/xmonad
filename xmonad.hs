import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders(smartBorders)
import XMonad.Layout.PerWorkspace
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import System.IO
import System.Exit


defaultLayouts = tiled ||| smartBorders Full ||| Mirror tiled ||| Full
    where
        -- default tiling algorithm partitions the screen into two panes  
        tiled = spacing 2 $ Tall nmaster delta ratio
        -- The default number of windows in the master pane
        nmaster = 1
        -- Default proportion of screen occupied by master pane
        ratio = 2/3
        -- Percent of screen to increment by when resizing panes
        delta = 5/100

nobordersLayout = smartBorders $ Full
myLayout = onWorkspaces ["1:Dev","5:VirtualBox", "7:hon"] nobordersLayout $ defaultLayouts

myWorkspaces = ["1:Dev","2:Web","3:Console","4:Chat","5:VirtualBox", "6:Multimedia", "7:hon"] ++ map show [8..9]

myManageHook = composeAll
    [ className =? "Gvim" --> doShift "1:Dev"
    , className =? "Iceweasel" --> doShift "2:Web"
    , className =? "URxvt" --> doShift "3:Console"
    , className =? "Wicd-client.py" --> doFloat
    , className =? "Skype" --> doShift "4:Chat"
    , className =? "Skype" --> doFloat
    , className =? "Vlc" --> doShift "6:Multimedia"
    , className =? "Gpicview" --> doFloat
    , className =? "Heroes of Newerth" --> doShift "7:hon"
    , className =? "Plugin-container" --> doFloat
    , manageDocks ]

main = do  
    xmproc <- spawnPipe "/usr/bin/xmobar /home/den/.xmonad/xmobar.hs"
    xmonad $ defaultConfig
        { modMask = mod1Mask
        , terminal = "urxvt"
        , borderWidth = 2
        , normalBorderColor = "#abc123"
        , focusedBorderColor = "#456def"
        , layoutHook = avoidStruts $ myLayout
        , workspaces = myWorkspaces
        , manageHook = myManageHook <+> manageHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "blue" "" . shorten 50
            , ppLayout = const "" -- to disable the layout info on xmobar
            }
        }`additionalKeysP`
        [ ("M-<F4>", kill) -- to kill appolications
        , ("<XF86ScreenSaver>", spawn "slock") -- to kill appolications
        , ("M-<F2>", spawn "exe=`dmenu_run -b -nb black -nf yellow -sf yellow` && eval \"exec $exe\"")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 10%+ unmute") -- Volume Up
        , ("<XF86AudioLowerVolume>", spawn "amixer set Master 10%- unmute") -- Volume Down
        , ("<XF86AudioMute>", spawn "amixer set Master mute") -- Volume Down
        , ("<XF86MonBrightnessUp>", spawn "xbacklight +20") -- Volume Up
        , ("<XF86MonBrightnessDown>", spawn "xbacklight -20") -- Volume Up
        , ("<Print>", spawn "scrot screen_%Y-%m-%d-%H-%M-%S.png -d 1 -e 'mv $f ~/Pictures/'") --take a screenshot of entire display
        , ("M-<Print>", spawn "scrot window_%Y-%m-%d-%H-%M-%S.png -d 1-u -e 'mv $f ~/Pictures/'") --take a screenshot of focused window
        ]
