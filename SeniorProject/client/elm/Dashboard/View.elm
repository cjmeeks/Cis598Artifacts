module Dashboard.View exposing (..)

import Bootstrap.Card as Card
import FontAwesome.Web as Icon
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (Model, Msg(..))
import Workout.View exposing (workoutView)
import Graph.Graph as G


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "row main-row" ]
            [ div [ class "test col-4 main-graph" ]
                [ graphView "Distance Over Time" model.allGraphs.runDistance ]
            , div [ class "test col-4 main-graph" ]
                [ graphView "Mile Avg Over Time" model.allGraphs.runMileAvg ]
            , div [ class "test col-4 main-graph" ]
                [ graphView "Speed Over Time" model.allGraphs.runSpeedAvg ]
            ]
        , div [ class "row run-row" ]
            [ div [ class "fav-header col 12" ] [ text "My Favorite Workouts" ]
            , div [ class "col-12 run" ] <|
                List.map (workoutView False) model.user.user_saved_workouts
            ]
        ]


graphView : String -> List ( Float, Float ) -> Html a
graphView name list =
    Card.config []
        |> Card.headerH1 [] [ text name ]
        |> Card.block []
            [ Card.custom <| G.mainView list
            ]
        |> Card.view
