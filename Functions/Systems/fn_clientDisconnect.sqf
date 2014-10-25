/*
	File: fn_clientDisconnect.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	When a player disconnect it goes through the all the dead bodies
	and removes bodies owned by the server. This is built for the new
	medical / EMS system.
*/

private["_playerIsDead","_loopcount"];

//Diag_log Format["Client Disconnect (%1) : %2 Dead Bodies", _uid, count allDeadMen];

_playerIsDead = false;

{
	_pid = _x getVariable["steam64ID","Unknown"];
	//Diag_log format[ "Client Disconnect (%1) : PlayerID of Dead Body is %2", _uid, _pid];
	//Diag_log format[ "Client Disconnect (%1) : Variable Check (Revive %2)", _uid, _x getVariable["Revive","Unknown"]];
	//if(_uid == _pid OR _pid == "") then {
	if( _pid == _uid ) then 
	{
		_playerIsDead = true;
		_containers = nearestObjects[_x,["WeaponHolderSimulated"],5]; //Fetch list of containers (Simulated = weapons)
		{deleteVehicle _x;} foreach _containers; //Delete the containers.
		deleteVehicle _x; //Get rid of the corpse.
	};
} foreach allDeadMen;

if (!_playerIsDead) then
{
	[_uid] spawn
	{
		{
			_pid = _x getVariable["steam64ID","Unknown"];
			
			if (_pid == "Unknown") then
			{
				_pid = getPlayerUID _x;
			};
			
			//Diag_log format[ "Client Disconnect (%1) : PlayerID of Alive unit is %2 with name %3 and built in PlayerID of %4", _this select 0, _pid, _x getVariable["realname",name _x], getPlayerUID _x];
			if( _pid == _this select 0 ) then 
			{
				// Player isnt dead when logging off so remove dropped weapon.
				_loopcount = 0;
				
				while {_loopcount < 3} do
				{
					//Diag_log format[ "Client Disconnect (%1) : Deleting Weapons within 5 meters",  _this select 0];
					
					_x removeWeapon (primaryWeapon _x);
					_x removeWeapon (handGunWeapon _x);
					
					_pos = getpos _x;
					
					{ 
						deleteVehicle _x; 
					} forEach nearestObjects [_pos, ["GroundWeaponHolder"], 5]; 
					
					{ 
						deleteVehicle _x; 
					} forEach nearestObjects [_pos, ["WeaponHolderSimulated"], 5];
					
					_loopcount = _loopcount + 1;
					
					sleep 0.5;
				};
			};
		} foreach playableUnits;
	};
};

_uid spawn TON_fnc_houseCleanup;

//Diag_log Format["Client Disconnect (%1) : Completed", _uid];