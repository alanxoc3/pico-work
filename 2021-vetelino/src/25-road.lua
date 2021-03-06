ROAD_SPEED = -.125

create_actor([[popsicle;2;post_drawable,spr,vec,dim,col,confined|
    touchable:no;
    x:@1; variant:@2;
    i:@4;
    sind:70; sh:2;

    u=@3,;
    hit=@6,u=nf,i=@5,tl_max_time=5;
]], function(a)
    if g_pl and g_pl.x+4 > a.x then
        a:next()
    end
end, function(a)
    a.dx = ROAD_SPEED
    if a.variant then
        a.y = 13
        a.iyy = 4
    else
        a.y = 7
        a.iyy = -4
        a.yf = true
    end
end, function(a)
    if a.variant then
        a.dy = -.1
    else
        a.dy = .1
    end
    a.sind = 68
end, function(a, other)
    if other.vehicle then
        other:hurt(3, 0)
        a:kill()
    end
end)

create_actor([[cannon;2;drawable,spr,vec,dim,confined|
    x:@1; variant:@2;
    i:@3;

    sind:118;
    tl_max_time=12,;
]], function(a)
    a.dx = ROAD_SPEED
    if a.variant then
        a.y = 14
    else
        a.y = 6
        a.yf = true
    end
    _g.popsicle(a.x, a.variant, 1+rnd(1))
end)

create_actor([[road_gen;0;act,vec,drawable,timed,confined|
    x:0; i:@1; u:@2; d:@3;
]], function(a)
    a.dx = ROAD_SPEED
end, function(a)
    if a.t % 60 == 0 then
        if flr_rnd(3) == 0 then
            _g.cannon(18+a.x%1, flr_rnd(2) == 0)
        end
    end
end, function(a)
    for y=TOP_LANE_Y,BOT_LANE_Y,2 do
        for x=0,8 do
            zspr(96, ((a.x+x*2)%18)*8-8, y*8, 2, 2)
        end
    end
end)

