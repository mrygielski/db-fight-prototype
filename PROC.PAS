var
   x, y : integer; {pozycje x i y gracza}
   dx, dy : shortint; {pomocnicze pozycje klatki}
   nrklt : byte; {numer klatki}
   ch : byte; {bufor klatek}
   keys : boolean; {czy klawisze s¥ aktywne?}
   pozycja : string; {aktywna pozycja gracza}
   frame : byte; {klatka animacji}
   {pozycje}
   up, down, jump, runl, runr, blokup, blokdown, odsl, odsr : boolean;

procedure status_info(jaki : byte);
begin
     if jaki=0 then
     begin
          printfontxy(2,2,0,'NR KLATKI: '+numstr(nrklt)+' POZYCJA: '+pozycja);
          printfontxy(2,12,0,'DX: '+numstr(dx)+' DY: '+numstr(dy));
          printfontxy(2,22,0,'UP: '+numstrboolean(up)+' DOWN: '
          +numstrboolean(down)+' RUNLEFT: '+numstrboolean(runl)
          +' RUNRIGHT: '+numstrboolean(runr));
          printfontxy(2,32,0,'JUMP: '+numstrboolean(jump)+' ODSKOKLEFT: '+numstrboolean(odsl)+
          ' ODSKOKRIGHT: '+numstrboolean(odsr));
     end;
     if jaki=1 then
     begin
          printfontxy(2,2,15,'NR KLATKI: '+numstr(nrklt)+' POZYCJA: '+pozycja);
          printfontxy(2,12,15,'DX: '+numstr(dx)+' DY: '+numstr(dy));
          printfontxy(2,22,15,'UP: '+numstrboolean(up)+' DOWN: '
          +numstrboolean(down)+' RUNLEFT: '+numstrboolean(runl)
          +' RUNRIGHT: '+numstrboolean(runr));
          printfontxy(2,32,15,'JUMP: '+numstrboolean(jump)+' ODSKOKLEFT: '+numstrboolean(odsl)+
          ' ODSKOKRIGHT: '+numstrboolean(odsr));
     end;
end;

procedure animacja(od_, do_ : byte; wait : byte);
var
   r : byte;
begin
     r:=od_;
     status_info(1);
     repeat
           r:=r+1;
           frame:=r;
           rysuj_gracza(x+dx,y+dy,r);
           pokazgrafike2;
           bar(x+dx,y+dy,dx+x+35,dy+y+50,0);
           czekaj(wait);
     until r=do_;
end;

procedure animacja_fali;
var
   r : integer;
begin
     animacja(9,12,200);
     rysuj_gracza(x+35+dx-4,y+dy-8,13);
     czekaj(500);
     r:=0;
     repeat
           rysuj_gracza(x+dx,y+dy,12);
           r:=r+5;
           rysuj_gracza(x+r+40+dx+20,y+dy-6,14);
           pokazgrafike2;
     until r>320;
     czekaj(800);
     bar(x,y,320,y+60,0);
end;

procedure animacja_kuli;
var
   r : integer;
begin
     animacja(14,16,200);
     czekaj(100);
     r:=0;
     repeat
           rysuj_gracza(x+dx,y+dy,16);
           r:=r+2;
           rysuj_gracza(x+r+20+dx+10,y+dy-10,36);
           pokazgrafike2;
           bar(x+r+15+dx+10,y+dy+10,x+25+r+20+dx+25+10,y+dy+25,0);
     until r>270;
     czekaj(200);
     bar(x,y,320,y+60,0);
end;

procedure skok;
var
   r : byte; {zmienna pomocnicza}
   klt : byte; {klatki}
begin
     pozycja:='JUMP';
     status_info(1);
     r:=y;
     klt:=9;
     repeat
           rysuj_gracza(x+dx,y+dy,klt);
           y:=y-1;
           {PORUSZANIE PRAWO}
           if keys and keydown[rightscan] then
           begin
                x:=x+1;
           end;
           {PORUSZANIE LEWO}
           if keys and keydown[leftscan] then
           begin
                x:=x-1;
           end;
           {R¨KA}
           if keys and keydown[scanof('q')] then
           begin
                klt:=28;
           end;
           {NOGA}
           if keys and keydown[scanof('w')] then
           begin
                klt:=30;
           end;
           pokazgrafike2;
           bar(x+dx,y+dy,x+35+dx,y+50+dy,0);
           czekaj(5);
     until y=r-70;
     r:=y;
     repeat
           rysuj_gracza(x+dx,y+dy,klt);
           y:=y+1;
           {PORUSZANIE PRAWO}
           if keys and keydown[rightscan] then
           begin
                x:=x+1;
           end;
           {PORUSZANIE LEWO}
           if keys and keydown[leftscan] then
           begin
                x:=x-1;
           end;
           {R¨KA}
           if keys and keydown[scanof('q')] then
           begin
                klt:=28;
           end;
           {NOGA}
           if keys and keydown[scanof('w')] then
           begin
                klt:=30;
           end;
           pokazgrafike2;
           bar(x+dx,y+dy,x+35+dx,y+50+dy,0);
           czekaj(3);
     until y=r+70;
end;

procedure dostal_lekko;
var
   kx : integer;
   klt : byte; {klatki}
begin
     pozycja:='DOSTAL LEKKO';
     status_info(1);
     klt:=9;
     kx:=300;
     repeat
           rysuj_gracza(x+dx,y+dy,nrklt);
           kx:=kx-1;
           rysuj_gracza(kx+dx,y+dy,36);
           pokazgrafike2;
           bar(kx+4+dx,y+22+dy,kx+23+dx,y+30+dy,0);
     until (kx>x-20) and (kx<x+20);
     bar(x+dx,y+dy,dx+x+35,dy+y+50,0);
     if up then animacja(30,32,100);
     if down then animacja(32,33,100);
     rysuj_gracza(x+dx,y+dy,35);
     czekaj(200);
     bar(x+dx,y+dy,dx+x+35,dy+y+50,0);
end;

procedure dostal_mocno;
var
   kx : integer;
   klt : byte; {klatki}
begin
     pozycja:='DOSTAL MOCNO';
     status_info(1);
     klt:=9;
     kx:=300;
     repeat
           rysuj_gracza(x+dx,y+dy,nrklt);
           kx:=kx-1;
           rysuj_gracza(kx+dx,y+dy,36);
           pokazgrafike2;
           bar(kx+4+dx,y+22+dy,kx+23+dx,y+30+dy,0);
     until (kx>x-20) and (kx<x+20);
     bar(x+dx,y+dy,dx+x+35,dy+y+50,0);
     if up then animacja(30,35,100);
     if down then animacja(32,35,100);
     rysuj_gracza(x+dx,y+dy,35);
     czekaj(200);
     bar(x+dx,y+dy,dx+x+35,dy+y+50,0);
end;

