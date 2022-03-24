
::new_board <- function (board_res) {

    local models = [];

    local cell_size = BOARD_SIZE / board_res;
    local half_cell_size = cell_size * 0.5;

    local half_board_size = BOARD_SIZE * 0.5;
    local pos_top_left = pos_board_center + Vector(-half_board_size, half_board_size);

    {
        local prop = new_prop_dynamic();
        prop.set_scale(1536);
        prop.set_color(COLOR.BACKGROUND);
        prop.set_model(GAME_MODEL.BACKGROUND_CELL);
        prop.disable_shadows();
        prop.teleport(pos_board_center + Vector(0,0,-BOARD_OFFSET));
        models.append(prop);
    }

    for (local x = 0; x < board_res; x++) {
        for (local y = 0; y < board_res; y++) {
            // Background
            {
                local prop = new_prop_dynamic();
                prop.set_scale(cell_size * 1.1);
                prop.set_color(COLOR.BOARD_BACKGROUND);
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
                models.append(prop);
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
                models.append(prop);
            }
        }
    }

    local board = {
        models = models,

        function reset() {
            foreach (model in models) {
                model.disable();
            }
        }

    }
    return board;
}