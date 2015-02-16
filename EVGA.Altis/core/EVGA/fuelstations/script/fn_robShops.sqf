/*
file: fn_robShops.sqf
Author: MrKraken, modded by Teej
 - Added randomized marker name
 - Various fixes & string changes
 - Added attempted robbery
 - Added abort for being restrained
 - Added abort for being arrested
 - Added fix for being killed
 
Made from MrKrakens bare-bones shop robbing tutorial on www.altisliferpg.com forums
Description:
Executes the rob shop action!
Idea developed by PEpwnzya v1.0
*/
private["_robber","_shop","_kassa","_ui","_progress","_pgText","_cP","_rip","_Pos","_rndmrk","_mrkstring"];
_shop = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param; //The object that has the action attached to it is _this. ,0, is the index of object, ObjNull is the default should there be nothing in the parameter or it's broken
_robber = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param; //Can you guess? Alright, it's the player, or the "caller". The object is 0, the person activating the object is 1
_action = [_this,2] call BIS_fnc_param;//Action name
if (isNil "_rip") then { _rip = false };

_cops = (west countSide playableUnits);
if(_cops < 10) exitWith {hint "You can't rob this register, there aren't enough police online!";};
if(side _robber == west) exitWith { hint "What do you think you're doing?" };
if(side _robber == independent) exitWith { hint "Don't you have bigger fish to fry?" };
if(_robber distance _shop > 5) exitWith { hint "You need to be within 5m of the cash register to rob it!" };
if (vehicle player != _robber) exitWith { hint "Get out of your vehicle!" };

if (isNil"_kassa") then { _kassa = 1000 };
if (_rip) exitWith { hint "Robbery already in progress!" };
if (currentWeapon _robber == "") exitWith { hint "You do not threaten me! Get out of here!" };

if !(alive _robber) exitWith {};
if (_kassa == 0) exitWith { hint "There is no cash in the register!" };

_rip = true;
_kassa = 2000 + round(random 3000); // Max Wert der Kasse
_shop removeAction _action;
_shop switchMove "AmovPercMstpSsurWnonDnon";
_chance = random(100);
if(_chance >= 85) then { hint "The cashier hit the silent alarm, police have been alerted!"; [[1,format["ALARM! - Store: %1 is being robbed!", _shop]],"life_fnc_broadcast",west,false] spawn life_fnc_MP; };
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["Robbery in Progress, stay within 5m (1%1)...","%"];
_progress progressSetPosition 0.01;
_cP = 0.01;

if(_rip) then
{
   _rndmrk = random(1000);
   _mrkstring = format ["wrgMarker%1", _rndmrk];
   _Pos = position player; // by ehno: get player pos
   _marker = createMarker [_mrkstring, _Pos]; //by ehno: Place a Marker on the map
   _marker setMarkerColor "ColorRed";
   _marker setMarkerText "!ATTENTION! Robbery in Progress !ATTENTION!";
   _marker setMarkerType "mil_warning";
   [[0,"A store is being robbed!"],"life_fnc_broadcast",true,false] spawn life_fnc_MP; // General broadcast alert to everyone, uncomment for testing, or if you want it anyway.

   while{true} do
   {
      sleep 2.00;
      _cP = _cP + 0.01;
      _progress progressSetPosition _cP;
      _pgText ctrlSetText format["Robbery in Progress, stay within 5m (%1%2)...",round(_cP * 100),"%"];
	  
      if(_cP >= 1 OR !alive _robber) exitWith {};
      if(_robber distance _shop > 5.1) exitWith { };
	  if((_robber getVariable["restrained",false])) exitWith {};
	  if(life_istazed) exitWith {} ;
	  if(life_interrupted) exitWith {};
   };
   
   if!(alive _robber) exitWith { deleteMarker _marker; _rip = false; _shop switchMove ""; 5 cutText ["","PLAIN"];};
   if(_robber distance _shop > 5.1) exitWith { deleteMarker _marker; _shop switchMove ""; hint "You moved away from the register - it has been locked!"; 5 cutText ["","PLAIN"]; _rip = false; [[getPlayerUID _robber,name _robber,"211A"],"life_fnc_wantedAdd",false,false] spawn life_fnc_MP; };
   if(_robber getVariable "restrained") exitWith { deleteMarker _marker; _rip = false; _shop switchMove ""; hint "You were arrested!"; 5 cutText ["","PLAIN"];};
   if(life_istazed) exitWith { deleteMarker _marker; _rip = false; _shop switchMove ""; hint "You were tazed!"; 5 cutText ["","PLAIN"];};
   
   5 cutText ["","PLAIN"];
   titleText[format["You have stolen $%1, now get away before the cops arrive!",[_kassa] call life_fnc_numberText],"PLAIN"];
   deleteMarker _marker; // by ehno delete marker
   EVGA_cash = EVGA_cash + _kassa;

   _rip = false;
   life_use_atm = false;
   sleep (30 + random(180));
   life_use_atm = true;
   [[getPlayerUID _robber,name _robber,"211",_kassa],"life_fnc_wantedAdd",false,false] spawn life_fnc_MP;
};

sleep 1800;
_action = _shop addAction["Rob Cash Register",EVGA_fnc_robShops];
_shop switchMove "";