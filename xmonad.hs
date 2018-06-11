import XMonad
import XMonad.StackSet
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.CustomKeys
import XMonad.Actions.Workscreen
import System.IO

main =
  xmonad $ def
    { borderWidth = 0
    , terminal = "urxvt"
    , keys = customKeys delKeys insKeys
    }
  where
      delKeys :: XConfig l -> [(KeyMask, KeySym)]
      delKeys XConfig {modMask = modm} =
          -- [ (modm .|. shiftMask, xK_Return) -- > terminal
          -- , (modm .|. shiftMask, xK_c)      -- > close the focused window
          -- ]
          -- ++
          [ (modm .|. m, k) | m <- [0, shiftMask], k <- [xK_w, xK_e, xK_r] ]

      insKeys :: XConfig l -> [((KeyMask, KeySym), X ())]
      insKeys conf@(XConfig {modMask = modm}) =
        [
          ((m3, xK_u), windows $ view "1")
        , ((m3, xK_i), windows $ view "2")
        , ((m3, xK_o), windows $ view "3")
        , ((m3, xK_j), windows $ view "4")
        , ((m3, xK_k), windows $ view "5")
        , ((m3, xK_l), windows $ view "6")
        , ((m3, xK_m), windows $ view "7")
        , ((m3, xK_comma), windows $ view "8")
        , ((m3, xK_period), windows $ view "9")
        , ((m2, xK_u), windows $ shift "1")
        , ((m2, xK_i), windows $ shift "2")
        , ((m2, xK_o), windows $ shift "3")
        , ((m2, xK_j), windows $ shift "4")
        , ((m2, xK_k), windows $ shift "5")
        , ((m2, xK_l), windows $ shift "6")
        , ((m2, xK_m), windows $ shift "7")
        , ((m2, xK_comma), windows $ shift "8")
        , ((m2, xK_period), windows $ shift "9")
        , ((mod1Mask, xK_KP_Home), windows $ view "1")
        , ((mod1Mask, xK_KP_Up), windows $ view "2")
        , ((mod1Mask, xK_KP_Page_Up), windows $ view "3")
        , ((mod1Mask, xK_KP_Left), windows $ view "4")
        , ((mod1Mask, xK_KP_Begin), windows $ view "5")
        , ((mod1Mask, xK_KP_Right), windows $ view "6")
        , ((mod1Mask, xK_KP_End), windows $ view "7")
        , ((mod1Mask, xK_KP_Down), windows $ view "8")
        , ((mod1Mask, xK_KP_Page_Down), windows $ view "9")
        ]
        where
          m3 = (mod1Mask .|. shiftMask .|. controlMask )
          m2 = (mod1Mask .|. shiftMask )
