-- fade should be a table (generated by gen_fade)
-- val is between 0 and 15
function fade(f, val)
	val = min(max(flr(val) + 1, 1), 16)
	for c=0,15 do
		pal(c,f[c+1][val])
	end
end

-- returns an expanded fade table from a string
-- you probably want to call this at the start of your program.
function gen_fade(str)
	local ret = {}
	for i=1, #str do
		local col, row = (i-1)%16+1, flr((i-1)/16)+1
		if i % 16 == 1 then ret[row] = {} end
		ret[row][col] = s2x[ sub(str, i, i) ]
	end
	return ret
end
