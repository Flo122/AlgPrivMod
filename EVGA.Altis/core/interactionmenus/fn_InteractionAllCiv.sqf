/*


	Show vehicle interaction menu
	All in One InteractionMenu
	ImSorry und so 
	Developer of the Year :D

*/


private["_display","_curTarget","_bPKW","_bLKW","_bHeli","_bWaffemNorm","_bWaffenIllegal","_bWaffenBM","_bWaffenReb"];
if(!dialog) then {
	createDialog "InteractionAll_Civ"; //Use pInteraction_Menu with more buttons
};
disableSerialization;
_curTarget = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _curTarget) exitWith {closeDialog 0;}; //Bad target


_display = findDisplay 37400;

_bPKW = _display displayCtrl PKW;
_bLKW = _display displayCtrl LKW;
_bHeli = _display displayCtrl Heli;
_bWaffemNorm = _display displayCtrl WaffenNormal;
_bWaffenIllegal = _display displayCtrl WaffenIllegal;
_bWaffenBM = _display displayCtrl WaffenBM;
_bWaffenReb = _display displayCtrl WaffenReb;

life_pInact_curTarget = _curTarget;

//Set Repair Action
if(_curTarget == )
_bPKW ctrlSetTooltip localize "STR_vInAct_Repair";
_bPKW buttonSetAction "closeDialog 0; [life_vInact_curTarget] spawn life_fnc_vehicleShopMenu;";

if("ToolKit" in (items player)) then {_bRepair ctrlEnable true;} else {_bRepair ctrlEnable false;};


_bLKW ctrlSetTooltip localize "STR_CivInAct_LKW";
_bLKW buttonSetAction "closeDialog 0; [life_vInact_curTarget] spawn life_fnc_searchVehAction;";
	
_bSearch ctrlSetTooltip localize "STR_vInAct_SearchVehicle";
_bSearch buttonSetAction "closeDialog 0; [life_vInact_curTarget] spawn life_fnc_vehInvSearch;";
	
_bPullOut ctrlSetTooltip localize "STR_vInAct_PullOut";
_bPullOut buttonSetAction "closeDialog 0; [life_vInact_curTarget] spawn life_fnc_pulloutAction;";
if(count crew _curTarget == 0) then {_bPullOut ctrlEnable false;};
	
_bImpound ctrlSetTooltip localize "STR_vInAct_Impound";
_bImpound buttonSetAction "closeDialog 0; [life_vInact_curTarget] spawn life_fnc_impoundAction;";
	
//#2
_bPutToGarage ctrlSetTooltip localize "STR_vInAct_Unflip";
_bPutToGarage buttonSetAction "life_vInact_curTarget setPos [getPos life_vInact_curTarget select 0, getPos life_vInact_curTarget select 1, (getPos life_vInact_curTarget select 2)+0.5]; closeDialog 0;";



