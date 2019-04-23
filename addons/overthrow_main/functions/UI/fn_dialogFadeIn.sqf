_display = (findDisplay (_this#0));

{
  _x ctrlSetFade 1;
  _x ctrlCommit 0;
}forEach (allControls _display);

{
  _x ctrlSetFade 0;
  _x ctrlCommit 0.25;
}forEach (allControls _display);
