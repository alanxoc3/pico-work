pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
#include adventure.lua

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bbbbb00000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b00000b0000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0000000b000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0b00000b0b00000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0bbbbbbb0b00000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0b0bbb0b0b00000000000000000000000000
0000000000000000000000000000000000000000000000000000770077700070777077700000000000000000000b0b0bbb0b0b00000000000000000000000000
0000000000000000000000000000000000000000000000000700070000700700007070700000000000000000000b00bbbbb00b00000000000000000000000000
00000000000000000000000000000000000000000000000077700700777007007770707000000000000000000000b0000000b000000000000000000000000000
000000000000000000000000000000000000000000000000070007007000070070007070000000000000000000000b00000b0000000000000000000000000000
0000000000000000000000000000000000000000000000000000777077707000777077700000000000000000000000bbbbb00000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088888000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000800000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000080000000000000000000000000000
00000000000000000000000000000000000000000000000008888800000000000000000000000000000000000080800000808000000000000000000000000000
00000000000000000000000000000000000000000000000080000080000000000000000000000000000000000080888888808000000000000000000000000000
00000000000000000000000000000000000000000000000800000008000000000000000000000000000000000080808880808000000000000000000000000000
00000000000000000000000000000000000000000000008080000080800000000000000000000000000000000080808880808000000000000000000000000000
00000000000000000000000000000000000000000000008088888880800000000000000000000000000000000080088888008000000000000000000000000000
00000000000000000000000000000000000000000000008080888080800000000000000000000000000000000008000000080000000000000000000000000000
00000000000000000000000000000000000000000000008080888080800000000000000000000000000000000000800000800000000000000000000000000000
00000000000000000000000000000000000000000000008008888800800000000000000000000000000000000000088888000000000000000000000000000000
00000000000000000000000000000000000000000000000800000008000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000080000080000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000008888800000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000099999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000900000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000009000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000909000009090000000000000aaaaa000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000090999999909000000000000a00000a00000000099999000000000000000000000000000000000000000000000000000
0000000000000000000000000000000009090999090900000000000a0000000a0000000900000900000000000000000000000000000000000000000000000000
000000000000000000000000000000000909099909090000000000a0a00000a0a000009000000090000000000000000000000000000000000000000000000000
000000000000000000000000000000000900999990090000000000a0aaaaaaa0a000090900000909000000000000000000000000000000000000000000000000
000000000000000000000000000000000090000000900000000000a0a0aaa0a0a000090999999909000000000000000000000000000000000000000000000000
000000000000000000000000000000000009000009000000000000a0a0aaa0a0a000090909990909000000000000000000000000000000000000000000000000
000000000000000000000000000000000000999990000000000000a00aaaaa00a000090909990909000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000a0000000a0000090099999009000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000a00000a00000009000000090000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000aaaaa000000000900000900000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000009999900000000000000000aaaaa00000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000a0000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0000000a000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0a00000a0a00000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0aaaaaaa0a00000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0a0aaa0a0a00000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0a0aaa0a0a00000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00aaaaa00a00000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0000000a000000000000000000000000000
000000000000000000000000000000999990000000000000000000000000000000000000000000000000000000000a00000a0000000000000000000000000000
0000000000000000000000000000090000090000000000000000000000000000000000000000000000000000000000aaaaa00000000000000000000000000000
00000000000000000000000000009000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000090900000909000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000090999999909000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000090909990909000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000009090999090900000000000000000000ccccc00000000000000000000099999000000000000000000000000000000000000000
000000000000000000000000000900999990090000000000000000000c00000c0000000000000000000900000900000000000000000000000000000000000000
00000000000000000000000000009000000090000000000000000000c0000000c000000000000000009000000090000000000000000000000000000000000000
0000000000000000000000000000090000090000000000000000000c000ccc000c00000000000000090900000909000000000000000000000000000000000000
0000000000000000000000000000009999900000000000000000000c000ccc000c00000000000000090999999909000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000c00ccccc00c00000000000000090909990909000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000c000ccc000c00000000000000090909990909000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000c000c0c000c00000000000000090099999009000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000c0000000c000000000000000009000000090000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000c00000c0000000000000000000900000900000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000ccccc00000000000000000000099999000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000088888000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000800000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000080000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000080800000808000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000080888888808000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000080808880808000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000008080888b808000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000800888880b8000000000000000000000000000000000
00000000000000000000000000000000000000000009999900000000000000000000000000000000000008b0000008b000000000000000000000000000000000
0000000000000000000000000000000000000000009000009000000000000000000000000000000000000b8b00008b0b00000000000000000000000000000000
0000000000000000000000000000000000000000090000000900000000000000000000000000000000000b088888bb0b00000000000000000000000000000000
0000000000000000000000000000000000000000909000009090000000000000000000000000000000000b0b0bbb0b0b00000000000000000000000000000000
0000000000000000000000000000000000000000909999999090000000000000000000000000000000000b0b0bbb0b0b00000000000000000000000000000000
0000000000000000000000000000000000000000909099909090000000000000000000000000000000000b00bbbbb00b00000000000000000000000000000000
00000000000000000000000000000000000000009090999090900000000000000000000000000000000000b0000000b000000000000000000000000000000000
000000000000000000000000000000000000000090099999009000000000000000000000000000000000000b00000b0000000000000000000000000000000000
0000000000000000000000000000000000000000090000000900000000000000000000000000000000000000bbbbb00000000000000000000000000000000000
00000000000000000000000000000000000000000090000090000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000009999900000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__sfx__
010800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000