
::new_cell <- function (x, y, value, board_res) {

    local cell_size = BOARD_SIZE / board_res;
    local half_cell_size = cell_size * 0.5;

    local half_board_size = BOARD_SIZE * 0.5;
    local pos_top_left = pos_board_center + Vector(-half_board_size, half_board_size);

    local cell = {
        prop = null,
        text = null,
        value = value,

        pos = Vector(x, y),
        target_pos = null,

        merged = false,

        cell_size = cell_size,
        half_cell_size = half_cell_size,
        pos_top_left = pos_top_left,

        function init() {
            // Cell prop
            local index = 0;
            do {
                index++;
            } while (value > pow(2, index))

            prop = new_prop_dynamic();
            prop.set_scale(cell_size);
            prop.set_color(COLOR.CELLS[index]);
            prop.set_model(GAME_MODEL.CELL);
            prop.disable_shadows();
            local global_pos = pos_top_left + Vector(cell_size * pos.x + half_cell_size, -(cell_size * pos.y + half_cell_size), BOARD_OFFSET * 2);
            prop.teleport(global_pos);

            // Text
            local font_size = cell_size * 0.3;
            local text_pos = global_pos + Vector(0,0,BOARD_OFFSET);
            local color = COLOR.TEXT.DARK;
            if (value >= 8)
                color = COLOR.TEXT.LIGHT;
            text = new_dynamic_text("" + value, font_size, "kanit_semibold", color, "center_center", text_pos, Vector(270, 270));
        }

        function think(percent) {
            local new_pos = null;
            local p2 = pos_top_left + Vector(cell_size * target_pos.x + half_cell_size, -(cell_size * target_pos.y + half_cell_size), BOARD_OFFSET * 2);
            
            if (percent < 1) {
                local p1 = pos_top_left + Vector(cell_size * pos.x + half_cell_size, -(cell_size * pos.y + half_cell_size), BOARD_OFFSET * 2);
                new_pos = math.vec_lerp(p1, p2, percent);
            }
            else {
                pos = math.vec_clone(target_pos);
                target_pos = null;
                new_pos = p2;
            }

            prop.teleport(new_pos);
            
            local text_pos = new_pos + Vector(0,0,BOARD_OFFSET);
            text.teleport(text_pos, Vector(270, 270));
        }

        function shift_to(x, y) {
            target_pos = Vector(x, y);
        }

        function reset() {
            prop.disable();
            text.kill();
        }
    }
    cell.init();
    return cell;
}
