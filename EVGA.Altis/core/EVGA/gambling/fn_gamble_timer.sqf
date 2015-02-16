#include <macro.h>


//prevent multiple processing
if(EVGA_Gamble_roll_timer_is_running == 1) exitWith {};
EVGA_Gamble_roll_timer_is_running = 1;

disableSerialization;

//show the bar and timer
ctrlShow [5003, true];
ctrlShow [5005, true];

while {EVGA_Gamble_roll_time_to_wait > 0} do
{ 
    _display = findDisplay 5000;
    EVGA_Gamble_roll_time_to_wait = EVGA_Gamble_roll_time_to_wait - 0.1;
    sleep 0.1;
    if(EVGA_Gamble_roll_time_to_wait < 0) then
    {
        EVGA_Gamble_roll_time_to_wait = 0;
    };
    //_text_timer = _display displayCtrl 5003;
    //_text_timer ctrlSetStructuredText parseText format["%1sec",[EVGA_Gamble_roll_time_to_wait] call life_fnc_numberText];

    _bar2 = _display displayCtrl 5005;
    _bar2 progressSetPosition EVGA_Gamble_roll_time_to_wait / EVGA_Gamble_roll_time;
};

//hide the bar and timer
ctrlShow [5003, false];
ctrlShow [5005, false];

EVGA_Gamble_roll_timer_is_running = 0;
