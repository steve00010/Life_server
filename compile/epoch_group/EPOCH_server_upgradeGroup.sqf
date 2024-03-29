private["_groupID", "_player", "_contentArray", "_found", "_newGroupSize", "_groupMemberPUID"];
_groupID = _this select 0;
_player = _this select 1;
if !([_player, _this select 2] call EPOCH_server_getPToken) exitWith {};
diag_log format["GROUP: Upgrade %1", _this];
_response = ["Group", _groupID] call EPOCH_server_hiveGET;
if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY") then {
    _contentArray = (_response select 1);
    _found = EPOCH_group_upgrade_lvl_SEPXVar find(_contentArray select 2);
    if ((_found != -1) && count EPOCH_group_upgrade_lvl_SEPXVar >= (_found + 3)) then {
        _newGroupSize = EPOCH_group_upgrade_lvl_SEPXVar select(_found + 2);
        _contentArray set[2, _newGroupSize];
        _groupMemberPUID = [_groupID]; {
            {
                _groupMemberPUID pushback(_x select 0);
            }
            forEach _x;
        }
        forEach[_contentArray select 3, _contentArray select 4]; {
            if (getPlayerUID _x in _groupMemberPUID) then {
                [
                    ["groupUpdate", _contentArray], (owner _x)
                ] call EPOCH_sendPublicVariableClient;
            };
        }
        forEach playableUnits;
        ["Group", _groupID, _contentArray] call EPOCH_server_hiveSET;
    };
};