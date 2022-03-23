
::InputState <- {
    Forward = false,
    Back = false,
    Left = false,
    Right = false,
}

// Forward
::OnBeginMoveForward <- function () { InputState.Forward = true; }
::OnEndMoveForward <- function () { InputState.Forward = false; }

// Back
::OnBeginMoveBack <- function () { InputState.Back = true; }
::OnEndMoveBack <- function () { InputState.Back = false; }

// Left
::OnBeginMoveLeft <- function () { InputState.Left = true;}
::OnEndMoveLeft <- function () { InputState.Left = false; }

// Right
::OnBeginMoveRight <- function () { InputState.Right = true; }
::OnEndMoveRight <- function () { InputState.Right = false; }
