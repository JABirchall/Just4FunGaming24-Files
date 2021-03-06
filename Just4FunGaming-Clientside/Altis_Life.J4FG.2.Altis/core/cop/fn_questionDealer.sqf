// Written by Kupferkarpfen
// License: CC BY-NC-SA 4.0

private _dealer = _this select 0;
private _sellers = _dealer getVariable["sellers", []];

if( player != vehicle player ) exitWith {
    hint "Bitte erst aussteigen";
};

if(XY_actionInUse) exitWith {};
XY_actionInUse = true;
XY_interrupted = false;

disableSerialization;

private _duration = 30;

private _startTime = time;
private _timeOut = _startTime + _duration;
private _interrupted = true;

5 cutRsc ["XY_progressBar", "PLAIN"];
private _ui = uiNameSpace getVariable "XY_progressBar";
private _progress = _ui displayCtrl 38201;
(_ui displayCtrl 38202) ctrlSetText "Befrage Dealer...";

while { alive player && player == vehicle player && !XY_isTazed && !XY_interrupted && !(player getVariable["restrained", false]) && player distance _dealer <= 10 } do {

    private _cp = (time - _startTime) / (_timeOut - _startTime);
    _progress progressSetPosition _cp;

    if(_cp >= 1) exitWith {
        _interrupted = false;
    };
    sleep 0.25;
};

5 cutText ["", "PLAIN"];
XY_actionInUse = false;

if( _interrupted ) exitWith {
    XY_interrupted = false;
    hint localize "STR_NOTF_ActionCancel";
};

private _names = "";
{
    // chance that the dealer doesn't talk about his suppliers...
    if( random 100 < 40 ) then {
        [_x select 0, "138"] remoteExec ["XY_fnc_wantedAdd", 2];
        _names = format[ "%1%2<br/>", _names, _x select 1 ];
        _sellers set[ _forEachIndex, -1 ];
    };
} forEach _sellers;

if( _names isEqualTo "" ) exitWith {
    hint "Hier hat in letzter Zeit niemand etwas verkauft oder der Dealer weigert sich zu reden";
};

_sellers = _sellers - [-1];
_dealer setVariable["sellers", _sellers, true];

hint parseText format["<t color='#FF0000' size='2'>Namensliste</t><br/><t color='#FFD700' size='1.25'>Der Dealer hat über folgende Leute ausgepackt:</t><br/>%1", _names];