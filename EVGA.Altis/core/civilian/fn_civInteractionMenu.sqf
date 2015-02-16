/*

	Shows pInteraction Menu
	for all civ players

*/

private["_display","_curTarget","_bUnrestrain","_bArrest","_bTicket","_bEscort","_bPutInCar","_bSearch","_bShowLicenses","_bTorture"];
if(!dialog) then 
{
    createDialog "pInteraction_Reb";
};
disableSerialization;
_curTarget = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _curTarget) exitWith {closeDialog 0;}; //Bad target

if(!isPlayer _curTarget) exitWith {hint "Ziel ist kein Spieler"; closeDialog 0; };
//if(!license_civ_rebel) exitWith {hint "Du bist kein Rebelle"; closeDialog 0;}; //Bad side check?
/*
 * Converted rebInteraction to civInteraction
 * */


_display = findDisplay 37400;

//_bArrest = _display displayCtrl 2402;
//_bTicket = _display displayCtrl 2403;
_bEscort = _display displayCtrl 2404;
_bPutInCar = _display displayCtrl 2405;
//_bTorture = _display displayCtrl 2406;
//_bShowLicenses = _display displayCtrl 2407;
_bRobPerson = _display displayCtrl RobPerson;
_bGetSmartphone = _display displayCtrl GetSmartphone;
_bRobPerson ctrlShow false;

life_pInact_curTarget = _curTarget;


///////////////////////////////////////////////////////
/////////////Set actions

//Set Unrestrain Button

/*
 * In der aktuellen Einstellung kann jeder spieler einen anderen entfesseln
 */

//Set Check Licenses Button
//_bShowLicenses ctrlSetTooltip localize "STR_pInAct_checkLicenses";
//_bShowLicenses buttonSetAction "[[player],""life_fnc_licenseCheck"",life_pInact_curTarget,FALSE] spawn life_fnc_MP";

//Set Escort Button
if((_curTarget getVariable["Escorting",false])) then 
{
	_bEscort ctrlSetText "STOP";
	_bEscort ctrlSetTooltip localize "STR_pInAct_StopEscort";
	_bEscort buttonSetAction "closeDialog 0; [life_pInact_curTarget] call life_fnc_stopEscorting; [life_pInact_curTarget] call life_fnc_copInteractionMenu;";
} 
else 
{
	_bEscort ctrlSetTooltip localize "STR_pInAct_Escort";
	_bEscort buttonSetAction "[life_pInact_curTarget] call life_fnc_escortAction; closeDialog 0;";
};
if((_curTarget getVariable["Restrained",true]) && (_curTarget getVariable["robbed",false])) then 
{
	_bRobPerson ctrlSetTooltip localize "STR_pInAct_RobPerson";
	_bRobPerson buttonSetAction "[life_pInact_curTarget] call life_fnc_robAction; closeDialog 0;";
	
}
else
{_bRobPerson ctrlShow false;};
if((_curTarget getVariable["Restrained",true])) then 
{
	_bSmartphone ctrlSetTooltip localize "STR_pInAct_GetSmartphone";
	_bSmartphone buttonSetAction "[life_pInact_curTarget] call life_fnc_robsmartphoneAction; closeDialog 0;";	
}
else
{_bSmartphone ctrlShow false;};



//Set Ticket Button
//_bTicket ctrlSetTooltip localize "STR_pInAct_TicketBtn";
//_bTicket buttonSetAction "[life_pInact_curTarget] call life_fnc_ticketAction;";

//_bArrest ctrlSetTooltip localize "STR_pInAct_Arrest";
//_bArrest buttonSetAction "[life_pInact_curTarget] call life_fnc_arrestAction;";

_bPutInCar ctrlSetTooltip localize "STR_pInAct_PutInCar";
_bPutInCar buttonSetAction "closeDialog 0; [life_pInact_curTarget] call life_fnc_putInCar;";


