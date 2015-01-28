/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	When a client disconnects this will remove their corpse and
	clean up their storage boxes in their house.
*/
private["_unit","_id","_uid","_name","_playerIsDead"];
_unit = _this select 0;
_id = _this select 1;
_uid = _this select 2;
_name = _this select 3;
if(isNull _unit) exitWith {};
[_uid,0] spawn life_fnc_wantedRemoveLocally;
[_uid,0] spawn life_fnc_setOnline;
_playerIsDead = alive _unit;
_containers = nearestObjects[_unit,["WeaponHolderSimulated"],5];
{deleteVehicle _x;} foreach _containers;
deleteVehicle _unit;

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
} else {
	diag_log format["Player %1 (%2) disconnected while dead!",_name,_uid];
	_query = format["Update PLAYERS set civ_gear ='""[]""' where pid='%1'",_uid];
	waitUntil {sleep (random 0.3); !DB_Async_Active};
	_queryResult = [_query,1] call DB_fnc_asyncCall;
};

_uid spawn TON_fnc_houseCleanup;

//Diag_log Format["Client Disconnect (%1) : Completed", _uid];