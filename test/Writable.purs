module Test.Writable where

import Prelude (Unit, bind, pure, unit, ($))

import Control.Monad.Eff.Class as EffClass
import Control.Monad.Eff.Exception as Exception
import Node.Encoding as Encoding
import Node.Stream as Stream
import Test.Spec as Spec
import Test.Spec.Assertions as Assertions
import Test.Spec.Runner as Runner

import Node.StreamBuffer.Effect as Effect
import Node.StreamBuffer.Writable as Writable

testContents :: forall e.
                Spec.Spec (
                  Runner.RunnerEffects
                    ( exception :: Exception.EXCEPTION
                    , sb :: Effect.STREAM_BUFFER
                    | e )
                ) Unit
testContents = Spec.describe "contents" $
  Spec.it "reads the contents of the stream" do
    out <- EffClass.liftEff do
      writable <- Writable.writable
      _ <- Stream.writeString writable Encoding.UTF8 "test" $ pure unit
      Writable.contents Encoding.UTF8 writable
    out `Assertions.shouldEqual` "test"

testWritable :: forall e.
                Spec.Spec (
                  Runner.RunnerEffects
                    ( exception :: Exception.EXCEPTION
                    , sb :: Effect.STREAM_BUFFER
                    | e )
                ) Unit
testWritable = Spec.describe "Writable" $
  testContents
