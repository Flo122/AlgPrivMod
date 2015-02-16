/*
	Master Life Configuration File
	This file is to setup variables for the client, there are still other configuration files in the system

*****************************
****** Backend Variables *****
*****************************
*/
_handle = [] spawn compile PreprocessFileLineNumbers "core\EVGA\gambling\configuration.sqf";
diag_log "::EVGA Client:: Initialization Variables gambling";
waitUntil {scriptDone _handle};

_handle = [] spawn compile PreprocessFileLineNumbers "core\EVGA\gambling\functions.sqf";
diag_log "::EVGA Client:: Initialization Functions gambling";
waitUntil {scriptDone _handle};


