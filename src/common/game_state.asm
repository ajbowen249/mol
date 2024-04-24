game_state_begin:
player_party:
    EMPTY_CHARACTER party_member_0
    EMPTY_CHARACTER party_member_1
    EMPTY_CHARACTER party_member_2
    EMPTY_CHARACTER party_member_3

party_size: .db 0

is_using_origin_character: .db 0
selected_origin_character_index: .db 0

recruited_characters:
recruited_laezel: .db 0
recruited_shadowheart: .db 0
recruited_gale: .db 0
recruited_karlach: .db 0

last_room: .db 0

killed_zhalk: .db 0

killed_goblins_at_the_gate: .db 0

spoke_with_zevlor_after_gag: .db 0
kagha_interaction_complete: .db 0
defeated_grove: .db 0

killed_dror_ragzlin: .db 0
helped_dror_question: .db 0
killed_priestess_gut: .db 0
have_brand_of_the_absolute: .db 0
killed_minthara: .db 0
minthara_started_attack: .db 0

killed_nere: .db 0

party_xp: .db 0

game_state_end: .db 0
