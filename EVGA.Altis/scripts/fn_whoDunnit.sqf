/*
	File: fn_whoDunnit
	Description: Save log file of units killed.
	Author: © ColinM - Help of BI Wiki & Forums.
	
	Credits:	KillzoneKid for his Debug_Console v3.0 file.
				Cuel from the BI Forums for his current & previous posts.
*/

if(isServer) then 
{
	private["_victim","_killer","_distance","_killerWep","_weaponName","_killerVeh","_vehName"];
	_victim = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
	_killer = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param;
	
	_distance = _killer distance _victim;
	_distance = floor(_distance);
	
	_killerWep = currentWeapon _killer;
	_weaponName = (configFile >> "cfgWeapons" >> _killerWep);
	_weaponName = format["%1",getText(_weaponName >> "displayName")];
	_killerWep = format["%1",_weaponName];
	
	_killerVeh = vehicle _killer;
	_vehName = getText(configFile >> "CfgVehicles" >> (typeOf _killerVeh) >> "displayName");
	

	if(_victim == _killer) then
	{
		diag_log format ["Selbstmord: %1 hat sich umgebracht",_killer getVariable["realname",name _killer]];
	} else {
		diag_log format ["Fahrzeugtod: %2 wurde von %1 mit einem %3 umgefahren",_killer getVariable["realname",name _killer], _victim getVariable["realname",name _victim], _vehName];
		diag_log format ["Totenanzeige: %2 wurde von %1 mit einer %3 auf einer Distanz von %4 Meter getoetet",_killer getVariable["realname",name _killer], _victim getVariable["realname",name _victim], _killerWep, _distance];
	};
};