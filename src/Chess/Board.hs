{-# LANGUAGE TemplateHaskell #-}

module Chess.Board where

import Control.Lens
import Data.Word

data Player = Player
  { _pawns   :: Word64
  , _knights :: Word64
  , _bishops :: Word64
  , _rooks   :: Word64
  , _queens  :: Word64
  , _king    :: Word64
  , _castle  :: Bool
  } deriving Show
makeLenses ''Player

data Board = Board
  { _white :: Player
  , _black :: Player
  } deriving Show
makeLenses ''Board
