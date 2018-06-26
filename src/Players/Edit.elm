module Players.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Models exposing (Player)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)
import Html.Attributes exposing (class, value, href)
import Routing exposing (playersPath)
import Utils exposing (onLinkClick)


view : WebData Player -> Html Msg
view model =
    div []
        [ nav
        , maybeForm model
        ]

listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href playersPath
        , onLinkClick (ChangeLocation playersPath)
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


maybeForm : WebData Player -> Html Msg
maybeForm response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success player ->
            form player

        RemoteData.Failure error ->
            text (toString error)


form : Player -> Html Msg
form player =
    div [ class "m3" ]
        [ h1 [] [ text player.name ]
        , formLevel player
        ]


formLevel : Player -> Html Msg
formLevel player =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
        ]


btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    a [ class "btn ml1 h1", onClick (ChangeLevel player -1) ]
        [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    a [ class "btn ml1 h1", onClick (ChangeLevel player 1) ]
        [ i [ class "fa fa-plus-circle" ] [] ]
