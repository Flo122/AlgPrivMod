#include <macro.h>


disableSerialization;

private["_return","_image1","_image2","_image3","_idx1","_idx2","_idx3","_gamble_val","_gamble_win_factor","_jackpot_won","_reroll"];

_jackpot_won = 0;

if(EVGA_Gamble_player_is_blocked == 1) exitWith
{
    //['einarmiger Bandit'] call EVGA_fnc_gambling;
};

if(EVGA_Gamble_roll_time_to_wait > 0) exitWith
{
    //hint format["You have gambled too fast! Please wait"];
};

//check if Display is still open
_display = findDisplay 5000;
if(isNull _display) exitWith {hint "Display is gone...";};

//parse input values
_gamble_val = parseNumber(ctrlText 5002);

//value check
if(_gamble_val > EVGA_Gamble_max_bet) exitWith {hint format["%1 $%2", EVGA_Gamble_you_cant_gamble_more_then, [EVGA_Gamble_max_bet] call life_fnc_numberText];};
if(_gamble_val <= 0) exitwith {hint format["%1", EVGA_Gamble_please_enter_a_value_above_zero];};
if(!([str(_gamble_val)] call TON_fnc_isnumber)) exitWith {hint format["%1", EVGA_Gamble_this_isnt_an_actual_number_format];};
if(_gamble_val > life_cash_pirates) exitWith {hint format["%1", EVGA_Gamble_not_that_much_money];};
if(EVGA_Gamble_npc_name distance player > 5) exitWith {hint format["%1", EVGA_Gamble_too_far_away_from_npc];};

//start the gamble roll timer
EVGA_Gamble_roll_time_to_wait = EVGA_Gamble_roll_time;
[] spawn EVGA_fnc_gamble_timer;

_icons = ["core\EVGA\icons\gambling\cat_001.paa","core\EVGA\icons\gambling\cat_002.paa","core\EVGA\icons\gambling\cat_003.paa","core\EVGA\icons\gambling\cat_004.paa","core\EVGA\icons\gambling\cat_005.paa","core\EVGA\icons\gambling\cat_006.paa","core\EVGA\icons\gambling\cat_007.paa","core\EVGA\icons\gambling\cat_008.paa","core\EVGA\icons\gambling\cat_009.paa","core\EVGA\icons\gambling\cat_010.paa","core\EVGA\icons\gambling\cat_011.paa","core\EVGA\icons\gambling\cat_012.paa"];
//images von https://www.iconfinder.com/search/?q=iconset%3Acat-force
//License: Free for commercial use

while {EVGA_Gamble_roll_time_to_wait > 0} do
{ 
    _display = findDisplay 5000;

    _image1 = _display displayCtrl 5201;
    _image2 = _display displayCtrl 5202;
    _image3 = _display displayCtrl 5203;

    _idx1 = floor(random count _icons);
    _idx2 = floor(random count _icons);
    _idx3 = floor(random count _icons);

    //lower the win chance...
    if( (_idx1 == _idx2) || (_idx2 == _idx3) || (_idx1 == _idx3) ) then
    {
        _reroll = random 10;
        if(_reroll < EVGA_Gamble_reroll_if_won_factor_bandit) then
        {
            _idx1 = floor(random count _icons);
            _idx2 = floor(random count _icons);
            _idx3 = floor(random count _icons);           
        };
    };
    
    _image1 ctrlSetStructuredText parseText format["<img size='2.5' image='%1'/>", _icons select _idx1 ];
    _image2 ctrlSetStructuredText parseText format["<img size='2.5' image='%1'/>", _icons select _idx2 ];
    _image3 ctrlSetStructuredText parseText format["<img size='2.5' image='%1'/>", _icons select _idx3 ];        

    sleep 0.05;
};


if( (_idx1 == _idx2) || (_idx2 == _idx3) || (_idx1 == _idx3) ) then
{
    //won
    _gamble_win_factor = EVGA_Gamble_bandit_win_factor_two_of_a_kind select EVGA_Gamble_casino_idx;
    if( (_idx1 == _idx2) && (_idx2 == _idx3) && (_idx1 == _idx3) ) then
    {
        _gamble_win_factor = EVGA_Gamble_bandit_win_factor_three_of_a_kind select EVGA_Gamble_casino_idx;
    };
    if( (_idx1 == 0) && (_idx2 == 0) && (_idx3 == 0) ) then
    {
        //JACKPOT!!!
        _jackpot_won = 1;
    };
    _return = 1;
}
else
{
    //lost
    _gamble_win_factor = 1;
    _return = 0;
};

['einarmiger Bandit', _return, _gamble_val, _gamble_win_factor, _jackpot_won] call EVGA_fnc_gamble;
