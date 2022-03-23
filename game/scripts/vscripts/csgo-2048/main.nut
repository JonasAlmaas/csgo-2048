/*
    Global constants
*/
::IS_DEBUGGING <- false;
::IS_DEBUGGING_SINGLE_PLAYER <- false;

/*
    Global includes
*/
::SCRIPTS_MANIFEST_UTILITIES <- [
    "utils/console",
    "utils/constants",
    "utils/convertion",
    "utils/custom_entities",
    "utils/debug_draw",
    "utils/dynamic_text",
    "utils/eventlistener",
    "utils/math",
    "utils/player",
    "utils/utils",
]

::SCRIPTS_MANIFEST_MISC <- [
    "lobby",
]

::SCRIPTS_MANIFEST_GAME <- [
    "game/cell_handler",
    "game/cell",
    "game/main",
    "game/utils",
]

::include_scripts <- function () {
    local include_manifest = function(manifest) {
        foreach(script in manifest){
            DoIncludeScript(BASE_FOLDER + script + MODULE_EXT, null);
        }
    }
    include_manifest(SCRIPTS_MANIFEST_UTILITIES);
    // include_manifest(SCRIPTS_MANIFEST_MISC);
    include_manifest(SCRIPTS_MANIFEST_GAME);
}
include_scripts();

/*
    Entity group
*/
::game_ui <- null;
::point_viewcontroler <- null;

/*
    Global variables
*/
::game <- null;
::initialized <- false;

::update <- function () {

    calculate_tickrate();

    if (!initialized) {
        get_entity_group();
        
        local target = null;
        while ((target = Entities.FindByClassname(target, "*player*")) != null) {
            if (target.GetClassname() == "player") {
                EntFireByHandle(game_ui, "Activate", "", 0.0, target, null);
                EntFireByHandle(point_viewcontroler, "enable", "", 0.0, target, null);
                break;
            }
        }

        greet_player();

        game = new_game(4);

        initialized = true;
    }

    game.update();
}

::get_entity_group <- function () {
    game_ui = EntityGroup[0];
    point_viewcontroler = EntityGroup[1];
}

::greet_player <- function () {
    console.chat("\n " + console.color.grey + " -----------------------");
    console.chat("\n " + console.color.grey + " ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‏‏‎ 2048");
    console.chat("\n " + console.color.red + " ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‏‏‎ ‎‏‏‎ By Almaas");
    console.chat("\n " + console.color.grey + " -----------------------");
}

::reset_session <- function () {
    utils.remove_decals();

    EntFireByHandle(point_viewcontroler, "disable", "", 0.0, null, null);

    game.reset();
}

/*
    TICKRATE
*/
::TICKS <- 0;
::TICKRATE <- -1;
::TICKTIME <- -1;
::calculate_tickrate <- function() {

    if(TICKRATE == -1) {
        TICKS += 1;
        if(TICKTIME == -1) {
            TICKTIME = Time();
        }
        if(Time() - TICKTIME > 1) {
            if(TICKS > 96) {
                TICKRATE = 128;
            } else {
                TICKRATE = 64;
            }
        }
    }
}
