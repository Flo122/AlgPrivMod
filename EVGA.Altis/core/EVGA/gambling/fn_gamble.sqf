#include <macro.h>


private["_display","_gambling_result","_won","_gamble_val","_gamble_type","_gamble_return","_gamble_win_factor","_watched_gambling","_jackpot_won","_gamble_val_to_jackpot","_jackpot","_casino_is_illegal"];

_display = findDisplay 5000;
_gambling_result = _display displayCtrl 5007;

//check if Display is still open
//if(isNull _display) exitWith {hint "Display is gone...";};
if(isNull _display) exitWith {};

if(EVGA_Gamble_player_is_blocked == 1) exitWith
{
    //_gambling_result ctrlSetStructuredText parseText format["You are still blocked time=%1 unblocktime=%2", time, EVGA_Gamble_unblock_time]; 
    //hint format["Blocked!!!!!!!"];
};

if(EVGA_Gamble_roll_time_to_wait > 0) exitWith
{
    //hint format["You have gambled too fast! Please wait"];
};

//parse input values
_gamble_type        = [_this,0,"",[""]] call BIS_fnc_param;
_gamble_return      = [_this,1,0,[0]] call BIS_fnc_param;
_gamble_val         = [_this,2,0,[0]] call BIS_fnc_param;
_gamble_win_factor  = [_this,3,0,[0]] call BIS_fnc_param;
_jackpot_won        = [_this,4,0,[0]] call BIS_fnc_param;

//value check
if(_gamble_val > EVGA_Gamble_max_bet) exitWith {hint format["%1 $%2", EVGA_Gamble_you_cant_gamble_more_then, [EVGA_Gamble_max_bet] call life_fnc_numberText];};
if(_gamble_val <= 0) exitwith {hint format["%1", EVGA_Gamble_please_enter_a_value_above_zero];};
if(!([str(_gamble_val)] call TON_fnc_isnumber)) exitWith {hint format["%1", EVGA_Gamble_this_isnt_an_actual_number_format];};
if(_gamble_val > life_cash_pirates) exitWith {hint format["%1", EVGA_Gamble_not_that_much_money];};
if(EVGA_Gamble_npc_name distance player > 5) exitWith {hint format["%1", EVGA_Gamble_too_far_away_from_npc];};



_won = 0;


if(_gamble_return == 1) then
{
    _won = 1;
    _gamble_val = _gamble_val * _gamble_win_factor;
}
else
{
    _won = 0;
};

//_life_cash_pirates_OLD = life_cash_pirates;

//block the player for gambling and set the time for the next try
EVGA_Gamble_player_is_blocked = 1;
EVGA_Gamble_unblock_time = time + EVGA_Gamble_player_is_blocked_after_gambling;
//[[0,format["%1 BLOCK gamble 1", time]],"life_fnc_broadcast",nil,false] spawn life_fnc_MP;


//ANIMTEST
/*
//EVGA_Gamble_npc_name playMove "ActsPercMstpSnonWnonDnon_DancingStefan";
EVGA_Gamble_npc_name switchMove "AmovPsitMstpSnonWpstDnon_ground";
//TestNPC switchMove "AmovPsitMstpSnonWpstDnon_ground";
EVGA_Gamble_npc_name disableAI "Anim";

EVGA_Gamble_npc_name enableAI "Anim";
//EVGA_Gamble_npc_name playMove "ActsPercSnonWnonDnon_carFixing2";
//EVGA_Gamble_npc_name switchMove "AmovPsitMstpSnonWpstDnon_ground";
//TestNPC switchMove "AmovPsitMstpSnonWpstDnon_ground";
//EVGA_Gamble_npc_name disableAI "Anim";
*/

//sleep 3.0;
//sleep 3.0;

///////////


if(_won == 1) then
{
    life_cash_pirates = life_cash_pirates + _gamble_val;

    if(_jackpot_won == 1) then
    {
        _casino_is_illegal = EVGA_Gamble_casino_is_illegal select EVGA_Gamble_casino_idx;
        _jackpot = EVGA_Gamble_jackpot select _casino_is_illegal;

        //The Player gets the Pot!!!
        [[player, EVGA_Gamble_casino_is_illegal select EVGA_Gamble_casino_idx],"EVGA_fnc_gambleJackpotWon",false,false] spawn life_fnc_MP;
        if(EVGA_Gamble_send_jackpot_win_to_chat == 1) then
        {
            [[0,format["%1 %2",name player, EVGA_Gamble_send_jackpot_won_to_chat_message]],"life_fnc_broadcast",nil,false] spawn life_fnc_MP;
        };

        playSound ["Jackpot",true];
        hint format["%1 $%2", EVGA_Gamble_jackpot_won_text, [_jackpot] call life_fnc_numberText];
        _gambling_result ctrlSetStructuredText parseText format["%1 $%2", EVGA_Gamble_jackpot_won_text, [_jackpot] call life_fnc_numberText]; 
    }
    else
    {
        playSound ["Win",true];
        hint format["%1 $%2", EVGA_Gamble_won_text, [_gamble_val] call life_fnc_numberText];
        _gambling_result ctrlSetStructuredText parseText format["%1 $%2", EVGA_Gamble_won_text, [_gamble_val] call life_fnc_numberText]; 
    };

    /*
    EVGA_Gamble_npc_name enableAI "Anim";
    T1 enableAI "Anim";
    //EVGA_Gamble_npc_name enablesimulation true;
    EVGA_Gamble_npc_name playMove "AinvPknlMstpSnonWnonDnon_medic_1";    
    T1 playMove "AinvPknlMstpSnonWnonDnon_medic_1";    
    Player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
    zivi1 playMove "AinvPknlMstpSnonWnonDnon_medic_1";
    */
}
else
{
    life_cash_pirates = life_cash_pirates - _gamble_val;

    //add the lost money to the jackpot
    _gamble_val_to_jackpot = ceil (_gamble_val * (EVGA_Gamble_add_lost_money_to_the_jackpot_percent / 100.0));
    if(_gamble_val_to_jackpot < 1) then
    {
        //in case of a low bid we add min. $1 to the jackpot
        _gamble_val_to_jackpot = 1;
    };
    [[player, _gamble_val_to_jackpot, EVGA_Gamble_casino_is_illegal select EVGA_Gamble_casino_idx],"EVGA_fnc_gambleJackpotAdd",false,false] spawn life_fnc_MP;

    playSound ["Lost",true];
    hint format["%1 $%2", EVGA_Gamble_lost_text, [_gamble_val] call life_fnc_numberText];
    _gambling_result ctrlSetStructuredText parseText format["%1 $%2", EVGA_Gamble_lost_text, [_gamble_val] call life_fnc_numberText]; 

    /*
    EVGA_Gamble_npc_name enableAI "Anim";
    T1 enableAI "Anim";
    //EVGA_Gamble_npc_name enablesimulation true;
    EVGA_Gamble_npc_name playMove "AmovPsitMstpSnonWpstDnon_ground"; 
    T1 switchMove "AmovPsitMstpSnonWpstDnon_ground";    
    Player switchMove "AmovPsitMstpSnonWpstDnon_ground";    
    zivi1 playMove "AinvPknlMstpSnonWnonDnon_medic_1";
    */
};


//illegal gambling
if(EVGA_Gamble_casino_is_illegal select EVGA_Gamble_casino_idx == 1) then
{
    _watched_gambling = random 100;
    if(_watched_gambling < EVGA_Gamble_watched_illegal_gambling_percent) then
    {
        playSound ["SirenLong",true];
        [[getPlayerUID player,name player,"42"],"life_fnc_wantedAdd",false,false] spawn life_fnc_MP;
        _gambling_result ctrlSetStructuredText parseText format["%1", EVGA_Gamble_you_have_been_watched_gambling_illegal];
        //titleText[format["%1", EVGA_Gamble_you_have_been_watched_gambling_illegal],"PLAIN"];
        if(EVGA_Gamble_send_watched_illegal_gambling_to_chat == 1) then
        {
            [[0,format["%1 %2",name player, EVGA_Gamble_send_watched_illegal_gambling_to_chat_message]],"life_fnc_broadcast",west,false] spawn life_fnc_MP;
        };
    };
};

//hint format["Param |%1|, |%2|, |%3|, |%4|, |%5|", _gamble_type, _gamble_return, _gamble_val, _life_cash_pirates_OLD, life_cash_pirates];

//save data to db
[1,false] call SOCK_fnc_updateRequest;

//call the base function again to refresh the ui
[_gamble_type] call EVGA_fnc_gambling;
