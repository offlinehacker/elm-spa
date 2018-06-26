module View exposing (..)

import Html exposing (Html, button, div, p, program, text)
import Models exposing (Model)
import Msgs exposing (Msg)
import Players.Edit
import Players.List


view : Model -> Html Msg
view model =
    div []
        [ page model
        ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.PlayersRoute ->
            Players.List.view model.players

        Models.PlayerRoute id ->
            Players.Edit.view model.player

        Models.NotFoundRoute ->
            notFoundView

        Models.LoadingRoute ->
            loadingView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]

loadingView : Html msg
loadingView =
    div []
        [ text "Loading"
        ]
