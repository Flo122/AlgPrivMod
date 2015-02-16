#include <macro.h>

private["_jackpot_legal","_jackpot_illegal"];

//check if the player init is already done
if(isnil ("EVGA_Gamble_jackpot")) exitWith {};

_jackpot_legal   = [_this,0,0,[0]] call BIS_fnc_param;
_jackpot_illegal = [_this,1,0,[0]] call BIS_fnc_param;

EVGA_Gamble_jackpot set [0, _jackpot_legal];
EVGA_Gamble_jackpot set [1, _jackpot_illegal];

//hint format["Received new Jackpots legal=%1 illegal=%2", _jackpot_legal, _jackpot_illegal];