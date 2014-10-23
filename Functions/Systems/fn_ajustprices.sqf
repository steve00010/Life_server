/*
File: fn_ajustprices.sqf
Author: worldtrade1101
Edited: ibllaclk,nark0t1k
Description:
Sends a request to update and adjust the price of stuff in the DB.
*/
//[[0,player,life_shop_type,_amount,_price,_var],"life_fnc_Adjustprices",false,false] spawn life_fnc_MP;
private["_type","_data","_unit","_tickTime","_queryResult","_var","_price","_amount","_randomnumber","_group","_type","_sellingfactor","_queryArray","_AllOk","_ressource","_buyprice","_query","_sellprice","_varprice","_minprice","_maxprice"];
_type = [_this,0,0,[0]] call BIS_fnc_param;
_unit = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param;
_data = [_this,2,"",[""]] call BIS_fnc_param;
_amount = [_this,3,0,[0]] call BIS_fnc_param;
_price = [_this,4,0,[0]] call BIS_fnc_param;
_var = [_this,5,"",[""]] call BIS_fnc_param;

//Error checks
diag_log format ["%1   %2    %3    %4      %5      %6",_unit,_type,_data,_amount,_price,_var];
if( (_data == "") OR (isNull _unit)) exitWith
{
diag_log "data ou type ou unit null";
};

_unit = owner _unit; //for hack purpose!

//we randomize the thing to not update every single transaction
//_randomnumber = random 100;

//if (_randomnumber < 60) then { diag_log "This transaction doesn't update the price!"};

//we check the factor of the object
_query = format["SELECT factor FROM economy WHERE ressource='%1'",_var];

//if (!DB_Async_Active) then {
    waitUntil{sleep (random 0.3); !DB_Async_Active};
    _tickTime = diag_tickTime;
    _queryResult = [_query,2,true] call DB_fnc_asyncCall;
    diag_log "------------- Client Query Request -------------";
    diag_log format["QUERY: %1",_query];
    diag_log format["Time to complete: %1 (in seconds)",(diag_tickTime - _tickTime)];
    diag_log format["Result: %1",_queryResult];
    diag_log "------------------------------------------------";

    if(isNil "_queryResult") exitWith { diag_log "The QUERY was empty"};

    _factor = ((_queryResult select 0) select 0);
    _query = format["SELECT ressource, buyprice, sellprice, varprice, minprice, maxprice FROM economy WHERE factor='%1'",_factor];

    /*if(_query == "Error") exitWith {
    diag_log "error";
    };*/
    
    waitUntil{sleep (random 0.3); !DB_Async_Active};
    _tickTime = diag_tickTime;
    _queryResult = [_query,2,true] call DB_fnc_asyncCall;

    diag_log "------------- Client Query Request -------------";
    diag_log format["QUERY: %1",_query];
    diag_log format["Time to complete: %1 (in seconds)",(diag_tickTime - _tickTime)];
    diag_log format["Result: %1",_queryResult];
    diag_log "------------------------------------------------";


    _sellingfactor =((count _queryResult)-1);
    _query ="";
    _queryArray = [];
    _AllOk = TRUE;

    {
    //diag_log format ["test : %1 (%2)", _this , typeName _this];
    //diag_log format ["var : %1 (%2)", _var , typeName _var];
    _ressource = _x select 0;
    //diag_log format ["ressource : %1 (%2)", _ressource  , typeName _ressource ];
    _buyprice =  (_x select 1);
    _sellprice =  (_x select 2);
    _varprice =  (_x select 3);
    _minprice = (_x select 4);
    _maxprice = (_x select 5);

    if (_ressource == _var) then { 
        if (_type == 0) then { // if we sell the item
            if (_buyprice != 0) then {if( (_buyprice - (_varprice * _amount)) > _minprice) then {_buyprice= _buyprice - (_varprice * _amount);}else {_allOk = false;};};
            if ((_sellprice - (_varprice * _amount *_sellingfactor)) > _minprice) then {_sellprice = _sellprice - (_varprice * _amount *_sellingfactor);}else {_allOk = false;};
            if (_buyprice != 0) then {if ((_sellprice >= _buyprice)) then {_buyprice=_sellprice + 15};};
        } else { // if you buy the item
            if (_buyprice != 0) then {if( (_buyprice + (_varprice * _amount)) < (_maxprice+15)) then {_buyprice = _buyprice + (_varprice * _amount);}else {_allOk = false;};};
            if ((_sellprice + (_varprice * _amount)) < _maxprice) then {_sellprice = _sellprice + (_varprice * _amount);}else {_allOk = false;};
        };
    } else {
        if (_type == 0) then { //if we sold another item you raise the price
            if (_buyprice != 0) then {if( (_buyprice + (_varprice * _amount)) < (_maxprice)) then {_buyprice = _buyprice + (_varprice * _amount);}else {_allOk = false;};};
            if ((_sellprice + (_varprice * _amount)) < _maxprice) then {_sellprice = _sellprice + (_varprice * _amount);} else {_allOk = false;};
        } else { // if you buy another item we lower the price
            if (_buyprice != 0) then {if( (_buyprice - (_varprice * _amount)) > _minprice ) then {_buyprice= _buyprice - (_varprice * _amount);} else {_allOk = false;};};
            if ((_sellprice - (_varprice * _amount)) > _minprice) then {_sellprice = _sellprice - (_varprice * _amount);}else {_allOk = false;};
        };
    };
    _query =format["UPDATE economy SET buyprice='%1', sellprice='%2' WHERE ressource='%3'",_buyprice,_sellprice,_ressource];
    _queryArray set [count _queryArray,_query];

    }foreach _queryResult;
    if (_AllOk) then { //We update the price
        {
        waitUntil {sleep (random 0.3); !DB_Async_Active};
        _queryResult = [_x,1] call DB_fnc_asyncCall;
        diag_log "------------- Client Query Request -------------";
        diag_log format["QUERY: %1",_x];
        diag_log format["Time to complete: %1 (in seconds)",(diag_tickTime - _tickTime)];
        diag_log format["Result: %1",_queryResult];
        diag_log "------------------------------------------------";
        }foreach _queryArray;
    };
//};
//} else { diag_log "This transaction doesn't update the price!"};