type
    tablica = array[1..36, 1..36, 1..50] of byte;

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
          if p^[nrklt][i,j]<>255 then putpixel(i+x,j+y,p^[nrklt][i,j]);
     end;
end;

procedure zaladuj_postac(filename : string);
begin
     assign(f,filename);
     reset(f);
     read(f,p^);
     close(f);
end;
