module View exposing (FormView(..), code, form, repositoryUrl)

import Element exposing (Element)
import Element.Font as Font
import Form
import Form.View
import Form.View.Ui
import Html exposing (Html)
import Html.Attributes as Attributes


type alias CodeSnippet =
    { filename : String
    , path : String
    , code : String
    }


type FormView
    = Default
    | Ui


repositoryUrl : String
repositoryUrl =
    "https://github.com/hecrj/composable-form"


examplesUrl : String
examplesUrl =
    repositoryUrl ++ "/blob/master/examples/src/Page/"


code : List CodeSnippet -> Html msg
code =
    let
        snippetToHtml snippet =
            [ Html.i [ Attributes.class "far fa-file-code" ] []
            , Html.text " "
            , Html.a [ Attributes.href (examplesUrl ++ snippet.path) ] [ Html.text snippet.filename ]
            , Html.text "\n\n"
            , Html.text snippet.code
            , Html.text "\n"
            ]
    in
    List.map snippetToHtml
        >> List.intersperse [ Html.text "\n\n" ]
        >> List.concatMap identity
        >> Html.pre []


form formView =
    case formView of
        Default ->
            Form.View.asHtml

        Ui ->
            asUi


asUi :
    Form.View.ViewConfig values msg
    -> Form.Form values msg
    -> Form.View.Model values
    -> Html msg
asUi viewConfig form_ model =
    Element.layout
        [ Font.size 16
        , Font.family
            [ Font.external
                { url = "https://fonts.googleapis.com/css?family=Source+Sans+Pro"
                , name = "Source Sans Pro"
                }
            , Font.sansSerif
            ]
        ]
        (Form.View.Ui.layout viewConfig form_ model)
