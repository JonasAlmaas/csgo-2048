
::new_cell_handler <- function (board_res, pos_top_left, cell_size) {
    local handler = {
        cells = [],

        board_res = board_res,
        pos_top_left = pos_top_left,
        cell_size = cell_size,
        half_cell_size = cell_size * 0.5,

        function reset() {
            foreach (cell in cells) {
                cell.reset();
            }
        }

        /*
            Return
                true    Everything is fine
                false   Game Over
        */
        function add_cell(value) {
            if (pow(board_res, 2) == cells.len()) {
                return false;
            }

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
                cells.append(new_cell(x, y, value, pos_top_left, cell_size));
            }

            return true;
        }

        function get_cell(x, y) {
            foreach (cell in cells) {
                if (cell.pos.x == x && cell.pos.y == y) {
                    return cell;
                }
            }
            return null;
        }

        function shift_up() {
            for (local x = 0; x < board_res; x++) {
                for (local y = 1; y < board_res; y++) {
                    local cell = get_cell(x, y);
                    local colliding_cell = null;

                    if (cell != null) {
                        local i = 0;
                        do {
                            i++;
                            colliding_cell = get_cell(x, y-i);
                        } while (colliding_cell == null && y-i > 0)

                        if (colliding_cell != null) {
                            cell.shift_to(x, y-i+1);
                        }
                        else {
                            cell.shift_to(x, y-i);
                        }
                    }


                    // if (cell) {
                    //     // Check for merge
                    //     local colliding_cell = get_cell(x-1, y);
                    //     if (colliding_cell != null) {
                    //         if (colliding_cell.value == value) {
                    //         }
                    //     }
                    //     else {
                    //         cell.shift_to(x-1, y)
                    //     }
                    // }
                }
            }
        }
        
        function shift_down() {
            // for (local x = 0; x < board_res; x++) {
            //     for (local y = 0; y < board_res; y++) {
                    
            //     }
            // }
        }

        function shift_left() {
            // for (local x = 0; x < board_res; x++) {
            //     for (local y = 0; y < board_res; y++) {
                    
            //     }
            // }
        }
        
        function shift_right() {
            // for (local x = 0; x < board_res; x++) {
            //     for (local y = 0; y < board_res; y++) {
                    
            //     }
            // }
        }
    }
    return handler;
}
