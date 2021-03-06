// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0
// Central place to modify player textures and ensure they are re-applied if something changes

private _mappings = switch( playerSide ) do {
    case civilian: {
        [
            [ "U_B_CombatUniform_mcam_vest", "textures\civ_blackwater.paa" ],
            [ "U_C_WorkerCoveralls", "#(argb,8,8,3)color(0.9,0.25,0.0,1)" ]
        ]
    };
    case west: {
        switch(true) do {
            case( license_cop_board ): {
                [ [ "U_B_CombatUniform_mcam_vest", "textures\cop_uniform_boardmember.paa" ] ]
            };
            default {
                [ [ "U_B_CombatUniform_mcam_vest", format["textures\cop_uniform_rank%1.paa", XY_copLevel] ] ]
            };
        };
    };
    case east: {
        [ [ "U_Rangemaster", "textures\thw_uniform.paa" ] ]
    };
    case independent: {
        [ [ "U_B_CTRG_1", format["textures\medic_rank%1.paa", XY_medicLevel] ] ]
    };
};

while { true } do {
    uisleep 1;

    if( !(playerSide isEqualTo civilian) && { !(backpack player isEqualTo "") } ) then {

        private _activeTexture = getObjectTextures (unitBackpack player);
        private _targetTexture = "";

        if(playerSide isEqualTo independent) then {
            _targetTexture = "textures\medic_backpack.paa";
        };
        if(playerSide isEqualTo east) then {
            _targetTexture = "textures\thw_backpack.paa";
        };
        if( (_targetTexture isEqualTo "" && { (_activeTexture select 0) != _targetTexture }) || [_activeTexture select 0, count _targetTexture] call KRON_StrRight != _targetTexture ) then {
            (unitBackpack player) setObjectTextureGlobal [0, _targetTexture];
        };
    };

    private _textures = getObjectTextures player;
    {
        if( (uniform player) isEqualTo (_x select 0) && { !([_textures select 0, count (_x select 1)] call KRON_StrRight isEqualTo (_x select 1)) } ) then {
            player setObjectTextureGlobal [0, _x select 1];
        };
    } forEach _mappings;
};