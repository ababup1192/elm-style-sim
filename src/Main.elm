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
      , marginValue = 200
      , paddingValue = 20
      , borderValue = 20
      , boxSizingValue = "content-box"
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
            [ sliderView
                { labelText = "width"
                , val = widthValue
                , msg = UpdateWidth
                , px = widthPx
                }
            , sliderView
                { labelText = "height"
                , val = heightValue
                , msg = UpdateHeight
                , px = heightPx
                }
            , sliderView
                { labelText = "margin"
                , val = marginValue
                , msg = UpdateMargin
                , px = marginPx
                }
            , sliderView
                { labelText = "padding"
                , val = paddingValue
                , msg = UpdatePadding
                , px = paddingPx
                }
            , sliderView
                { labelText = "border"
                , val = borderValue
                , msg = UpdateBorder
                , px = borderPx
                }
            , div []
                [ input [ type_ "radio", checked <| boxSizingValue == "content-box", value "content-box", onInput UpdateBoxSizing ] []
                , label [ name "box-sizing" ] [ text "content-box" ]
                , input [ type_ "radio", checked <| boxSizingValue == "border-box", value "border-box", onInput UpdateBoxSizing ] []
                , label [ name "box-sizing" ] [ text "border-box" ]
                , input [ type_ "radio", checked <| boxSizingValue == "inherit", value "inherit", onInput UpdateBoxSizing ] []
                , label [ name "box-sizing" ] [ text "inherit" ]
                ]
            , div [ class "color-pallet" ]
                [ p [ class "green" ] [ text "margin" ]
                , p [ class "grey" ] [ text "border" ]
                , p [ class "blue" ] [ text "padding" ]
                , p [ class "red" ] [ text "content" ]
                ]
            , div [ class "container" ]
                [ div
                    [ class "box"
                    , style "width" widthPx
                    , style "height" heightPx
                    , style "margin" marginPx
                    , style "border" <| borderPx ++ " solid #7E57C2"
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
    { labelText : String
    , val : Int
    , msg : String -> Msg
    , px : String
    }


sliderView : SliderOption -> Html Msg
sliderView sliderOption =
    let
        { labelText, val, msg, px } =
            sliderOption
    in
    div []
        [ span [ style "margin-right" "10px" ] [ text labelText ]
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
