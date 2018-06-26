module Update exposing (..)

import Commands exposing (fetchPlayer, fetchPlayers, savePlayerCmd)
import Models exposing (Model, Route(..), Player)
import Msgs exposing (Msg(..))
import Navigation exposing (newUrl)
import Routing exposing (parseLocation)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeLocation path ->
            ( model, newUrl path )

        OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        OnFetchPlayer response ->
            ( { model | player = response }, Cmd.none )

        OnPlayerSave (Result.Ok player) ->
            ( {model | player = RemoteData.succeed player }, Cmd.none )

        OnPlayerSave (Result.Err player) ->
            ( model, Cmd.none )

        ChangeLevel player howMuch ->
            (model, savePlayerCmd { player | level = player.level + howMuch})

        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
            { model | route = newRoute }
                ! [ case newRoute of
                        PlayerRoute playerId ->
                            fetchPlayer playerId

                        PlayersRoute ->
                            fetchPlayers

                        NotFoundRoute ->
                            Cmd.none

                        LoadingRoute ->
                            Cmd.none
                  ]
