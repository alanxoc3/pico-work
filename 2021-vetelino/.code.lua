g_act_arrs={}
function create_parent_actor_shared(is_create_parent,meta_and_att_str,...)
local meta,template=unpack(split(meta_and_att_str,"|"))
local template_params,id,provided,parents,pause_funcs={...},unpack(ztable(meta))
_g[id]=function(...)
local func_params,params,a={...},tabcpy(template_params),{}
if is_create_parent then
a=deli(func_params,1)
end
for i=1,provided do
add(params,func_params[i]or false,i)
end
if not a[id]then
foreach(parents,function(par)
if type(par)~="table"then
par={par}
end
a=_g[par[1]](a,unpack(par,2))
end)
tabcpy(ztable(template,unpack(params)),a)
if not a[id]then
g_act_arrs[id]=g_act_arrs[id]or{}
add(g_act_arrs[id],a)
end
a.id,a[id],a.pause=id,true,a.pause or{}
foreach(pause_funcs,function(f)
a.pause[f]=true
end)
end
call_not_nil(a,"create_init",a)
return a
end
end
function create_parent(...)create_parent_actor_shared(true,...)end
function create_actor(...)create_parent_actor_shared(false,...)end
function acts_loop(id,func_name,...)
for a in all(g_act_arrs[id])do
call_not_nil(a,func_name,a,...)
end
end
_g={}
function zsfx(num,sub_num)
sfx(num,-1,sub_num*4,4)
end
function btn_helper(f,a,b)
return f(a)and f(b)and 0 or f(a)and 0xffff or f(b)and 1 or 0
end
function _g.plus(a,b)return a+b end
function _g.minus(a,b)return a-b end
function bool_to_num(condition)return condition and 0xffff or 1 end
function get(a,...)
local arr,cur_act=ztable(...),a or{}
for i=1,#arr do
cur_act=cur_act[arr[i]]
if not cur_act then
break
end
end
return cur_act
end
function xbtn()return btn_helper(btn,0,1)end
function ybtn()return btn_helper(btn,2,3)end
function xbtnp()return btn_helper(btnp,0,1)end
function ybtnp()return btn_helper(btnp,2,3)end
function zsgn(num)return num==0 and 0 or sgn(num)end
function round(num)return flr(num+.5)end
function rnd_one(val)return(flr_rnd"3"-1)*(val or 1)end
function ti(period,length)
return t()%period<length
end
function flr_rnd(x)
return flr(rnd(x))
end
function rnd_item(list)
return list[flr_rnd(#list)+1]
end
function tabcpy(src,dest)
dest=dest or{}
for k,v in pairs(src or{})do
if type(v)=="table"and not v.is_tabcpy_disabled then
dest[k]=tabcpy(v)
else
dest[k]=v
end
end
return dest
end
function call_not_nil(table,key,...)
if table and table[key]then
return table[key](...)
end
end
function batch_call_table(func,tbl)
foreach(tbl,function(t)func(unpack(t))end)
end
function batch_call_new(func,...)
batch_call_table(func,ztable(...))
end
function tl_node(a)
a.tl_cur=a.tl_cur or 1
if not a.tl_continued then
a.next=function()
if a.tl_loop then
a.tl_next=(a.tl_cur%#a)+1
else
a.tl_next=a.tl_cur+1
end
end
a.tl_tim,a.tl_max_time,a.tl_continued=0,nil,true
tabcpy(a[a.tl_cur]or{},a)
call_not_nil(a,"i",a)
end
if call_not_nil(a,"u",a)then a:next()end
a.tl_tim+=1/60
if a.tl_max_time and a.tl_tim>=a.tl_max_time then
a:next()
end
if a.tl_next then
local old_tl_next=a.tl_next
a.tl_cur,a.tl_continued,a.tl_next=old_tl_next,nil,nil
call_not_nil(a,"e",a)
return old_tl_next>#a or old_tl_next<1
end
end
function isorty(t)
if t then
for n=2,#t do
local i=n
while i>1 and t[i].y<t[i-1].y do
t[i],t[i-1]=t[i-1],t[i]
i=i-1
end
end
end
end
function tostring(any)
if type(any)~="table"then return tostr(any)end
local str="{"
for k,v in pairs(any)do
if str~="{"then str=str.."," end
str=str..tostring(k).."="..tostring(v)
end
return str.."}"
end
function amov_to_actor(a1,a2,spd,off_x,off_y)
off_x=off_x or 0
off_y=off_y or 0
if a1 and a2 then
amov_to_point(a1,spd,a2.x+off_x,a2.y+off_y)
end
end
function amov_to_point(a,spd,x,y)
local ang=atan2(x-a.x,y-a.y)
a.ax,a.ay=spd*cos(ang),spd*sin(ang)
end
function amov_y(a,spd,y)
local diff=y-a.y
local dy=zsgn(diff)*spd
local _,next_y=a:calc_next_pos(0,dy)
if zsgn(y-next_y)!=zsgn(diff)then
a.ay=-a.dy+diff/a.iy
else
a.ay=dy
end
end
function do_actors_intersect(a,b)
return a and b
and abs(a.x-b.x)<a.rx+b.rx
and abs(a.y-b.y)<a.ry+b.ry
end
function does_a_contain_b(a,b)
return a and b
and b.x-b.rx>=a.x-a.rx
and b.x+b.rx<=a.x+a.rx
and b.y-b.ry>=a.y-a.ry
and b.y+b.ry<=a.y+a.ry
end
function coll_tile_help(pos,per,spd,pos_rad,per_rad,dir,a,hit_func,solid_func)
local coll_tile_bounds=function(pos,rad)
return flr(pos-rad),-flr(-(pos+rad))-1
end
local pos_min,pos_max=coll_tile_bounds(pos+spd,pos_rad)
local per_min,per_max=coll_tile_bounds(per,per_rad)
for j=per_min,per_max do
if spd<0 and solid_func(pos_min,j)then
hit_func(a,dir)
return pos_min+pos_rad+1,0
elseif spd>0 and solid_func(pos_max,j)then
hit_func(a,dir+1)
return pos_max-pos_rad,0
end
end
return pos,spd
end
g_gunvals=split("@1,@2,!plus/@3/1,@5;@1,@2,@3,@4;|0x8000,0x8000,0x7fff,0x7fff,@1|!plus/@1/-2,!plus/@2/-2,!plus/@3/2,!plus/@4/2,13;!plus/@1/-1,!plus/@2/-1,!plus/@3/1,!plus/@4/1,1;|0,0,0,0,0,0,0;1,1,1,0,0,0,0;2,2,2,1,0,0,0;3,3,3,1,0,0,0;4,2,2,2,1,0,0;5,5,1,1,1,0,0;6,13,13,5,5,1,0;7,6,13,13,5,1,0;8,8,2,2,2,0,0;9,4,4,4,5,0,0;10,9,4,4,5,5,0;11,3,3,3,3,0,0;12,12,3,1,1,1,0;13,5,5,1,1,1,0;14,13,4,2,2,1,0;15,13,13,5,5,1,0;|fader_out;3;act,;update,|fade_time:@1;i:@2;e:@3;u:@4;tl_max_time=@1,|fader_in;3;act,;update,||act;0;,;room_init,pause_init,pause_update,pause_end,kill,clean,delete|alive:yes;stun_countdown:0;i:nf;u:nf;update:@1;clean:@2;kill:@3;delete:@4;room_init:nf;create_init:nf;pause_init:nf;pause_update:nf;pause_end:nf;destroyed:nf;get:@5;|ma_able;0;act,;|name:thing;|confined;0;act,;room_end,|room_end:nf;|loopable;0;act,;|tl_loop:yes;|pos;0;act,;|x:0;y:0;|move_pause;0;act,;update,move,vec_update,tick|;|knock;0;col,;|popper;0;col,;|bad;0;knock,;|bounded;0;act,;|check_bounds:nf;|x_bounded;0;bounded,;|check_bounds:@1;|y_bounded;0;bounded,;|timed;0;act,;|t:0;tick:@1;|vec;0;pos,;|dx:0;dy:0;vec_update:@1;|mov;0;vec,;|ix:1;iy:1;ax:0;ay:0;move:@1;stop:@2;calc_next_pos:@3;|dim;0;pos,;|rx:.375;ry:.375;|dim;0;pos,;debug_rect,|rx:.375;ry:.375;debug_rect:@1;|rel;0;act,;rel_update,|rel_actor:null;rel_x:0;rel_y:0;rel_dx:0;rel_dy:0;flippable:no;rel_update:@1;|drawable_obj;0;pos,;reset_off,|ixx:0;iyy:0;xx:0;yy:0;visible:yes;reset_off:@1;|drawable;0;drawable_obj,;d,|d:nf;|drawable_1;0;drawable_obj,;d,|drawable_2;0;drawable_obj,;d,|pre_drawable;0;drawable_obj,;d,|pre_drawable_1;0;drawable_obj,;d,|pre_drawable_2;0;drawable_obj,;d,|post_drawable;0;drawable_obj,;d,|post_drawable_1;0;drawable_obj,;d,|post_drawable_2;0;drawable_obj,;d,|above_map_post_camera_drawable;0;drawable_obj,;d,|spr_obj;0;vec,drawable_obj,;|sind:0;outline_color:BG_UI;sw:1;sh:1;xf:no;yf:no;draw_spr:@1;draw_out:@2;draw_both:@3;|spr;0;spr_obj,;|d:@1;|knockable;0;mov,;|knockback:@1;|stunnable;0;mov,drawable_obj;|stun_update:@1;|hurtable;0;act,;|health:1;max_health:1;health_visible:yes;hurt:@1;heal:@2;|trig;0;vec,dim;|contains:nf;intersects:nf;not_contains_or_intersects:nf;contains_or_intersects:@1;trigger_update:@1;|anchored;1;vec,dim;|touchable:@1;hit:nf;|col;0;vec,dim;|touchable:yes;hit:nf;move_check:@1;|dx:0;dy:0|x,dx,@1,@2,@3,@4;y,dy,@1,@2,@5,@6;|tcol;0;vec,dim;|tile_solid:yes;tile_hit:nf;coll_tile:@1;|view;4;act,confined;center_view,update_view|x:0;y:0;room_crop:2;tl_loop:yes;w:@1;h:@2;follow_dim:@3;follow_act:@4;update_view:@5;center_view:@6;change_ma:@7;,;|@1,x,w,ixx;@1,y,h,iyy|lane_jumper;0;pos,|x:4;y:4;lane:1;i:@1;switch_lane:@2;|vehicle;0;drawable,spr,mov,x_bounded,col|x:4;y:4;ix:.96;iy:.92;vehicle_logic:nf;i:@1;u:@2;move_x:@3;move_y:@4;|pl;2;vehicle,|x:@1;y:@2;vehicle_logic:@3;x:4;y:4;sind:39;sh:2;iyy:-4;|truck;2;vehicle,|x:@1;y:@2;rx:1;vehicle_logic:@3;sind:26;sw:2;sh:3;iyy:-8;horizontal_input:0;|intro_truck;0;truck,|x:-5;y:10;check_bounds:nf;vehicle_logic:@1;destroyed:@2;|intro_pl;0;pl,|x:-18;y:10;check_bounds:nf;vehicle_logic:@1;destroyed:@2;|mission_text;3;drawable,timed|text:@1;y:@2;callback:@3;u:@4;d:@5;destroyed:@6;,;u=nf,tl_max_time=.5,;|road_gen;0;act,vec,drawable;update,|x:0;u:@1;d:@2;|i=@3,u=@4,d=@5;|x:1;y:2;w:14;h:16;c:0;|act,clean;act,update;mov,move;vehicle,move_check,@1;vec,vec_update;bounded,check_bounds;|drawable,d;|pre_drawable,d;pre_drawable_1,d;pre_drawable_2,d;|drawable,d;drawable_1,d;drawable_2,d;post_drawable,d;post_drawable_1,d;post_drawable_2,d;|","|")
g_ztable_cache={}
function nf()end
function ztable(original_str,...)
local str=g_gunvals[0+original_str]
local tbl,ops=unpack(g_ztable_cache[str]or{})
if not tbl then
tbl,ops={},{}
for item in all(split(str,";"))do
local k,v=split_kv(item,":",tbl)
local val_func=function(sub_val,sub_key,sub_tbl)
return queue_operation(sub_tbl or tbl,sub_key or k,sub_val,ops)
end
local ret_val,items={},split(v,",")
for item in all(items)do
local k,v=split_kv(item,"=",ret_val)
if #items==1 then
ret_val=val_func(v)
else
ret_val[k]=val_func(v,k,ret_val)
end
end
tbl[k]=ret_val
end
g_ztable_cache[str]={tbl,ops}
end
local params={...}
foreach(params,disable_tabcpy)
foreach(ops,function(op)
local t,k,f=unpack(op)
t[k]=f(params)
end)
return tbl
end
function split_kv(list,delim,tbl)
local kvs=split(list,delim)
return kvs[#kvs-1]or #tbl+1,kvs[#kvs]
end
function queue_operation(tbl,k,v,ops)
local vlist=split(v,"/")
local will_be_table,func_op,func_name=#vlist>1
if ord(v)==33 then
will_be_table,func_name=true,deli(vlist,1)
func_op={
tbl,k,function()
return _g[sub(func_name,2)](unpack(vlist))
end
}
end
for i,x in ipairs(vlist)do
local rest,closure_tbl=sub(x,2),tbl
if will_be_table then
closure_tbl,k=vlist,i
end
if ord(x)==64 then
add(ops,{
closure_tbl,k,function(p)
return p[rest+0]
end
})
elseif ord(x)==36 then
x=function(a,...)
a[rest](a,...)
end
elseif ord(x)==37 then
x=_g[rest]
elseif ord(x)==126 then
add(ops,{
closure_tbl,k,function()
return tbl[rest]
end
})
elseif x=="yes"or x=="no"then x=x=="yes"
elseif x=="null"or x==""then x=nil
elseif x=="nf"then x=function()end
end
vlist[i]=x
end
add(ops,func_op)
if will_be_table then
return vlist
else
return vlist[1]
end
end
function disable_tabcpy(t)
if type(t)=="table"then
t.is_tabcpy_disabled=true
end
return t
end
function zspr(sind,x,y,sw,sh,...)
sw,sh=sw or 1,sh or 1
spr(sind,x-sw*4,y-sh*4,sw,sh,...)
end
function zprint(str,x,y,align,fg,bg)
if align==0 then x-=#str*2
elseif align>0 then x-=#str*4+1 end
batch_call_new(print,[[1]],str,x,y,fg,bg)
end
function zclip(x1,y1,x2,y2)
clip(x1,y1,x2+1-flr(x1),y2+1-flr(y1))
end
function zcls(col)
batch_call_new(rectfill,[[2]],col or 0)
end
function zrect(x1,y1,x2,y2)
batch_call_new(rect,
[[3]],x1,y1,x2,y2)
end
function scr_spr(a,spr_func,...)
if a and a.visible then
(spr_func or zspr)(a.sind,a.x*8+a.ixx+a.xx,a.y*8+a.iyy+a.yy,a.sw,a.sh,a.xf,a.yf,...)
end
end
function scr_spr_out(a)scr_spr(a,spr_out,a.outline_color)end
function scr_spr_and_out(...)
foreach({...},scr_spr_out)
foreach({...},scr_spr)
end
function outline_helper(flip,coord,dim)
coord=coord-dim*4
if flip then
return dim*8-1+coord,-1
else
return coord,1
end
end
function spr_out(sind,x,y,sw,sh,xf,yf,col)
local ox,x_mult=outline_helper(xf,x,sw)
local oy,y_mult=outline_helper(yf,y,sh)
local out_tbl=g_out_cache[sind]
if out_tbl then
for i=1,#out_tbl,4 do
rectfill(
ox+x_mult*out_tbl[i],
oy+y_mult*out_tbl[i+1],
ox+x_mult*out_tbl[i+2],
oy+y_mult*out_tbl[i+3],
col)
end
end
end
function tprint(str,x,y,c1,c2)
for i=-1,1 do
for j=-1,1 do
zprint(str,x+i,y+j,0,BG_UI,BG_UI)
end
end
zprint(str,x,y,0,c1,c2)
end
g_fadetable=ztable[[4]]
function fade(i)
for c=0,15 do
pal(c,g_fadetable[c+1][min(flr(i+1),7)])
end
end
create_actor([[5|6]],function(a)
g_card_fade=max(a.tl_tim/a.tl_max_time*10,g_card_fade)
end)
create_actor([[7|6]],function(a)
g_card_fade=min((a.tl_max_time-a.tl_tim)/a.tl_max_time*10,g_card_fade)
end)
g_out_cache=ztable[[8]]
create_parent([[9|10]],function(a)
if a.alive and a.stun_countdown<=0 then
if tl_node(a)then
a.alive=false
end
elseif a.stun_countdown>0 then
a.stun_countdown-=1
end
end,function(a)
if not a.alive then
a:destroyed()
a:delete()
end
end,function(a)
a.alive=nil
end,function(a)
for k,v in pairs(g_act_arrs)do
if a[k]then del(v,a)end
end
end,get)
create_parent[[11|12]]
create_parent[[13|14]]
create_parent[[15|16]]
create_parent[[17|18]]
create_parent[[19|20]]
create_parent[[21|20]]
create_parent[[22|20]]
create_parent[[23|20]]
create_parent[[24|25]]
create_parent([[26|27]],function(a)
if a.x+a.dx<g_cur_room.x+.5 then
a.x=g_cur_room.x+.5
a.dx=0
end
if a.x+a.dx>g_cur_room.x+g_cur_room.w-.5 then
a.x=g_cur_room.x+g_cur_room.w-.5
a.dx=0
end
end)
create_parent([[28|27]],function(a)
if a.y+a.dy<g_cur_room.y+.5 then
a.y=g_cur_room.y+.5
a.dy=0
end
if a.y+a.dy>g_cur_room.y+g_cur_room.h-.5 then
a.y=g_cur_room.y+g_cur_room.h-.5
a.dy=0
end
end)
create_parent([[29|30]],function(a)
a.t+=1
end)
create_parent([[31|32]],function(a)
a.x+=a.dx
a.y+=a.dy
end)
create_parent([[33|34]],function(a)
a.dx+=a.ax a.dy+=a.ay
a.dx*=a.ix a.dy*=a.iy
if a.ax==0 and abs(a.dx)<.01 then a.dx=0 end
if a.ay==0 and abs(a.dy)<.01 then a.dy=0 end
end,function(a)
a.ax,a.ay,a.dx,a.dy=0,0,0,0
end,function(a,ax,ay)
return a.x+(a.dx+ax)*a.ix,a.y+(a.dy+ay)*a.iy
end)
create_parent[[35|36]]
create_parent([[37|38]],function(a)
scr_rect(a.x-a.rx,a.y-a.ry,a.x+a.rx,a.y+a.ry,8)
end)
create_parent([[39|40]],function(a)
local a2=a.rel_actor
if a2 then
if a2.alive then
a.x,a.y=a2.x+a.rel_x,a2.y+a.rel_y
a.dx,a.dy=a2.dx+a.rel_dx,a2.dy+a.rel_dy
a.rel_x+=a.rel_dx
a.rel_y+=a.rel_dy
a.xx,a.yy=a2.xx,a2.yy
if a.flippable then
a.xf=a2.xf
end
else
a.alive=false
end
end
end)
create_parent([[41|42]],function(a)
a.xx,a.yy=0,0
end)
create_parent[[43|44]]
create_parent[[45|44]]
create_parent[[46|44]]
create_parent[[47|44]]
create_parent[[48|44]]
create_parent[[49|44]]
create_parent[[50|44]]
create_parent[[51|44]]
create_parent[[52|44]]
create_parent[[53|44]]
create_parent([[54|55]],scr_spr,scr_out,scr_spr_and_out
)
create_parent([[56|57]],scr_spr_and_out)
create_parent([[58|59]],function(a,speed,xdir,ydir)
a.dx=xdir*speed
a.dy=ydir*speed
end)
create_parent([[60|61]],function(a)
if a.stun_countdown>0 then
a.ay,a.ax=0,0
a.yy=rnd_one()
a.outline_color=2
else
a.outline_color=1
end
end)
create_parent([[62|63]],function(a,damage,stun_val)
if a.stun_countdown<=0 then
a.stun_countdown=stun_val
a.health=max(0,a.health-damage)
if a.health==0 then
a.alive=false
end
end
end,function(a,health)
a.health=min(a.max_health,a.health+health)
end)
create_parent([[64|65]],function(a,b)
if does_a_contain_b(a,b)then
a:contains(b)
elseif do_actors_intersect(a,b)then
a:intersects(b)
else
a:not_contains_or_intersects(b)
end
end)
create_parent[[66|67]]
create_parent([[68|69]],function(a,acts)
local hit_list={}
local move_check=function(dx,dy)
local ret_val=dx+dy
local col_help=function(axis,spd_axis,a,b,pos,spd)
if spd!=0 and pos<abs(a[axis]-b[axis])then
if a.touchable and b.touchable then
local s_f=function(c)
if not c.anchored then
c[spd_axis]=(a[spd_axis]+b[spd_axis])/2
end
end
s_f(a)s_f(b)
ret_val=0
end
hit_list[b][spd_axis]=zsgn(spd)
end
end
foreach(acts,function(b)
if a!=b and(not a.anchored or not b.anchored)then
local x,y=abs(a.x+dx-b.x),abs(a.y+dy-b.y)
if x<a.rx+b.rx and y<a.ry+b.ry then
hit_list[b]=hit_list[b]or ztable[[70]]
batch_call_new(col_help,[[71]],a,b,x,dx,y,dy)
end
end
end)
return ret_val
end
a.dx,a.dy=move_check(a.dx,0),move_check(0,a.dy)
for b,d in pairs(hit_list)do
a:hit(b,d.dx,d.dy)
end
end)
create_parent([[72|73]],function(a,solid_func)
local x,dx=coll_tile_help(a.x,a.y,a.dx,a.rx,a.ry,0,a,a.tile_hit,solid_func)
local y,dy=coll_tile_help(a.y,a.x,a.dy,a.ry,a.rx,2,a,a.tile_hit,function(y,x)return solid_func(x,y)end)
if a.tile_solid then
a.x,a.y,a.dx,a.dy=x,y,dx,dy
end
end)
function update_view_helper(view,xy,wh,ii)
local follow_coord=view.follow_act and(view.follow_act[xy]+view.follow_act[ii]/8)or 0
local view_coord=view[xy]
local view_dim=view[wh]
local room_dim=g_cur_room[wh]/2-view_dim/2
local room_coord=g_cur_room[xy]+g_cur_room[wh]/2
local follow_dim=round(view.follow_dim*8)/8
if follow_coord<view_coord-follow_dim then view_coord=follow_coord+follow_dim end
if follow_coord>view_coord+follow_dim then view_coord=follow_coord-follow_dim end
if view_coord<room_coord-room_dim then view_coord=room_coord-room_dim end
if view_coord>room_coord+room_dim then view_coord=room_coord+room_dim end
if g_cur_room[wh]<=view[wh]then view_coord=room_coord end
view[xy]=view_coord
end
function scr_pset(x,y,c)
pset(x*8,y*8,c)
end
function scr_line(x1,y1,x2,y2,col)
line(x1*8,y1*8,x2*8,y2*8,col)
end
function scr_rect(x1,y1,x2,y2,col)
rect(x1*8,y1*8,x2*8-1,y2*8-1,col)
end
function scr_rectfill(x1,y1,x2,y2,col)
rectfill(x1*8,y1*8,x2*8,y2*8,col)
end
function scr_map(cel_x,cel_y,sx,sy,...)
map(cel_x,cel_y,sx*8,sy*8,...)
end
function scr_circfill(x,y,r,col)
circfill(x*8,y*8,r*8,col)
end
function scr_circ(x,y,r,col)
circ(round(x*8),round(y*8),r*8,col)
end
create_actor([[74|75]],
function(a)
if a.follow_act and not a.follow_act.alive then
a.follow_act=nil
end
batch_call_new(update_view_helper,[[76]],a)
end,function(a)
if a.follow_act then
a.x,a.y=a.follow_act.x,a.follow_act.y
a.name=a.follow_act.name
end
a:update_view()
end,function(a,other)
if not other or other.ma_able then
a.follow_act=other
end
end)
TOP_LANE_Y=8
MID_LANE_Y=10
BOT_LANE_Y=12
function draw_blueprint()
rect(0,0,127,127,2)
rect(0,TOP_LANE_Y*8-8,127,TOP_LANE_Y*8+7,8)
rect(0,MID_LANE_Y*8-8,127,MID_LANE_Y*8+7,8)
rect(0,BOT_LANE_Y*8-8,127,BOT_LANE_Y*8+7,8)
zprint("time: 32.3s",4,119,-1,10,2)
rectfill(124-64,119,124,124,12)
rect(124-64,124,124,124,1)
end
create_actor([[77|78]],function(a)
a:switch_lane(0)
end,function(a,lane_dir)
a.lane=mid(0,a.lane+lane_dir,2)
a.y=TOP_LANE_Y+a.lane*2
end,function(a)
scr_circ(a.x,a.y,.5,8)
end)
create_actor([[79|80]],function(a)
a.lane_jumper=_g.lane_jumper()
end,function(a)
a:vehicle_logic()
amov_y(a,.02,a.lane_jumper.y)
end,function(a,x)
a.ax=x*.005
end,function(a,y)
a.lane_jumper:switch_lane(y)
end)
create_actor([[81|82]],function(a)
a:move_x(xbtn())
a:move_y(ybtnp())
if a.dx>.05 and a.ax>0 then
a.sind=38
elseif a.dx<-.05 and a.ax<0 then
a.sind=37
else
a.sind=39
end
end,function(a)
scr_circ(a.x,a.y,.5,12)
end)
create_actor([[83|84]],function(a)
if flr_rnd(15)==0 then
a.horizontal_input=flr_rnd(3)-1
end
a:move_x(a.horizontal_input)
if flr_rnd(30)==0 then
a:move_y(flr_rnd(3)-1)
end
end)
create_actor([[85|86]],function(a)
a:move_x(a.x<10 and 1 or 0)
end,function(a)
_g.truck(a.x,a.y)
end)
create_actor([[87|88]],function(a)
a:move_x(a.x<1 and 1 or 0)
end,function(a)
_g.pl(a.x,a.y)
end)
create_actor([[89|90]],function(a)
a.cur_text=sub(a.text,1,min(#a.text,a.tl_tim*10))
if #a.cur_text>=#a.text then
a:next()
end
end,function(a)
zprint(a.cur_text,4,a.y,-1,11,1)
end,function(a)
a.callback()
end)
create_actor([[91|92]],function(a)
a.dx=-.14
end,function(a)
for y=TOP_LANE_Y,BOT_LANE_Y,2 do
for x=0,8 do
zspr(96,((a.x+x*2)%18)*8-8,y*8,2,2)
end
end
end)
g_debug=false
g_card_fade=8
poke(0x5f5c,15)
poke(0x5f5d,15)
function _init()
music(0,3000)
g_tl=ztable([[93]],logo_draw,function()sfx"63" end,
game_init,game_update,game_draw
)
end
function game_init(a)
_g.fader_in(.5,nf,nf)
g_intro_pl=_g.intro_pl()
g_intro_truck=_g.intro_truck()
_g.mission_text("\^y8codename: pendae\nobjective: eat ice cream",4,function()
g_intro_pl:kill()
g_intro_truck:kill()
end)
_g.road_gen()
g_cur_room=ztable[[94]]
end
function game_update(a)
batch_call_new(acts_loop,[[95]],g_act_arrs["col"])
end
function game_draw(a)
fade(g_card_fade)
draw_blueprint()
isorty(g_act_arrs.drawable)
batch_call_new(acts_loop,[[96]])
if g_debug then acts_loop("dim","debug_rect")end
end
function logo_draw(a)
local logo_opacity=8+cos(a.tl_tim/a.tl_max_time)*4-4
fade(logo_opacity)
camera(logo_opacity>1 and rnd_one())
zspr(108,a.x,a.y,4,2)
fade"0"
camera()
end
function _update60()
if g_debug then poke(0x5f42,15)
else poke(0x5f42,0)
end
if btnp"5"and btn"4"then g_debug=not g_debug end
tl_node(g_tl)
end
function _draw()
cls()
call_not_nil(g_tl,"d",g_tl)
if g_debug then
rect(0,0,127,127,8)
end
end
function shiftx(view)
return(view.x-view.off_x-8)*8
end
function shifty(view)
return(view.y-view.off_y-8)*8
end
function camera_to_view(view)
camera(shiftx(view),shifty(view))
end
function map_draw(view,x,y)
if view then
local rx=x-view.w/2
local ry=y-view.h/2
view.off_x=-(16-view.w)/2+rx
view.off_y=-(16-view.h)/2+ry
local x1,x2=rx*8+4,(rx+view.w)*8-5
local y1,y2=ry*8+4,(ry+view.h)*8-5
camera_to_view(view)
zclip(x1,y1,x2,y2)
zcls(g_cur_room.c)
batch_call_new(acts_loop,[[97]])
isorty(g_act_arrs.drawable)
batch_call_new(acts_loop,[[98]])
if g_debug then acts_loop("dim","debug_rect")end
clip()
camera()
end
end