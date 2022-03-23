/*
    Info Teleport Destination
*/
local targe_board_center = null;
targe_board_center = Entities.FindByName(targe_board_center, "targe_board_center");
::pos_board_center <- targe_board_center.GetOrigin();

// TODO: Fix the outside border, it should be as wide as the rest of the stuff.

::new_game <- function (board_res) {
    
    local cell_size = BOARD_SIZE / board_res;
    local half_cell_size = cell_size * 0.5;

    local half_board_size = BOARD_SIZE * 0.5;
    local pos_top_left = pos_board_center + Vector(-half_board_size, half_board_size);

    local game = {
        cell_handler = null,

        background_models = [],

        board_res = board_res,
        half_board_size = half_board_size,
        cell_size = cell_size,
        half_cell_size = half_cell_size,

        pos_top_left = pos_top_left,

        initialized = false,

        function init() {
            cell_handler = new_cell_handler(board_res, pos_top_left, cell_size);

            cell_handler.add_cell(2);
            cell_handler.add_cell(2);

            // for (local i = 0; i < 10; i++) {
            //     cell_handler.add_cell(pow(2, RandomInt(1, 17)));
            // }

            for (local x = 0; x < board_res; x++) {
                for (local y = 0; y < board_res; y++) {
                    // Background
                    {
                        local prop = new_prop_dynamic();
                        prop.set_scale(cell_size);
                        prop.set_color(COLOR.BACKGROUND);
                        prop.disable_shadows();

                        local pos = pos_top_left + Vector(cell_size * x + half_cell_size, -(cell_size * y + half_cell_size));
                        prop.teleport(pos);

                        // Top left
                        if (x == 0 && y == 0) {
                            prop.set_model(GAME_MODEL.BACKGROUND_CORNER);
                        }
                        // Top Right
                        else if (x == board_res - 1 && y == 0) {
                            prop.set_model(GAME_MODEL.BACKGROUND_CORNER);
                            prop.teleport(null, Vector(0, 270));
                        }
                        // Bottom Left
                        else if (x == 0 && y == board_res - 1) {
                            prop.set_model(GAME_MODEL.BACKGROUND_CORNER);
                            prop.teleport(null, Vector(0, 90));
                        }
                        // Bottom Right
                        else if (x == board_res - 1 && y == board_res - 1) {
                            prop.set_model(GAME_MODEL.BACKGROUND_CORNER);
                            prop.teleport(null, Vector(0, 180));
                        }
                        // Fillers
                        else {
                            prop.set_model(GAME_MODEL.BACKGROUND_CELL);
                        }
                        background_models.append(prop);
                    }
                    
                    // Background Grid
                    {
                        local prop = new_prop_dynamic();
                        prop.set_scale(cell_size);
                        prop.set_color(COLOR.CELLS[0]);
                        prop.set_model(GAME_MODEL.CELL);
                        prop.disable_shadows();
                        local new_pos = pos_top_left + Vector(cell_size * x + half_cell_size, -(cell_size * y + half_cell_size), BOARD_OFFSET);
                        prop.teleport(new_pos);
                        background_models.append(prop);
                    }
                }
            }
        }

        function reset() {
            disable_models(background_models);
            cell_handler.reset();
        }

        function soft_reset() {
            reset();
            init();
        }

        function update() {
            if (InputState.Forward) {
                InputState.Forward = false;
                cell_handler.shift_up();
            }
            else if (InputState.Back) {
                InputState.Back = false;
                cell_handler.shift_down();
            }
            else if (InputState.Left) {
                InputState.Left = false;
                cell_handler.shift_left();
            }
            else if (InputState.Right) {
                InputState.Right = false;
                cell_handler.shift_right();
            }
        }

        function disable_models(models) {
            foreach (model in models) {
                model.disable();
            }
        }
    }
    game.init();
    return game;
}
