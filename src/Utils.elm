module Utils exposing (..)

import Html exposing (Attribute)
import Html.Events exposing (onWithOptions)
import Json.Decode as Decode

{-| When clicking a link we want to prevent the default browser behaviour which is to load a new page.
Unless the ctrl or command key is pressed.
So we use `onWithOptions` instead of `onClick`.
-}
onLinkClick : msg -> Attribute msg
onLinkClick message =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
    onWithOptions
        "click"
        options
        (preventDefaultUnlessKeyPressed
            |> Decode.andThen (maybePreventDefault message)
        )

maybePreventDefault : msg -> Bool -> Decode.Decoder msg
maybePreventDefault msg preventDefault =
    case preventDefault of
        True ->
            Decode.succeed msg

        False ->
            Decode.fail "Delegated to browser default"

nor : Bool -> Bool -> Bool
nor x y =
    not (x || y)

preventDefaultUnlessKeyPressed : Decode.Decoder Bool
preventDefaultUnlessKeyPressed =
    Decode.map2
        nor
        (Decode.field "ctrlKey" Decode.bool)
        (Decode.field "metaKey" Decode.bool)
