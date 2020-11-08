{-# LANGUAGE NamedFieldPuns  #-}
{-# LANGUAGE TemplateHaskell #-}

module Chess.Board where

import Control.Applicative ((<|>))
import Control.Lens
import Data.Bits
import Data.Word

data Player = Player
  { _pawns   :: !Word64
  , _knights :: !Word64
  , _bishops :: !Word64
  , _rooks   :: !Word64
  , _queens  :: !Word64
  , _kings   :: !Word64
  } deriving Show
makeLenses ''Player

data Board = Board
  { _white :: !Player
  , _black :: !Player
  } deriving Show
makeLenses ''Board

data Rank
  = One
  | Two
  | Three
  | Four
  | Five
  | Six
  | Seven
  | Eight
  deriving (Enum, Eq, Show)

data File
  = A
  | B
  | C
  | D
  | E
  | F
  | G
  | H
  deriving (Enum, Eq, Show)

data Piece
  = Pawn
  | Knight
  | Bishop
  | Rook
  | Queen
  | King
  deriving Show

data Color = White | Black deriving Show

squareIndex :: File -> Rank -> Int
squareIndex f r = 8 * fromEnum r + fromEnum f

squareBit :: File -> Rank -> Word64
squareBit = bit .: squareIndex
  where (.:) = (.) . (.)

pieceAt :: File -> Rank -> Board -> Maybe (Color, Piece)
pieceAt f r Board { _white, _black } = whte <|> blck
  where
  whte = (White,) <$> playerHas _white
  blck = (Black,) <$> playerHas _black
  t = flip testBit $ squareIndex f r
  playerHas Player { _pawns, _knights, _bishops, _rooks, _queens, _kings }
    | t _pawns   = Just Pawn
    | t _knights = Just Knight
    | t _bishops = Just Bishop
    | t _rooks   = Just Rook
    | t _queens  = Just Queen
    | t _kings   = Just King
    | otherwise  = Nothing

startingPosition :: Board
startingPosition = Board
  (Player 65280
          66
          36
          129
          8
          16)
  (Player 71776119061217280
          4755801206503243776
          2594073385365405696
          9295429630892703744
          576460752303423488
          1152921504606846976)
