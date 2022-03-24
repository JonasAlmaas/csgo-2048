::BOARD_OFFSET <- 0.1;
::BOARD_SIZE <- 512;

COLOR <- {
    TEXT = {
        LIGHT = [249, 246, 242],
        DARK = [119, 110, 101],
    },
    BACKGROUND = [250, 248, 239],
    BOARD_BACKGROUND = [187, 173, 160],
    CELLS = [
        [205, 192, 180],    // 0
        [238, 228, 218],    // 2
        [237, 224, 200],    // 4
        [242, 177, 121],    // 8
        [245, 149, 99],     // 16
        [246, 124, 95],     // 32
        [247, 95, 59],      // 64
        [237, 208, 115],    // 128
        [237, 204, 98],     // 256
        [235, 193, 77],     // 512
        [237, 189, 61],     // 1024
        [245, 189, 48],     // 2048
    ],
}

::DIRECTION <- {
    UP = 1,
    DOWN = 2,
    LEFT = 3,
    RIGHT = 4,
}

/*
    MODEL PATHS
*/

::GAME_MODEL <- {
    CELL = "models/csgo-2048/cell.mdl",
    BACKGROUND_CELL = "models/csgo-2048/background_cell.mdl",
    BACKGROUND_CORNER = "models/csgo-2048/background_corner.mdl",
}

/*
    FUNCTIONS
*/
::precache_manifest <- function (manifest) {
    foreach (path in manifest) {
        self.PrecacheModel(path);
    }
}

::precache_2048 <- function() {
    precache_manifest(GAME_MODEL);
}
