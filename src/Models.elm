module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player)
    , player : WebData (Player)
    , route : Route
    }


initialModel : Model
initialModel =
    { players = RemoteData.Loading
    , player = RemoteData.Loading
    , route = LoadingRoute
    }


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }

type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | LoadingRoute
    | NotFoundRoute
