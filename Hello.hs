module Main where
import Graphics.X11.Xlib
import qualified Graphics.X11.Xft as Xft
import System.Exit (exitWith, ExitCode(..))
import Control.Concurrent (threadDelay)
 
main :: IO ()
main = do
  dpy <- openDisplay ""
  let dflt = defaultScreen dpy
      border = blackPixel dpy dflt
      background = whitePixel dpy dflt
  rootw <- rootWindow dpy dflt
  win <- createSimpleWindow dpy rootw 0 0 100 100 1 border background
  setTextProperty dpy win "Hello World" wM_NAME
  mapWindow dpy win
  let screen = defaultScreenOfDisplay dpy;
      colormap = defaultColormapOfScreen screen;
      visual = defaultVisualOfScreen screen;
  mdraw <- Xft.newDraw dpy win visual colormap
  draw <- case mdraw of Nothing -> fail "Cannot allocate drawable"
                        Just draw' -> return draw'
  mfont <- Xft.newFontName dpy screen "Sans-10"
  font <- case mfont of Nothing -> fail "Cannot open font"
                        Just font' -> return font'
  mcolor <- Xft.newColorName dpy visual colormap "red"
  color <- case mcolor of Nothing -> fail "Cannot find color"
                          Just color' -> return color'
  putStrLn "ARGARGHÄLLL所x有y网z"
  Xft.drawString draw color font 20 20 "ARGARGHÄLLLzѼÅาป"
  sync dpy False
  threadDelay (10 * 1000000)
  Xft.freeColor dpy visual colormap color
  Xft.freeDraw draw
  exitWith ExitSuccess
