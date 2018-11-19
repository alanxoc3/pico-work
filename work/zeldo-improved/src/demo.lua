-- todo: grayscale and overall palette fixing.
--
-- 3522 3529 3503 3510 3521 3523 3538 3526 3487 3428 3635 3660 3652 3545 3494
-- 3487 3743 3686 3675 3585 3591 3797 3802 3759 3755 3861 4663 4470 4457 4478
-- 4477 4488 4387 4353 4369 4404 4338 4330 4316 4308 4288 4280 4259 4257 4272
-- 4295 4275 4259 4223 4206 4205 4212 4200 4198 4187 4232 4232 4230 4227 4212
-- 4206 4198 4283 4219 4321 4312 4190 4104 4094 4087 4123 4121 4119 4141 4099
-- 4089 4075 4040 4015

function _init()
   poke(0x5f34, 1) -- for pattern colors.
   g_grayscale = gun_vals("5,13,13,13,5,6,6,6,6,6,6,6,13,6,6")

	g_tl = tl_init(
		--{ init_logo,  2.5, update_logo,  draw_logo },
		--{ title_init, 1,   title_update, title_draw },
		{ game_init,  nil, game_update,  game_draw }
	)
end

function _update60()
   if not g_tbox_active then
      tl_update(g_tl)
      -- if btnp(0) then tbox(":hello lank, we meet again") end
   end
   tbox_interact(function() end, sound)
end

function _draw()
	cls()
	tl_draw(g_tl)
   ttbox_draw(7, 0)
end

function game_update()
   batch_call(
      acts_loop,
      "{act,update}, {mov,move}, {col,move_check,@}, {tcol,coll_tile,@}, {rel,rel_update,@}, {vec,vec_update}, {act, clean}, {anim,anim_update}, {timed,tick}",
      g_act_arrs["col"],
      function(x, y) return fget(mget(x, y), 1) end,
      g_pl
   )

	update_view(g_pl.x, g_pl.y)

   if stat(1) > .3 then
      printh(stat(1))
   end
end

function game_draw()
   cls(0)

   -- todo: gray for sprites, and pause.
   if g_menu_open then
      for i=1,15 do pal(i, g_grayscale[i]) end
   end

   -- draw the background colors! for efficiency :).
   batch_call(scr_rectfill, "{0,0,49.5,64,3}, {49.5,31,95,64,3}, {64,31,95,64,4}, {78.5,0,95,31,4}, {49.5,0,78.5,31,5}, {82,0,93,18,5}, {63,0,65,64,12}")
	scr_map(0, 0, 0, 0, 96, 64)

   pal()
   acts_loop("spr", "draw")

   if g_menu_open then
      draw_menu()
   end

   batch_call(rectfill, "{0,0,127,9,0}, {0,118,127,127,0}")

   print("cpu: "..stat(1), 2, 2, 7)
end

function game_init()
	-- palt(0, false)
   -- deku_spawner(3.5, 22.5, true)
   for i=5,20 do gen_spawner(3.5, i*2.2, gen_deku, 12, true) end
   g_pl = gen_pl(75, 40)

   -- gen_spawner(71, 53, gen_hobgoblin, 12)
   for i=71,91,2 do
      gen_spawner(i, 53, gen_hobgoblin, 12)
   end

	load_view(0, 0-10/8, 96, 68-12/8, 5, 11)
	center_view(g_pl.x, g_pl.y)
end