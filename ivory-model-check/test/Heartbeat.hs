{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module Heartbeat where

import           Ivory.Language.Uint

import           Ivory.Language.Area
import           Ivory.Language.Proc
import           Ivory.Serialize

import           Ivory.Language

-- import Ivory.ModelCheck

heartbeatMsgId :: Uint8
heartbeatMsgId = 0

heartbeatCrcExtra :: Uint8
heartbeatCrcExtra = 50

heartbeatModule :: Module
heartbeatModule = package "mavlink_heartbeat_msg" $ do
  depend serializeModule
  incl packUnpack
  incl heartbeatPack
  incl heartbeatUnpack
  defStruct (Proxy :: Proxy "heartbeat_msg")

[ivory|
struct heartbeat_msg
  { custom_mode :: Stored Uint32
  ; mavtype :: Stored Uint8
  ; autopilot :: Stored Uint8
  ; base_mode :: Stored Uint8
  ; system_status :: Stored Uint8
  ; mavlink_version :: Stored Uint8
  }
|]

packUnpack :: Def ('[Ref s1 (Struct "heartbeat_msg")] :-> ())
packUnpack = proc "heartbeat_pack_unpack" $ \ msg -> body $ do
  buf <- local (iarray [] :: Init (Array 9 (Stored Uint8)))
  let buf' = toCArray buf
  call_ heartbeatPack (constRef msg) buf'
  msg' <- local (istruct [] :: Init (Struct "heartbeat_msg"))
  call_ heartbeatUnpack msg' (constRef buf')
  cm1 <- deref (msg ~> custom_mode)
  cm2 <- deref (msg' ~> custom_mode)
  mt1 <- deref (msg ~> mavtype)
  mt2 <- deref (msg' ~> mavtype)
  ap1 <- deref (msg ~> autopilot)
  ap2 <- deref (msg' ~> autopilot)
  bm1 <- deref (msg ~> base_mode)
  bm2 <- deref (msg' ~> base_mode)
  ss1 <- deref (msg ~> system_status)
  ss2 <- deref (msg' ~> system_status)
  mv1 <- deref (msg ~> mavlink_version)
  mv2 <- deref (msg' ~> mavlink_version)
  assert (cm1 ==? cm2 .&& mt1 ==? mt2 .&& ap1 ==? ap2 .&&
          bm1 ==? bm2 .&& ss1 ==? ss2 .&& mv1 ==? mv2)
  retVoid

heartbeatPack ::
  Def ('[ ConstRef s0 (Struct "heartbeat_msg")
        , Ref s1 (CArray (Stored Uint8))
        ] :-> ())
heartbeatPack =
  proc "heartbeat_pack"
  $ \msg buf -> body
  $ do
  pack buf 0 =<< deref (msg ~> custom_mode)
  pack buf 4 =<< deref (msg ~> mavtype)
  pack buf 5 =<< deref (msg ~> autopilot)
  pack buf 6 =<< deref (msg ~> base_mode)
  pack buf 7 =<< deref (msg ~> system_status)
  pack buf 8 =<< deref (msg ~> mavlink_version)
  retVoid

heartbeatUnpack :: 
  Def ('[ Ref s1 (Struct "heartbeat_msg")
        , ConstRef s2 (CArray (Stored Uint8))
        ] :-> () )
heartbeatUnpack = proc "heartbeat_unpack" $ \ msg buf -> body $ do
  store (msg ~> custom_mode)     =<< unpack buf 0
  store (msg ~> mavtype)         =<< unpack buf 4
  store (msg ~> autopilot)       =<< unpack buf 5
  store (msg ~> base_mode)       =<< unpack buf 6
  store (msg ~> system_status)   =<< unpack buf 7
  store (msg ~> mavlink_version) =<< unpack buf 8
  -- retVoid
