{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module Main where

import Servant
import Network.Wai (Application)
import Network.Wai.Handler.Warp (run)

type Echo = "echo" :> ReqBody '[PlainText] String :> Get '[PlainText] String

handleEcho :: Server Echo
handleEcho txt = return txt

api :: Proxy Echo
api = Proxy

app :: Application
app = serve api handleEcho

-- | $ cabal exec -- runhaskell Echo.hs
--   and enter next command in other shell prompt.
--   $ curl -X GET -H 'Content-Type: text/plain;charset=utf-8' -d 'Hello' http://localhost:8081/echo
main :: IO ()
main = run 8081 app
