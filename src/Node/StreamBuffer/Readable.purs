module Node.StreamBuffer.Readable
  ( readable
  , put
  ) where

import Prelude (Unit, show, (<<<))

import Control.Monad.Eff as Eff
import Node.Encoding as Encoding
import Node.Stream as Stream

import Node.StreamBuffer.Effect as Effect

-- | Creates a readable stream buffer.
foreign import readable ::
  forall eff.
  Eff.Eff
    (sb :: Effect.STREAM_BUFFER | eff)
    (Stream.Readable () (sb :: Effect.STREAM_BUFFER | eff))

-- | Given a readable stream buffer, an encoding string, and a contents string,
-- | returns an effect containing a write of the contents to the given buffer.
foreign import putImpl ::
  forall r eff.
  Stream.Readable r (sb :: Effect.STREAM_BUFFER | eff) ->
  String ->
  String ->
  Eff.Eff (sb :: Effect.STREAM_BUFFER | eff) Unit

-- | Given a readable stream buffer, an encoding, and a contents string, returns
-- | an effect containing a write of the contents to the given buffer.
put :: forall r eff.
       Stream.Readable r (sb :: Effect.STREAM_BUFFER | eff) ->
       Encoding.Encoding ->
       String ->
       Eff.Eff (sb :: Effect.STREAM_BUFFER | eff) Unit
put buf = putImpl buf <<< show
