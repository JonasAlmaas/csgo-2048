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

::SCRIPTS_MANIFEST_GAME <- [
    "game/board",
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
::player <- null;

::game <- null;
::initialized <- false;

/*
    Functions
*/

::reset_session <- function () {
    utils.remove_decals();
    EntFireByHandle(point_viewcontroler, "disable", "", 0.0, null, null);
    game.reset();
}

::update <- function () {
    calculate_tickrate();

    if (!initialized) {
        setup_entity_group();
        
        setup_player_reference();
        if (player) {
            EntFireByHandle(game_ui, "Activate", "", 0.0, player.ref, null);
            EntFireByHandle(point_viewcontroler, "enable", "", 0.0, player.ref, null);
        }

        game = new_game(4);

        initialized = true;
    }

    game.update();
}

::setup_entity_group <- function () {
    game_ui = EntityGroup[0];
    point_viewcontroler = EntityGroup[1];
}

::setup_player_reference <- function () {
    local target = null;
    while ((target = Entities.FindByClassname(target, "*player*")) != null) {
        if (target.GetClassname() == "player") {
            player = new_player(target);
            break;
        }
    }
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
