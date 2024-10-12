restore, 'fig1_pna.sav'

pnamean = mean(pna)
pnastd = stddev(pna)

nt = n_elements(pna)
pnahigh = fltarr(nt)
pnalow = fltarr(nt)

for it = 0, nt-1 do begin
pnahigh(it) = pnamean +1.5*pnastd
pnalow(it)  = pnamean -1.5*pnastd
endfor

psfile = 'fig1_pna.ps'
set_plot,'ps'
device,/landscape, file=psfile, /color
device,/inches,xsize=9.0,xoffset=0.8,yoffset=10.0,ysize=7.0
!P.Multi=[0,1,2]
!X.thick = 4
!Y.thick = 4
!P.thick = 4
red = [0, 1, 1, 0, 0, 1]
green = [0, 1, 0, 1, 0, 1]
blue = [0, 1, 0, 0, 1, 0]
tvlct, 255*red, 255*green, 255*blue

plot, time, /NODATA, $
xrange = [min(time), max(time)], /xstyle, $
yrange = [-3., 3.], /ystyle, $
xtitle = 'Time', ytitle = 'PNA Index', $
charsize=1.3, charthick=3, title = ttl, $
pos = [0.1, 0.4, 0.8, 0.9]
oplot, time, pna, color = 2
oplot, time, pnahigh, linestyle=2
oplot, time, pnalow, linestyle=2
device,/close
set_plot,'x'

end
