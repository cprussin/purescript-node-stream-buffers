module Node.StreamBuffer.Effect
  ( STREAM_BUFFER
  ) where

import Control.Monad.Eff as Eff

-- | The effect type for effects that create stream buffers.
foreign import data STREAM_BUFFER :: Eff.Effect
