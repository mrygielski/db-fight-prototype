Uses FGraphb;
Var P:Tpaleta;
    pl:String;
    x,y:integer;
Begin
     pl:='players\goku\34';
     initfgraph;
     loadPaintFile(11,99,pl+'.gfx',1);
     movebuf2screen;
     SaveAsPaintFile(10,100,44,148,pl+'a.gfx',1);
     movebuf2screen;
     readln;
     closefgraph;
End.