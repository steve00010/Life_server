private["_aa"];
_aa = _this select 0;
if (!isNull _aa) then {
    switch (_this select 1) do {
        case 0:
            {
                [
                    ["unitSpawn", "I_UAV_01_F"], (owner _aa)
                ] call EPOCH_sendPublicVariableClient;
            };
        case 1:
            {
                if (sunOrMoon < 1) then {
                    [
                        ["unitSpawn", "Epoch_Cloak_F"], (owner _aa)
                    ] call EPOCH_sendPublicVariableClient;
                };
            };
        case 2:
            {
                [
                    ["unitSpawn", "Epoch_Sapper_F"], (owner _aa)
                ] call EPOCH_sendPublicVariableClient;
            };
        case 3:
            {
                [
                    ["unitSpawn", "GreatWhite_F"], (owner _aa)
                ] call EPOCH_sendPublicVariableClient;
            };
    };
};