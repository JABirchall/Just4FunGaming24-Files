/*
	File: fn_pullOutVeh.sqf
	Author: Bryan "Tonic" Boardwine
*/

if(player getVariable "restrained") then {
	detach player;
	player setVariable["escorting", false, true];
	player setVariable["transporting", false, true];
};

player action ["Eject", vehicle player];
titleText[localize "STR_NOTF_PulledOut", "PLAIN"];
titleFadeOut 4;