#include "./world/nautiloid_bridge.asm"
#include "./world/crash_site.asm"
#include "./world/emerald_grove_environs.asm"
#include "./world/blighted_village.asm"
#include "./world/goblin_camp.asm"
#include "./world/emerald_grove.asm"
#include "./world/underdark.asm"
#include "./cut_scenes/opening.asm"
#include "./cut_scenes/crash.asm"

screen_table:
.dw 0
.dw 0
.dw nautiloid_bridge
.dw crash_site
.dw emerald_grove_environs
.dw blighted_village
.dw 0
.dw 0
.dw goblin_camp
.dw emerald_grove
.dw underdark
.dw cs_opening
.dw cs_crash
