module Msgs exposing (..)

import Models exposing (Player)
import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Http


type Msg
    = ChangeLocation String
    | OnFetchPlayers (WebData (List Player))
    | OnFetchPlayer (WebData (Player))
    | OnPlayerSave (Result Http.Error Player)
    | OnLocationChange Location
    | ChangeLevel Player Int
