module Test.Readable where

import Prelude (Unit, bind, discard, ($))

import Control.Monad.Aff as Aff
import Control.Monad.Eff.Exception as Exception
import Node.Encoding as Encoding
import Node.Stream as Stream
import Test.Spec as Spec
import Test.Spec.Assertions as Assertions
import Test.Spec.Runner as Runner

import Node.StreamBuffer.Effect as Effect
import Node.StreamBuffer.Readable as Readable

testPut :: forall e.
           Spec.Spec (
             Runner.RunnerEffects
               ( exception :: Exception.EXCEPTION
               , sb :: Effect.STREAM_BUFFER
               | e )
           ) Unit
testPut = Spec.describe "put" $
  Spec.it "sends a string to the underlying stream" do
    out <- Aff.makeAff \_ success -> do
      readable <- Readable.readable
      Readable.put readable Encoding.UTF8 "test"
      Stream.onDataString readable Encoding.UTF8 $ success
    out `Assertions.shouldEqual` "test"

testReadable :: forall e.
                Spec.Spec (
                  Runner.RunnerEffects
                    ( exception :: Exception.EXCEPTION
                    , sb :: Effect.STREAM_BUFFER
                    | e )
                ) Unit
testReadable = Spec.describe "Readable" $
  testPut
