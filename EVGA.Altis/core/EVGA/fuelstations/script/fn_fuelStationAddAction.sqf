/*
	File: fn_fuelStationAddAction.sqf
	
	Description:
	Adds the Action to Fueltrucks
*/

private["_vehicle"];

_vehicle = [_this,0,objNull] call BIS_fnc_param;

if(isNull _vehicle) exitWith {};

_vehicle addAction["Refuel other Vehicles",EVGA_fnc_fuelStationMenu,["FUELTRUCK",1],-1,false,false,"","vehicle player == player && !life_action_inUse && _target in life_vehicles"];