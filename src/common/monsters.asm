#define class_mc_cambion 16

    DEFINE_PLAYER monster_class_cambion, 15, 13, 14, 13, 12, 14, race_monster, class_mc_cambion, 1, "Cambion"
.db 0
.db 0
.db 0

.local
    CAMPAIGN_MONSTER_DESCRIPTOR monster_descriptor_cambion, class_mc_cambion, monster_size_medium, 14, 2, 1, 2, 1, 1, 2, cambion_damage_func

cambion_damage_func:
    ; Scimitar
    call roll_d6
    ld a, l
    add a, 2
    ret

register_monsters::
    ld hl, monster_descriptor_cambion
    call register_campaign_monster

    ld a, class_mc_cambion
    ld (campaign_class_0_value), a

    ld a, default_options_flags
    ld (campaign_class_0_flags), a

    ld hl, cambion_class_label
    ld (campaign_class_0_label), hl
    ret

.endlocal
