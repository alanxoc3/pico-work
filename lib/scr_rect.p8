--- tokens: 47
function scr_rect(x1, y1, x2, y2, col)
	rect((x1-g_x)*8, (y1-g_y)*8, (x2-g_x)*8-1, (y2-g_y)*8-1, col)
end
