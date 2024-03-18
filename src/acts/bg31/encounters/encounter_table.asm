#include "./common.asm"
#include "./commander_zhalk.asm"
#include "./dror_ragzlin.asm"
#include "./priestess_gut.asm"
#include "./minthara.asm"
#include "./goblins_at_the_gate.asm"
#include "./grove_leaders.asm"

encounter_table:
.dw 0
.dw encounter_commander_zhalk
.dw encounter_dror_ragzlin
.dw encounter_priestess_gut
.dw encounter_minthara
.dw encounter_goblins_at_the_gate
.dw encounter_grove_leaders
