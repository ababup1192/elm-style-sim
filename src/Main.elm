module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (..)



-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { widthValue : Int
    , heightValue : Int
    , marginValue : Int
    , paddingValue : Int
    , borderValue : Int
    , boxSizingValue : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { widthValue = 120
      , heightValue = 120
      , marginValue = 50
      , paddingValue = 20
      , borderValue = 20
      , boxSizingValue = "border-box"
      }
    , Cmd.none
    )



-- ---------------------------
-- UPDATE
-- ---------------------------


type Msg
    = UpdateWidth String
    | UpdateHeight String
    | UpdateMargin String
    | UpdatePadding String
    | UpdateBorder String
    | UpdateBoxSizing String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { widthValue, heightValue, marginValue, paddingValue, borderValue } =
            model
    in
    case msg of
        UpdateWidth widthText ->
            ( { model
                | widthValue = Maybe.withDefault widthValue (String.toInt widthText)
              }
            , Cmd.none
            )

        UpdateHeight heightText ->
            ( { model
                | heightValue = Maybe.withDefault heightValue (String.toInt heightText)
              }
            , Cmd.none
            )

        UpdateMargin marginText ->
            ( { model
                | marginValue = Maybe.withDefault marginValue (String.toInt marginText)
              }
            , Cmd.none
            )

        UpdatePadding paddingText ->
            ( { model
                | paddingValue = Maybe.withDefault paddingValue (String.toInt paddingText)
              }
            , Cmd.none
            )

        UpdateBorder borderText ->
            ( { model
                | borderValue = Maybe.withDefault borderValue (String.toInt borderText)
              }
            , Cmd.none
            )

        UpdateBoxSizing boxSizingV ->
            ( { model
                | boxSizingValue = boxSizingV
              }
            , Cmd.none
            )



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Browser.Document Msg
view model =
    let
        { widthValue, heightValue, marginValue, paddingValue, borderValue, boxSizingValue } =
            model

        widthPx =
            String.fromInt widthValue ++ "px"

        heightPx =
            String.fromInt heightValue ++ "px"

        marginPx =
            String.fromInt marginValue ++ "px"

        paddingPx =
            String.fromInt paddingValue ++ "px"

        borderPx =
            String.fromInt borderValue ++ "px"
    in
    { title = "Elm Style Sim"
    , body =
        [ div
            [ style "height" "100%"
            , style "margin-top" "20px"
            , style "padding" "10px"
            , style "background-color" "#DCDCDC"
            ]
            [ div []
                [ input [ type_ "radio", checked <| boxSizingValue == "border-box", value "border-box", onInput UpdateBoxSizing ] []
                , label [ name "box-sizing" ] [ text "border-box" ]
                , input [ type_ "radio", checked <| boxSizingValue == "content-box", style "margin-left" "15px", value "content-box", onInput UpdateBoxSizing ] []
                , label [ name "box-sizing" ] [ text "content-box" ]
                , input [ type_ "radio", checked <| boxSizingValue == "inherit", style "margin-left" "15px", value "inherit", onInput UpdateBoxSizing ] []
                , label [ name "box-sizing" ] [ text "inherit" ]
                ]
            , div [ class "color-pallet" ]
                [ sliderView
                    { c = "green"
                    , labelText = "margin"
                    , val = marginValue
                    , msg = UpdateMargin
                    , px = marginPx
                    }
                , sliderView
                    { c = "grey"
                    , labelText = "border"
                    , val = borderValue
                    , msg = UpdateBorder
                    , px = borderPx
                    }
                , sliderView
                    { c = "blue"
                    , labelText = "padding"
                    , val = paddingValue
                    , msg = UpdatePadding
                    , px = paddingPx
                    }
                , p [ class "red" ] [ text "content" ]
                , div [ class "color-pallet-item" ]
                    [ span [ style "margin-right" "10px" ] [ text "width" ]
                    , input
                        [ type_ "range"
                        , Attributes.min "0"
                        , Attributes.max "200"
                        , Attributes.step "1"
                        , value <| String.fromInt widthValue
                        , onInput UpdateWidth
                        ]
                        []
                    , span [] [ text widthPx ]
                    ]
                , div [ class "color-pallet-item" ]
                    [ span [ style "margin-right" "10px" ] [ text "height" ]
                    , input
                        [ type_ "range"
                        , Attributes.min "0"
                        , Attributes.max "200"
                        , Attributes.step "1"
                        , value <| String.fromInt heightValue
                        , onInput UpdateHeight
                        ]
                        []
                    , span [] [ text heightPx ]
                    ]
                ]
            , div [ class "container" ]
                [ div
                    [ class "box"
                    , style "width" widthPx
                    , style "height" heightPx
                    , style "margin" marginPx
                    , style "border" <| borderPx ++ " solid grey"
                    , style "padding" paddingPx
                    , style "box-sizing" boxSizingValue
                    ]
                    [ div
                        [ class "content" ]
                        []
                    ]
                ]
            ]
        ]
    }


type alias SliderOption =
    { c : String
    , labelText : String
    , val : Int
    , msg : String -> Msg
    , px : String
    }


sliderView : SliderOption -> Html Msg
sliderView sliderOption =
    let
        { labelText, c, val, msg, px } =
            sliderOption
    in
    div [ class "color-pallet-item" ]
        [ p [ class c ] [ text labelText ]
        , input
            [ type_ "range"
            , Attributes.min "0"
            , Attributes.max "200"
            , Attributes.step "1"
            , value <| String.fromInt val
            , onInput msg
            ]
            []
        , span [] [ text px ]
        ]



-- ---------------------------
-- MAIN
-- ---------------------------


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
