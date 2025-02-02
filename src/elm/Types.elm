module Types exposing (..)

-- MSG


type Msg
    = SelectFirstDoor Door
    | ConfirmDoor
    | RandomlyOpenDoor (Maybe Door)
    | SelectFinalDoor Door
    | Reset
    | ScrambleDoors (List Door)
    | NoOp



-- MODEL


type alias Model =
    { doors : List Door
    , selectedDoor : Maybe Door {- the door that the user first chose -}
    , revealedDoor : Maybe Door {- the goat door randomly revealed to the user -}
    , finalDoor : Maybe Door {- the final choice of the user, if they stay, it's the same as the selectedDoor -}
    }


type alias Door =
    { name : String
    , prize : Prize
    }


type Prize
    = Banana
    | Goat



-- PROGRESS


type Progress
    = Start
    | FirstDoorSelected Door
    | RandomDoorRevealed Door
    | SwitchedOrStayed Door


getProgress : Model -> Progress
getProgress model =
    case model.selectedDoor of
        Nothing ->
            Start

        Just selectedDoor ->
            case model.revealedDoor of
                Nothing ->
                    FirstDoorSelected selectedDoor

                Just revealedDoor ->
                    case model.finalDoor of
                        Nothing ->
                            RandomDoorRevealed revealedDoor

                        Just finalDoor ->
                            SwitchedOrStayed finalDoor
