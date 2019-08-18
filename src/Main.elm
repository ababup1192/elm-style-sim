module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as JD



-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { widthValue : Int
    , heightValue : Int
    , marginValue : Int
    , paddingValue : Int
    , borderValue : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { widthValue = 120
      , heightValue = 120
      , marginValue = 200
      , paddingValue = 20
      , borderValue = 20
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



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Browser.Document Msg
view model =
    let
        { widthValue, heightValue, marginValue, paddingValue, borderValue } =
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
        [ select []
            [ option [] [ text "Basic - Pading & Margin" ]
            ]
        , div
            [ style "height" "100%"
            , style "margin-top" "20px"
            , style "background-color" "#DCDCDC"
            ]
            [ div []
                [ span [ style "margin-right" "10px" ] [ text "width" ]
                , input
                    [ type_ "range"
                    , Attributes.min "0"
                    , Attributes.max "200"
                    , Attributes.step "1"
                    , value <| String.fromInt widthValue
                    , onChange UpdateWidth
                    ]
                    []
                , span [] [ text widthPx ]
                ]
            , div []
                [ span [ style "margin-right" "10px" ] [ text "height" ]
                , input
                    [ type_ "range"
                    , Attributes.min "0"
                    , Attributes.max "200"
                    , Attributes.step "1"
                    , value <| String.fromInt heightValue
                    , onChange UpdateHeight
                    ]
                    []
                , span [] [ text heightPx ]
                ]
            , div []
                [ span [ style "margin-right" "10px" ] [ text "margin" ]
                , input
                    [ type_ "range"
                    , Attributes.min "0"
                    , Attributes.max "200"
                    , Attributes.step "1"
                    , value <| String.fromInt marginValue
                    , onChange UpdateMargin
                    ]
                    []
                , span [] [ text marginPx ]
                ]
            , div []
                [ span [ style "margin-right" "10px" ] [ text "padding" ]
                , input
                    [ type_ "range"
                    , Attributes.min "0"
                    , Attributes.max "200"
                    , Attributes.step "1"
                    , value <| String.fromInt paddingValue
                    , onChange UpdatePadding
                    ]
                    []
                , span [] [ text paddingPx ]
                ]
            , div []
                [ span [ style "margin-right" "10px" ] [ text "border" ]
                , input
                    [ type_ "range"
                    , Attributes.min "0"
                    , Attributes.max "200"
                    , Attributes.step "1"
                    , value <| String.fromInt borderValue
                    , onChange UpdateBorder
                    ]
                    []
                , span [] [ text borderPx ]
                ]
            , div
                [ style "width" widthPx
                , style "height" heightPx
                , style "margin" marginPx
                , style "border" <| borderPx ++ " solid #7E57C2"
                , style "padding" paddingPx
                , style "background-color" "#FFA726"
                ]
                []
            ]
        ]
    }


onChange : (String -> msg) -> Attribute msg
onChange onChangeAction =
    on "change" <| JD.map onChangeAction targetValue



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
