speedo = 5; 
_dir = direction (_this select 0);
while {true} do {
	(_this select 0) setVelocity [-((speedo/3)*(sin _dir)), -((speedo/3)*(cos _dir)), 0];
	sleep 0.1;
}