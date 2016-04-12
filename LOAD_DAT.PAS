
uses help13h, help2;

type
    tablica = array[1..35, 1..36, 1..50] of byte;

var
   p : ^tablica;
   f : file of tablica;

procedure zarezerwuj_pamiec;
begin
     new(p);
end;

procedure wywal_z_pamieci;
begin
     dispose(p);
end;

procedure rysuj_gracza(x, y : integer; nrklt : byte);
var
   i, j : integer;
begin
     for i:= 1 to 35 do
     for j:= 1 to 49 do
     begin
          if p^[nrklt][i,j]<>255 then putpixel13h(i+x,j+y,p^[nrklt][i,j]);
     end;
end;

begin
zarezerwuj_pamiec;
init13h;
assign(f,'goku.dat');
reset(f);
read(f,p^);
close(f);
bar13h(5,5,315,195,1);
rysuj_gracza(0,60,12);
rysuj_gracza(40,60,2);
rysuj_gracza(80,60,3);
rysuj_gracza(120,60,4);
rysuj_gracza(160,60,5);
readln;
close13h;
wywal_z_pamieci;
end.