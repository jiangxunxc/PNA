restore, 'co2pna.sav'

xs = size(co2pna)
nlon = xs(1)
nlat = xs(2)

mrng = [20., 190., 64., 305.]

psfile = 'fig2_co2.ps'
set_plot,'ps'
device,/landscape, file=psfile, /color
device,/inches,xsize=9.0,xoffset=0.8,yoffset=10.0,ysize=7.0
!P.Multi=[0,2,2]
!X.thick = 4
!Y.thick = 4
!P.thick = 4
loadct, 39

colorflg = 1
if(colorflg eq 1) then rainbow $
else white_black

xpos = [0.,   0.43, 0.57,   1., 0., 0.43, 0.57, 1.]
ypos = [0.53, 0.97, 0.53, 0.97, 0., 0.43, 0., 0.43]

cpos = [10180.2, 9313.16, 502.97, 381.048, 23134.6, 9313.16, 502.970, 381.048, $
        10180.2, -150., 502.970, 372.581, 23134.6, 78.2319, 502.97, 372.581]

xttls = ['Longitude', 'Longitude', 'Longitude', 'Longitude']
yttls = ['Latitude', '', 'Latitude', '']
ttls  = ['(a)', '(b)', '(c)', '(d)']
cttls = ['ppm', 'ppm', 'ppm', 'Ratio']

for ii = 0, 2 do begin
if(ii eq 0) then begin
eof1 = pnahigh
nlvls = 20
maxval = 1.5 
minval = -1.5 
pttl = ''
endif

if(ii eq 1) then begin
eof1 = pnalow
nlvls = 20
maxval = 1.5 
minval = -1.5
pttl = ''
endif

if(ii eq 2) then begin
eof1 = pnadiff
nlvls = 20
maxval = 1.5 
minval = -1.5 
pttl = ''
endif

eof1(where(eof1 ge maxval)) = maxval - 0.01
eof1(where(eof1 le minval and eof1 ne -999.)) = minval + 0.01

rlevl = (maxval-minval)/float(nlvls)
valrng = maxval - minval
lvls   = findgen(nlvls+1)*rlevl + minval
col_v=(findgen(nlvls+1)/nlvls)*(253)

  data = eof1

  sbttl = ''
  
  rlow = minval
  rhigh = max(lvls)
;
  contour, data, lon, lat, /cell_fill, $
      xrange=[190., 305.], xstyle=1, xtitle=xttls(ii), $
      yrange=[20., 64.], ystyle=1, ytitle=yttls(ii), $
      levels = lvls, pos=[xpos(ii*2),ypos(ii*2),xpos(ii*2+1),ypos(ii*2+1)], c_linestyle= (lvls LT 0.0), /follow, $
      color=255,subtitle=sbttl, charthick = 3, charsize = 1.1
;      
  map_set, 0, 180, 0, /continent,/cyl,/noborder, title =' ',$
      /noerase, charsize=1.1, $
      limit = mrng, pos=[xpos(ii*2),ypos(ii*2),xpos(ii*2+1),ypos(ii*2+1)], color=255
  map_continents,/coasts, /USA, mlinethick=1, color=255

  xyouts, /data, 195., 65., ttls(ii), color=255, charsize=1.1, charthick=3
 
  px = [0.09, 0.92]
  py = [0.4, 0.96]

  px = !x.window*!d.x_vsize
  py = !y.window*!d.y_vsize
  sx = px[1] - px[0] + 1
  sy = py[1] - py[0] + 1
  stepx=0.025*sx
  stepy=sy/(nlvls+1)

  x0=px(1)+0.03*sx
  y0=py(1)-0.58*py(1)

  x0=cpos(ii*4)
  y0=cpos(ii*4+1)
  stepx=cpos(ii*4+2)
  stepy=cpos(ii*4+3)

 cbar,/device,x0,y0,stepx,stepy,lev=lvls,col_v=col_v,unit=cttls(ii),/vert,/border,istep=2

endfor

device,/close
set_plot,'x'

end
