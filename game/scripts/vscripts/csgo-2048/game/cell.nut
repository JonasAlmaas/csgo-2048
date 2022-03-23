
::new_cell <- function (x, y, value, pos_top_left, cell_size) {
    local cell = {
        prop = null,
        value = value,

        pos = Vector(x, y),
        last_pos = null,
        target_pos = null,

        half_cell_size = cell_size * 0.5,
        pos_top_left = pos_top_left,
        cell_size = cell_size,

        function init() {
            local index = 0;
            do {
                index++;
            } while (value > pow(2, index))

            prop = new_prop_dynamic();
            prop.set_scale(cell_size);
            prop.set_color(COLOR.CELLS[index]);
            prop.set_model(GAME_MODEL.CELL);
            prop.disable_shadows();
            local new_pos = pos_top_left + Vector(cell_size * pos.x + half_cell_size, -(cell_size * pos.y + half_cell_size), BOARD_OFFSET * 2);
            prop.teleport(new_pos);
        }

        function shift_to(x, y) {
            last_pos = pos;
            target_pos = Vector(x, y);
            
            pos = Vector(x, y);
            local new_pos = pos_top_left + Vector(cell_size * pos.x + half_cell_size, -(cell_size * pos.y + half_cell_size), BOARD_OFFSET * 2);
            prop.teleport(new_pos);
        }

        function reset() {
            prop.disable();
        }
    }
    cell.init();
    return cell;
}
