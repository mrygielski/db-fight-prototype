
uses help13h, help2;

type
    tablica = array[1..36, 1..36, 1..50] of byte;

var
   p : ^tablica;
   f : file of tablica;

procedure zarezerwuj_pamiec;
var
   i : byte;
begin
     new(p);
end;

procedure wywal_z_pamieci;
var
   i : byte;
begin
     dispose(p);
end;

procedure openfile(plik : string; nrklt, tlo : byte);

var
   f : file;
   b, rx, ry : byte;
   xx, yy : integer;
   buf : array[1..321] of byte;
   w, d : word;

begin
     assign(f,plik);
     reset(F,1);
     blockread(f,buf,2,w);
     rx:=buf[1];
     ry:=buf[2];
     for yy:=1 to ry do
     begin
          blockread(f,buf,rx,w);
          for xx:=1 to rx do p^[nrklt][xx,yy]:=buf[xx];
     end;
     close(F);
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
{chodzenie}
openfile('players\goku\1.gfx',1,255);
openfile('players\goku\5.gfx',2,255);
openfile('players\goku\4.gfx',3,255);
{kucanie}
openfile('players\goku\2.gfx',4,255);
{blokowanie g¢ra}
openfile('players\goku\6.gfx',5,255);
{blokowanie d¢ˆ}
openfile('players\goku\34.gfx',6,255);
{energia}
openfile('players\goku\7.gfx',7,255);
openfile('players\goku\8.gfx',8,255);
{spadanie ze skoku}
openfile('players\goku\10.gfx',9,255);
{fala}
openfile('players\goku\11.gfx',10,255);
openfile('players\goku\12.gfx',11,255);
openfile('players\goku\13.gfx',12,255);
{animacje fali}
openfile('players\goku\14.gfx',13,255);
openfile('players\goku\15.gfx',14,255);
{zwykˆa kula}
openfile('players\goku\17.gfx',15,255);
openfile('players\goku\18.gfx',16,255);
{odskok do tyˆu}
openfile('players\goku\19.gfx',17,255);
{odskok do przodu}
openfile('players\goku\20.gfx',18,255);
{uderzenie r©k¥}
openfile('players\goku\21.gfx',19,255);
openfile('players\goku\22.gfx',20,255);
{kopniak}
openfile('players\goku\23.gfx',21,255);
openfile('players\goku\24.gfx',22,255);
{ude¾enie r©k¥ kucaj¥c}
openfile('players\goku\25.gfx',23,255);
openfile('players\goku\26.gfx',24,255);
{w˜lizg}
openfile('players\goku\27.gfx',25,255);
openfile('players\goku\28.gfx',26,255);
{ude¾enie r©k¥ w powietrzu}
openfile('players\goku\29.gfx',27,255);
openfile('players\goku\30.gfx',28,255);
{kopniak w powietrzu}
openfile('players\goku\31.gfx',29,255);
openfile('players\goku\32.gfx',30,255);
{dostaˆ lekko}
openfile('players\goku\35.gfx',31,255);
{dostaˆ mocno}
openfile('players\goku\36.gfx',32,255);
openfile('players\goku\37.gfx',33,255);
openfile('players\goku\38.gfx',34,255);
openfile('players\goku\39.gfx',35,255);
{kula}
openfile('players\goku\16.gfx',36,255);

bar13h(5,5,315,195,1);
rysuj_gracza(0,60,1);
rysuj_gracza(40,60,2);
rysuj_gracza(80,60,3);
rysuj_gracza(120,60,4);
rysuj_gracza(160,60,5);
rysuj_gracza(200,60,6);
rysuj_gracza(240,60,7);
rysuj_gracza(280,60,8);
assign(f,'goku.dat');
rewrite(f);
write(f,p^);
close(f);
readln;
close13h;
wywal_z_pamieci;
end.