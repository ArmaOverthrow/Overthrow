diag_log "Overthrow: Pre-Init";

private _center = createCenter sideLogic;
private _group = createGroup _center;

server = _group createUnit ["LOGIC",[0,0,0] , [], 0, ""];
cost = _group createUnit ["LOGIC",[1,0,0] , [], 0, ""];
warehouse = _group createUnit ["LOGIC",[2,0,0] , [], 0, ""];
spawner = _group createUnit ["LOGIC",[3,0,0] , [], 0, ""];
templates = _group createUnit ["LOGIC",[4,0,0] , [], 0, ""];

if(isServer) then {
    server setVariable ["StartupType","",true];
    diag_log "Overthrow: Server Pre-Init";
};
