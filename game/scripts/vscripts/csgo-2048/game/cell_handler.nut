
::new_cell_handler <- function (board_res) {

    local handler = {
        cells = [],

        board_res = board_res,

        function reset() {
            foreach (cell in cells) {
                cell.reset();
            }
            cells = [];
        }

        function think(percent) {
            foreach (cell in cells) {
                if (cell.target_pos != null) {
                    cell.think(percent);
                }
            }
        }

        function add_new_cell() {
            // TODO: Should be 2 most of the time, but 4 sometimes
            local value = 2;
            
            local x = null;
            local y = null;
            local cell = null;
            local index = 0;

            do {
                x = RandomInt(0, board_res - 1);
                y = RandomInt(0, board_res - 1);
                cell = get_cell(x, y);
                index++;
            } while (cell != null && index < 500)

            if (cell == null) {
                cells.append(new_cell(x, y, value, board_res));
            }
        }

        function get_cell(x, y) {
            foreach (cell in cells) {
                if (cell.pos.x == x && cell.pos.y == y) {
                    return cell;
                }
            }
            return null;
        }

        function get_cell_from_array(x, y, array) {
            foreach (cell in array) {
                if (cell.pos.x == x && cell.pos.y == y) {
                    return cell;
                }
            }
            return null;
        }

        function get_cell_from_target_pos(x, y) {
            foreach (cell in cells) {
                if (cell.target_pos != null) {
                    if (cell.target_pos.x == x && cell.target_pos.y == y) {
                        return cell;
                    }
                }
                else if (cell.pos.x == x && cell.pos.y == y) {
                    return cell;
                }
            }
            return null;
        }

        function after_shift() {
            local game_won = false;
            local new_cells = [];
            for (local x = 0; x < board_res; x++) {
                for (local y = 0; y < board_res; y++) {
                    if (get_cell_from_array(x, y, new_cells))
                        continue

                    local cell = get_cell(x, y);
                    if (cell) {
                        local value = cell.value;
                        if (cell.merged) {
                            value = value * 2;
                            if (value >= 2048) {
                                game_won = true;
                            }
                        }
                        new_cells.append(new_cell(x, y, value, board_res));
                    }
                }
            }
            reset();
            cells = new_cells;
            return game_won;
        }

        function is_game_over() {
            return (cells.len() >= pow(board_res, 2));
        }
        
        function try_shift(dir) {
            local can_shift = false;

            for (local a = 0; a < board_res; a++) {
                for (local b = 1; b < board_res; b++) {
                    local cell = null;
                    local x = -1;
                    local y = -1;

                    switch (dir) {
                        case DIRECTION.UP:      { x = a; y = b; break; }
                        case DIRECTION.DOWN:    { x = a; y = board_res - 1 - b; break; }
                        case DIRECTION.LEFT:    { x = b; y = a; break; }
                        case DIRECTION.RIGHT:   { x = board_res - 1 - b; y = a; break; }
                    }

                    cell = get_cell(x, y);

                    if (cell == null)
                        continue;

                    local colliding_cell = null;
                    local i = 0;
                    switch (dir) {
                        case DIRECTION.UP:
                        {
                            do {
                                i++;
                                colliding_cell = get_cell_from_target_pos(x, y-i);
                            } while (colliding_cell == null && y-i > 0)
                            break;
                        }
                        case DIRECTION.DOWN:
                        {
                            do {
                                i++;
                                colliding_cell = get_cell_from_target_pos(x, y+i);
                            } while (colliding_cell == null && y+i < board_res - 1)
                            break;
                        }
                        case DIRECTION.LEFT:
                        {
                            do {
                                i++;
                                colliding_cell = get_cell_from_target_pos(x-i, y);
                            } while (colliding_cell == null && x-i > 0)
                            break;
                        }
                        case DIRECTION.RIGHT:
                        {
                            do {
                                i++;
                                colliding_cell = get_cell_from_target_pos(x+i, y);
                            } while (colliding_cell == null && x+i < board_res - 1)
                            break;
                        }
                    }

                    if (i > 1 || (i == 1 && colliding_cell == null) || (i == 1 && colliding_cell && cell.value == colliding_cell.value)) {
                        can_shift = true;
                    }

                    if (colliding_cell) {
                        if (cell.value == colliding_cell.value && !colliding_cell.merged) {
                            cell.merged = true;
                            colliding_cell.merged = true;
                            switch (dir) {
                                case DIRECTION.UP:      { cell.shift_to(x, y-i); break; }
                                case DIRECTION.DOWN:    { cell.shift_to(x, y+i); break; }
                                case DIRECTION.LEFT:    { cell.shift_to(x-i, y); break; }
                                case DIRECTION.RIGHT:   { cell.shift_to(x+i, y); break; }
                            }
                        }
                        else {
                            switch (dir) {
                                case DIRECTION.UP:      { cell.shift_to(x, y-i+1); break; }
                                case DIRECTION.DOWN:    { cell.shift_to(x, y+i-1); break; }
                                case DIRECTION.LEFT:    { cell.shift_to(x-i+1, y); break; }
                                case DIRECTION.RIGHT:   { cell.shift_to(x+i-1, y); break; }
                            }
                        }
                    }
                    else {
                        switch (dir) {
                            case DIRECTION.UP:      { cell.shift_to(x, y-i); break; }
                            case DIRECTION.DOWN:    { cell.shift_to(x, y+i); break; }
                            case DIRECTION.LEFT:    { cell.shift_to(x-i, y); break; }
                            case DIRECTION.RIGHT:    { cell.shift_to(x+i, y); break; }
                        }
                    }
                }
            }

            return can_shift;
        }
    }
    return handler;
}
