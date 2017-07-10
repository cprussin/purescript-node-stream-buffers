module Test.Main where

import Prelude (Unit, discard, ($))

import Control.Monad.Eff as Eff
import Control.Monad.Eff.Exception as Exception
import Node.StreamBuffer as StreamBuffer
import Test.Spec as Spec
import Test.Spec.Reporter as Reporter
import Test.Spec.Runner as Runner

import Test.Writable as Writable
import Test.Readable as Readable

main :: Eff.Eff (
          Runner.RunnerEffects
            ( exception :: Exception.EXCEPTION
            , sb :: StreamBuffer.STREAM_BUFFER
            )
        ) Unit
main = Runner.run [ Reporter.specReporter ] $
  Spec.describe "Node.StreamBuffer" do
    Writable.testWritable
    Readable.testReadable
