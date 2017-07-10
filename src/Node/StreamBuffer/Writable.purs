module Node.StreamBuffer.Writable
  ( writable
  , contents
  ) where

import Prelude (show, (<<<))

import Control.Monad.Eff as Eff
import Node.Encoding as Encoding
import Node.Stream as Stream

import Node.StreamBuffer.Effect as Effect

-- | Creates a writable stream buffer.
foreign import writable ::
  forall eff.
  Eff.Eff
    (sb :: Effect.STREAM_BUFFER | eff)
    (Stream.Writable () (sb :: Effect.STREAM_BUFFER | eff))

-- | Returns an effect containing the contents of a writable stream buffer,
-- | given an encoding string.
foreign import contentsImpl ::
  forall r eff.
  String ->
  Stream.Writable r (sb :: Effect.STREAM_BUFFER | eff) ->
  Eff.Eff (sb :: Effect.STREAM_BUFFER | eff) String

-- | Returns an effect containing the contents of a writable stream buffer,
-- | given an Encoding.
contents :: forall r eff.
            Encoding.Encoding ->
            Stream.Writable r (sb :: Effect.STREAM_BUFFER | eff) ->
            Eff.Eff (sb :: Effect.STREAM_BUFFER | eff) String
contents = contentsImpl <<< show
