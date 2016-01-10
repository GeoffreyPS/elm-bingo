module Bingo where 

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import String exposing (toUpper, repeat, trimRight)

--UPDATE

type Action
  = NoOp
  | Sort --union-type

update action model =
  case action of
    NoOp ->
      model

    Sort ->
      { model | entries = List.sortBy .points model.entries }



-- MODEL
initialModel = 
  { entries = 
    [ newEntry "Doing Agile" 200 2
    , newEntry "In The Cloud" 300 3
    , newEntry "Future-Proof" 100 1
    , newEntry "Rock-Star Ninja" 400 4
    ] 
  }

newEntry phrase points id =
  { phrase = phrase
  , points = points
  , wasSpoke = False
  , id = id
  }

-- VIEW
title message times = 
  message ++ " "
    |> toUpper
    |> repeat times
    |> trimRight
    |> text


pageHeader =
  h1 [ ] [ title "bingo!" 3 ] -- [attributes], [child elements]


pageFooter =
  footer [ ]
    [ a [ href "https://pragmaticstudio.com"] 
        [ text "The Pragmatic Studio"]
    ]


entryItem entry =
  li [ ]
    [ span [ class "phrase" ] [ text entry.phrase ]
    , span [class "points"] [text (toString entry.points) ]
    ]

entryList entries =
  ul [ ] (List.map entryItem entries)

view model = 
  div [ id "container"]
    [ pageHeader
    , entryList model.entries
    , pageFooter
    ]

--WIRE IT ALL TOGETHER

main = 
  --view (update Sort initialModel)
  initialModel
  |> update Sort
  |> view
