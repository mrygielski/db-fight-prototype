
uses supergfx, help2, games;

{$I game_dat.pas}
{$I abc.pas}
{$I proc.pas}

begin
zarezerwuj_pamiec;
initgfx13h;
zaladuj_postac('goku.dat');
initnewkeyint;
nrklt:=1;
ch:=nrklt;
x:=60;
y:=120;
keys:=true;
up:=true;
down:=false;
jump:=false;
runl:=false;
runr:=false;
blokup:=false;
blokdown:=false;
odsl:=false;
odsr:=false;
repeat
      rysuj_gracza(x+dx,y+dy,nrklt);
      status_info(1);
      pokazgrafike2;
      status_info(0);
      czekaj(70);
      bar(x+dx,y+dy,dx+x+35,dy+y+50,0);
      {POZYCJE GRACZA}
      if nrklt in[1,2,3] then begin pozycja:='UP'; up:=true; end else up:=false;
      if nrklt=4 then begin pozycja:='DOWN'; down:=true; end else down:=false;
      if nrklt=5 then begin pozycja:='BLOKUO'; blokup:=true; up:=true; end else blokup:=false;
      {PORUSZANIE PRAWO}
      if keys and keydown[rightscan] and not down and not blokup and not blokdown and not odsr and not odsl then
      begin
           runr:=true;
           x:=x+5;
           nrklt:=nrklt+1;
           if nrklt=4 then nrklt:=1;
           ch:=nrklt;
      end else runr:=false;
      {PORUSZANIE LEWO}
      if keys and keydown[leftscan] and not down and not blokup and not blokdown and not odsr and not odsl  then
      begin
           runl:=true;
           x:=x-5;
           nrklt:=nrklt-1;
           if nrklt=0 then nrklt:=3;
           ch:=nrklt;
      end else runl:=false;
      {PORUSZANIE D‡ù}
      if keys and keydown[downscan] then
      begin
           nrklt:=4;
           {BLOK DOWN}
           if keydown[tabscan] then
           begin
                pozycja:='BLOKDOWN';
                blokdown:=true;
                nrklt:=6;
           end else begin blokdown:=false; end;
      end else nrklt:=ch;
      {SKOK}
      if keys and keydown[upscan] then
      begin
           skok;
      end;
      {BLOK UP}
      if keys and up and keydown[tabscan] then
      begin
           nrklt:=5;
      end;
      {ODSKOK PRAWO}
      if keys and not down and keydown[scanof('s')] and not odsl then
      begin
           pozycja:='ODSKOKPRAWO';
           odsr:=true;
           up:=true;
           x:=x+10;
           nrklt:=18;
      end else odsr:=false;
      {ODSKOK LEWO}
      if keys and not down and keydown[scanof('a')] and not odsr then
      begin
           pozycja:='ODSKOKLEWO';
           odsl:=true;
           up:=true;
           x:=x-10;
           nrklt:=17;
      end else odsl:=false;
      {*CIOSY*}
      {REKA UP}
      if keys and up and keydown[scanof('q')] then
      begin
           pozycja:='REKAUP';
           animacja(18,20,200);
      end;
      {R®KA DOWN}
      if keys and down and keydown[scanof('q')] then
      begin
           pozycja:='REKADOWN';
           animacja(22,24,200);
      end;
      {NOGA UP}
      if keys and up and keydown[scanof('w')] then
      begin
           pozycja:='NOGAUP';
           animacja(20,22,200);
      end;
      {NOGA DOWN}
      if keys and down and keydown[scanof('w')] then
      begin
           pozycja:='NOGADOWN';
           animacja(24,26,200);
      end;
      {FALA}
      if keys and up and keydown[scanof('e')] then
      begin
           pozycja:='KAMEHAMEHA';
           animacja_fali;
      end;
      {KULA}
      if keys and up and keydown[scanof('d')] then
      begin
           pozycja:='KULA';
           animacja_kuli;
      end;
      {ENERGIA}
      if keys and up and keydown[scanof(' ')] then
      begin
           pozycja:='ENERGIA';
           animacja(6,8,200);
           repeat until not keydown[scanof(' ')];
      end;
      {DOSTAù}
      if keys and keydown[insscan] then
      begin
           dostal_lekko;
      end;
      if keys and keydown[delscan] then
      begin
           dostal_mocno;
      end;
until keydown[escscan];
setoldkeyint;
closegfx13h;
wywal_z_pamieci;
end.