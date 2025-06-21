import XMonad hiding (docks)
--import basic Haskell stuff
import Data.String
-- needed for spawnPipe
import XMonad.Util.Run
-- System
import System.Exit
-- Status Bar helpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicHooks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageDocks
-- needed for keybinds
import qualified Data.Map as M
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
-- Workspace stuffs
import XMonad.StackSet
import XMonad.Actions.WorkspaceNames
-- needed for window focus
import qualified XMonad.StackSet as W
-- Extra Actions
import XMonad.Actions.CycleWS
import XMonad.Actions.FloatKeys
import XMonad.Actions.GridSelect
-- Added Layouts/Layout Helpers
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.TwoPane
import XMonad.Layout.NoBorders
--import XMonad.Layout.Spacing


main = do
  dzenBarRight <- spawnPipe myStatusBar
  dzenBarLeft <- spawnPipe myLeftBar
  xmonad $ docks def
    { layoutHook = myLayout
    , terminal = myTerminal
    , modMask = myModMask
    , keys = myKeys
    , logHook = dynamicLogWithPP $ def { ppOutput = hPutStrLn dzenBarLeft }
    --, workspaces = myWorkSpaces  
    }

myGSConfig = GSConfig
    { gs_cellheight = 175
    , gs_cellwidth = 250
    , gs_cellpadding = 10
    }



-- Default variable initializations
myTerminal = "xrdb -remove && xrdb -merge ~/.Xresources && xterm"
-- Modkey Define
myModMask = mod4Mask
topBackground = darkGrey
topForeground = skyBlue2



-- Completely Redefined all keybinds
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  -- keybinds to open applications
  [ ((modMask, xK_b), spawn "brave")
  , ((modMask, xK_v), spawn "vivaldi-stable")
  , ((modMask, xK_e), spawn "emacs")
  , ((modMask, xK_d), spawn "discord")
  , ((modMask, xK_o), spawn "libreoffice")
  , ((modMask, xK_p), spawn "dmenu_run")
  , ((modMask, xK_w), spawn "xrdb -merge ~/.Xresources && xterm -bg '#4c1e64' -fg '#09c3f6' -e 'sudo monero-wallet.sh'")
  , ((modMask .|. shiftMask, xK_s), spawn "xterm -e scryer-prolog")
  , ((shiftMask, xK_F9), spawn "xterm -e htop")
  , ((shiftMask, xK_F10), spawn "xterm -e bluetoothctl")
  , ((modMask .|. shiftMask, xK_Return), spawn myTerminal)
  -- keybinds to switch workspaces
  , ((modMask, xK_Left), prevWS)
  , ((modMask, xK_Right), nextWS)
  , ((modMask .|. shiftMask, xK_Left), shiftToPrev >> prevWS)
  , ((modMask .|. shiftMask, xK_Right), shiftToNext >> nextWS)
  , ((modMask .|. shiftMask, xK_g), gridselectWorkspace myGSConfig W.view)
  -- moves the full workspaces
  , ((modMask .|. shiftMask .|. controlMask, xK_Left), shiftToPrev)
  , ((modMask .|. shiftMask .|. controlMask, xK_Right), shiftToPrev)
  -- switch focus/windows/kill
  , ((modMask, xK_j), windows W.focusDown)
  , ((modMask, xK_Tab), windows W.focusDown) --second keybbind
  , ((modMask, xK_k), windows W.focusUp) 
  , ((modMask .|. shiftMask, xK_Tab), windows W.focusUp) --second keybbind
  , ((modMask .|. shiftMask, xK_j), windows W.swapDown)
  , ((modMask .|. shiftMask, xK_k), windows W.swapUp)
  , ((modMask, xK_Return), windows W.swapMaster)
  , ((modMask, xK_m), windows W.focusMaster)
  , ((modMask, xK_comma), sendMessage (IncMasterN 1))
  , ((modMask, xK_period), sendMessage (IncMasterN (-1)))
  , ((modMask .|. shiftMask, xK_c), kill)
  -- change/manipulate layouts  
  , ((modMask, xK_space), sendMessage NextLayout)
  , ((modMask .|. shiftMask, xK_d), sendMessage ToggleStruts)
  , ((modMask .|. controlMask, xK_d), withFocused $ windows . W.sink)
  , ((modMask .|. controlMask, xK_f), setLayout $ XMonad.layoutHook conf)
  -- Floating window manipulations

  , ((modMask, xK_h), sendMessage Shrink)
  , ((modMask, xK_l), sendMessage Expand)
  , ((modMask .|. controlMask, xK_h), sendMessage MirrorExpand)
  , ((modMask .|. controlMask, xK_l), sendMessage MirrorShrink)
  -- move window 10 pixels
  , ((modMask .|. controlMask, xK_Left), withFocused (keysMoveWindow (-30,0)))
  , ((modMask .|. controlMask, xK_Right), withFocused (keysMoveWindow (30,0)))
  , ((modMask .|. controlMask, xK_Up), withFocused (keysMoveWindow (0,-30)))
  , ((modMask .|. controlMask, xK_Down), withFocused (keysMoveWindow (0,30)))
  -- system stuff
  , ((modMask .|. shiftMask, xK_q), io (exitWith ExitSuccess))
  , ((modMask, xK_q), spawn "killall dzen2 && xmonad --recompile && xmonad --restart")
  ]

-- User defined Colours
lightGreen = "#0af426"
skyBlue = "#19b8e6"
angryRed = "#fd0702"
forestGreen = "#279010"
deepBlue = "#002657"
pastelPink = "#ff93f9"
darkGrey = "#062b30"
skyBlue2 = "#1dc6db"


myLayout =
  avoidStruts $
  smartBorders $ (
  Full
  ||| ResizableTall 1 (3/100) (1/2) []
  ||| TwoPane (15/100) (55/100)
  ||| Grid
  ||| Mirror (Tall 1 (3/100) (1/2)))

----- Workspace configurations ------
-- plan for here:
-- when ever a pipe is spawned, or app opened in a workspace,
-- It will append the spawned process's name to the workspaces's,
-- The symbol appearing will be decided by a weighting system
--   - for each app opened its weight will shift
--   - the icon is decided by the dominant weight
--   - ex: if there are just terminals, or mostly so its symbol will be a terminal
--   - ex: if there are 2 browsers and a terminal it will have a browser symbol
--   - ex: if there are 2 browser, 2 terminal, but the terminal was opened first the symbol will be a terminal
-- The weight system can be used to name the space in the future too

----- Theme stuff -----
-- Theme options
-- myTheme = defaultTheme
  --{
  --}

-- Urgency Hook
--myUrgencyHook = withUrgencyHook

--------DZEN STUFF----------

--Dzen Settings and setup
--constructMyStatusBar :: [String] -> String -> String
--constructMyStatusBar [] y = y
--constructMyStatusBar tail x y = 

myLeftBar = leftBar
-- myLeftBar = unwords [ populateLeftBar, " | ", leftBar]
leftBar = unwords 
  [ " dzen2"
  --, " -p"
  , " -dock"
  , " -x '0'"
  , " -y '0'"
  , " -h '20'"
  , " -w '750'"
  , " -ta 'l'"
  , " -bg '"++topBackground++"'"
  , " -fg '"++topForeground++"'"
  ]
populateLeftBar ="echo \"This is where I would put my left bar... IF I HAD ONE!\""

  
myStatusBar = unwords [ populateStatusBar, " | ",  rightBar ]
rightBar = unwords 
  [ " dzen2"
  , " -dock "
  , " -x '750'"
  , " -y '0'"
  , " -h '20'"
  , " -ta 'r'"
  , " -bg '"++topBackground++"'"
  , " -fg '"++topForeground++"'"
  ]

populateStatusBar =
  unwords
  [ "while :; do "
  , "echo \""
--  , "(echo hello world testing | dzen2 | -l -m)"
  , "$(date +%m/%d/%y) "
  , "$(date +%H:%M%p)  "
  , "Volume: $(amixer sget Master | awk -F'[][]' '/Left:/ { print $2 }') "
  , "Battery:$(battery.sh)"
  , "\"; sleep 15; done"
  ]
