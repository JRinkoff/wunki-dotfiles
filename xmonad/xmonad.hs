import           XMonad
import           XMonad.Actions.CycleWS
import           XMonad.Prompt
import           XMonad.Prompt.Window
import qualified XMonad.StackSet              as W
import           XMonad.Util.Run              (spawnPipe)

-- Hooks
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks

-- Actions
import           XMonad.Actions.WindowGo

-- Layouts
import           XMonad.Layout.Grid
import           XMonad.Layout.Magnifier
import           XMonad.Layout.PerWorkspace

-- Keys
import qualified Data.Map                     as M
import           Graphics.X11.ExtraTypes.XF86

import qualified System.IO.UTF8               as UTF8

main :: IO()
main = do
    xmobar <- spawnPipe "xmobar"  -- start xmobar
    xmonad $ defaultConfig
        { manageHook = manageHook'
        , modMask = mod4Mask
        , layoutHook = avoidStruts myLayout
        , logHook = dynamicLogWithPP $ xmobarPP
                    { ppOutput = UTF8.hPutStrLn xmobar
                    , ppUrgent = xmobarColor "#de935f" ""
                    , ppTitle = xmobarColor "#c5c8c6" ""
                    , ppCurrent = xmobarColor "#81a2be" ""
                    }
        , borderWidth = 1
        , normalBorderColor  = "#1a1a1a"
        , focusedBorderColor = "#373b41"
        , workspaces = ["1:Shell", "2:Vim", "3:Browser", "4:GUI", "5:Fullscreen"]
        , terminal  = "urxvtc"
        , keys = \c -> myKeys c `M.union` keys defaultConfig c
        , startupHook = myStartupHook
        }

-- Layouts
standardLayout = tiled ||| Full ||| Grid
    where tiled     = Tall nmaster delta ratio
          nmaster   = 1
          ratio     = 3/5
          delta     = 3/100

myLayout = onWorkspace "5:Fullscreen" Full $
           standardLayout

-- Float & Window setup
myManageHook :: ManageHook
myManageHook = manageDocks <+> composeAll
    [ className =? "Chromium"             --> doF (W.shift "3:Browser")
    , className =? "Firefox-bin"          --> doF (W.shift "3:Browser")
    , className =? "Firefox"              --> doF (W.shift "3:Browser")
    , className =? "Chromium"             --> doF (W.shift "3:Browser")
    , className =? "Iceweasel"            --> doF (W.shift "3:Browser")
    , className =? "Conkeror"             --> doF (W.shift "3:Browser")
    , className =? "Emacs"                --> doF (W.shift "2:Vim")
    , className =? "GVIM"                 --> doF (W.shift "2:Vim")
    , className =? "Thunar"               --> doF (W.shift "4:GUI")
    ]

manageHook' :: ManageHook
manageHook' = (doF W.swapDown) <+> manageDocks <+> manageHook defaultConfig <+> myManageHook

myKeys conf@(XConfig {XMonad.modMask = modMask, workspaces = ws}) = M.fromList $
    [ ((0, xF86XK_AudioLowerVolume), spawn "/home/wunki/bin/volume decrease") -- Lower volume
    , ((0, xF86XK_AudioRaiseVolume), spawn "/home/wunki/bin/volume increase") -- Raise volume
    , ((0, xF86XK_AudioMute), spawn "/home/wunki/bin/volume mute")            -- Mute
    , ((0, xF86XK_AudioPlay), spawn "mpc toggle")                             -- Play/pause
    , ((0, xF86XK_AudioPrev), spawn "mpc prev")                               -- Previous song
    , ((0, xF86XK_AudioNext), spawn "mpc next")                               -- Next song
    , ((0, xF86XK_Launch1),   spawn "/usr/bin/chromium")                      -- Launch Conkeror
    , ((modMask, xK_b),       sendMessage ToggleStruts)                       -- Hide top bar
    , ((modMask, xK_Print),   spawn "scrot -q90 /home/wunki/pictures/screenshots/%Y-%m-%d-%H%M%S.png")
    , ((modMask .|. controlMask, xK_p), sendMessage MagnifyMore)
    , ((modMask .|. controlMask, xK_l), sendMessage MagnifyLess)
    , ((modMask .|. controlMask, xK_m), sendMessage Toggle)
    , ((modMask .|. controlMask, xK_w), raiseMaybe (spawn "/home/wunki/bin/conk") (className =? "Conkeror"))
    , ((modMask .|. controlMask, xK_e), raiseMaybe (spawn "/home/wunki/bin/em") (className =? "Emacs"))
    -- cycle through workspaces
    , ((modMask, xK_n), moveTo Next (WSIs (return $ not . (=="SP") . W.tag)))
    , ((modMask, xK_p), moveTo Prev (WSIs (return $ not . (=="SP") . W.tag)))
    , ((modMask, xK_d), spawn "dmenu_run -i -fn 'Consolas-11:normal' -nb '#1d1f21' -nf '#c5c8c6' -sb '#1d1f21' -sf '#81a2be' -p '>' ") -- %! Launch dmenu
    , ((modMask, xK_g), windowPromptGoto  defaultXPConfig)
    , ((modMask, xK_c), windowPromptBring defaultXPConfig)
    ]

-- | Perform an arbitrary action at xmonad startup.
myStartupHook :: X ()
myStartupHook = return ()
