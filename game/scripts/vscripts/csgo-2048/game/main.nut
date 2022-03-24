/*
    Info Teleport Destination
*/
local targe_board_center = null;
targe_board_center = Entities.FindByName(targe_board_center, "targe_board_center");
::pos_board_center <- targe_board_center.GetOrigin();

::new_game <- function (board_res) {

    local game = {
        ANIMATION_TIME = 0.15,

        board = null,
        cell_handler = null,

        board_res = board_res,

        game_won = false,
        game_over = false,

        is_animating = false,
        time_animation_start = 0,

        function init() {
            board = new_board(board_res);
            cell_handler = new_cell_handler(board_res);

            cell_handler.add_new_cell();
            cell_handler.add_new_cell();
        }

        function reset() {
            board.reset();
            cell_handler.reset();
        }

        function soft_reset() {
            reset();
            init();
        }

        function update() {
            if (!game_over){
                if (is_animating) {
                    local time_current = Time();
                    local percent = (time_current - time_animation_start) / ANIMATION_TIME;

                    cell_handler.think(percent);

                    if (percent > 1) {
                        is_animating = false;

                        game_won = cell_handler.after_shift();
                        game_over = cell_handler.is_game_over()

                        if (game_won) {
                            console.log("Game Won!");
                            game_over = true;
                        }
                        else if (game_over) {
                            console.log("Game Over!");
                        }
                        else {
                            cell_handler.add_new_cell();
                        }
                    }
                }
                else {
                    if (InputState.Forward)                 { if (cell_handler.try_shift(DIRECTION.UP))     { start_animation(); }}
                    if (!is_animating && InputState.Back)   { if (cell_handler.try_shift(DIRECTION.DOWN))   { start_animation(); }}
                    if (!is_animating && InputState.Left)   { if (cell_handler.try_shift(DIRECTION.LEFT))   { start_animation(); }}
                    if (!is_animating && InputState.Right)  { if (cell_handler.try_shift(DIRECTION.RIGHT))  { start_animation(); }}
                }
            }
        }

        function start_animation() {
            is_animating = true;
            time_animation_start = Time();
        }
    }
    game.init();
    return game;
}
