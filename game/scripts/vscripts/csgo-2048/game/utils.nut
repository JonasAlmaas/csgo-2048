
::BOARD_OFFSET <- 0.05;
::BOARD_SIZE <- 512;

COLOR <- {
    BACKGROUND = [187, 173, 160],
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
        [249, 116, 109],    // 4096
        [249, 94, 93],      // 8192
        [240, 81, 59],      // 16384
        [107, 174, 213],    // 32768
        [87, 156, 225],     // 65536
        [0, 111, 182],      // 131072
        // 262144
        // 524288
        // 1048576
        // 2097152
        // 4194304
        // 8388608
        // 16777216
        // 33554432
        // 67108864
        // 134217728
        // 268435456
        // 536870912
        // 1073741824
    ],
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
