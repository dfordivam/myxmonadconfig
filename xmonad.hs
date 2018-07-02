import XMonad
import XMonad.StackSet
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.CustomKeys
import XMonad.Actions.Workscreen
import Graphics.X11.ExtraTypes.XF86
import System.IO
import XMonad.Layout.PerWorkspace
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier

main =
  xmonad $ def
    { borderWidth = 0
    , terminal = "/home/divam/nobup/alacritty/target/release/alacritty"
    , keys = customKeys delKeys insKeys
    , manageHook = manageHook defaultConfig <+> myManageHook
    , XMonad.workspaces = ["1","2","3","4","5","6","7:gimp","8","9","0"]
    , layoutHook = onWorkspace "gimp" gimpLayout
      $ (layoutHook defaultConfig)
    }
  where
      delKeys :: XConfig l -> [(KeyMask, KeySym)]
      delKeys XConfig {modMask = modm} =
          -- [ (modm .|. shiftMask, xK_Return) -- > terminal
          -- , (modm .|. shiftMask, xK_c)      -- > close the focused window
          -- ]
          -- ++
          [ (modm .|. m, k) | m <- [0, shiftMask], k <- [xK_w, xK_e, xK_r] ]
          ++ [(mod1Mask, n) | n <- [xK_1 .. xK_9]]

      insKeys :: XConfig l -> [((KeyMask, KeySym), X ())]
      insKeys conf@(XConfig {modMask = modm}) =
        [
          ((m3, xK_u), windows $ view "1")
        , ((m3, xK_i), windows $ view "2")
        , ((m3, xK_o), windows $ view "3")
        , ((m3, xK_j), windows $ view "4")
        , ((m3, xK_k), windows $ view "5")
        , ((m3, xK_l), windows $ view "6")
        , ((m3, xK_m), windows $ view "7:gimp")
        , ((m3, xK_comma), windows $ view "8")
        , ((m3, xK_period), windows $ view "9")
        , ((m2, xK_u), windows $ shift "1")
        , ((m2, xK_i), windows $ shift "2")
        , ((m2, xK_o), windows $ shift "3")
        , ((m2, xK_j), windows $ shift "4")
        , ((m2, xK_k), windows $ shift "5")
        , ((m2, xK_l), windows $ shift "6")
        , ((m2, xK_m), windows $ shift "7:gimp")
        , ((m2, xK_comma), windows $ shift "8")
        , ((m2, xK_period), windows $ shift "9")
        , ((mod1Mask, xK_KP_Home), windows $ view "1")
        , ((mod1Mask, xK_KP_Up), windows $ view "2")
        , ((mod1Mask, xK_KP_Page_Up), windows $ view "3")
        , ((mod1Mask, xK_KP_Left), windows $ view "4")
        , ((mod1Mask, xK_KP_Begin), windows $ view "5")
        , ((mod1Mask, xK_KP_Right), windows $ view "6")
        , ((mod1Mask, xK_KP_End), windows $ view "7:gimp")
        , ((mod1Mask, xK_KP_Down), windows $ view "8")
        , ((mod1Mask, xK_KP_Page_Down), windows $ view "9")

        , ((0    , xF86XK_MonBrightnessUp), spawn "xbacklight -inc 5")
        , ((0    , xF86XK_MonBrightnessDown), spawn "xbacklight -dec 5")

        , ((0    , xF86XK_AudioLowerVolume), spawn "amixer -q sset Master 5%-")
        , ((0    , xF86XK_AudioRaiseVolume), spawn "amixer -q sset Master 5%+")
        , ((0    , xF86XK_AudioMute), spawn "amixer set Master toggle")
        ]
        where
          m3 = (mod1Mask .|. shiftMask .|. controlMask )
          m2 = (mod1Mask .|. shiftMask )

-- myManageHook = composeAll
--     [ (role =? "gimp-toolbox" <||> role =? "gimp-image-window") --> (ask >>= doF . sink)
--     -- Note: hooks earlier in this list override later ones, so put the
--     -- role hooks earlier than 'className =? "Gimp" ...' if you use both.
--     -- other skipped manageHooks...
--     ]
--   where role = stringProperty "WM_WINDOW_ROLE"

myManageHook = composeAll
    [ className =? "gimp"     --> doShift "7:gimp"
    , className =? "gimp-2.8" --> doShift "7:gimp"
    ]

gimpLayout =
    noBorders( magnifier( ThreeColMid 1 (3/100) (1/2)) )
  ||| noBorders(Full)
