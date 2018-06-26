module Main exposing (..)

import Models exposing (Model, initialModel, Route(..))
import Msgs exposing (Msg(..))
import Navigation exposing (Location)
import Subscription exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    update (OnLocationChange location) initialModel


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
