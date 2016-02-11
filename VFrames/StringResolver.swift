//
//  swift
//  VFrames
//
//  Created by Andy Garron on 2/9/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

class StringResolver {
    
    private static var stringDict = [String:String]()
    
    static func resolveString(stringId: String) -> String {
        return stringDict[stringId]!
    }
    
    static func initialize() {
        
        //General Movelist
        stringDict["id_close_to_opponent"] = "close_to_opponent"
        stringDict["id_can_be_done_in_air"] = "can_be_done_in_air"
        stringDict["id_during_jump"] = "during_jump"
        stringDict["id_during_jump_near_wall"] = "during_jump_near_wall"
        stringDict["id_during_forward_jump"] = "during_forward_jump"
        stringDict["id_during_guard"] = "during_guard"
        stringDict["id_hold_buttons_to_attack"] = "hold_buttons_to_attack"
        stringDict["id_close_to_grounded_opponent"] = "close_to_grounded_opponent"
        stringDict["id_close_to_airborne_opponent"] = "close_to_airborne_opponent"
        stringDict["id_hold_button"] = "hold_button"
        stringDict["id_during_vertical_or_forward_jump"] = "during_vertical_or_forward_jump"
        stringDict["id_during_vtrigger"] = "during_vtrigger"
        stringDict["id_hold_and_release"] = "hold_and_release"
        stringDict["id_close_to_crouching_opponent"] = "close_to_crouching_opponent"
        stringDict["id_during_run"] = "during_run"
        
        //General Descriptions
        stringDict["id_hits_overhead"] = "hits_overhead"
        stringDict["id_hits_low"] = "hits_low"
        stringDict["id_command_grab"] = "command_grab"
        
        //Ryu Movelist
        stringDict["id_ryu_hadoken_description"] = "ryu_hadoken_description"
        stringDict["id_ryu_shoryuken_description"] = "ryu_shoryuken_description"
        stringDict["id_ryu_tatsu_description"] = "ryu_tatsu_description"
        stringDict["id_ryu_vtrigger_description"] = "ryu_vtrigger_description"
        stringDict["id_ryu_vskill_description"] = "ryu_vskill_description"
        
        //Karin Movelist
        stringDict["id_karin_tenko_posttext"] = "karin_tenko_posttext"
        stringDict["id_karin_meioken_posttext"] = "karin_meioken_posttext"
        stringDict["id_karin_kanzuki_ryu_hokojutsu_sappo_description"] = "karin_kanzuki_ryu_hokojutsu_sappo_description"
        stringDict["id_karin_tenko_description"] = "karin_tenko_description"
        stringDict["id_karin_orochi_description"] = "karin_orochi_description"
        stringDict["id_karin_senha_resshu_description"] = "karin_senha_resshu_description"
        stringDict["id_karin_vskill_description"] = "karin_vskill_description"
        stringDict["id_karin_vtrigger_description"] = "karin_vtrigger_description"
        stringDict["id_karin_mujinkyaku_description"] = "karin_mujinkyaku_description"
        
        //Claw Movelist
        stringDict["id_claw_claw_on_only"] = "claw_claw_on_only"
        stringDict["id_claw_claw_off_only"] = "claw_claw_off_only"
        stringDict["id_claw_switch"] = "claw_switch"
        stringDict["id_claw_flying_barcelona_attack_description"] = "claw_flying_barcelona_attack_description"
        stringDict["id_claw_vskill_description"] = "claw_vskill_description"
        stringDict["id_claw_vtrigger_torero_description"] = "claw_vtrigger_torero_description"
        stringDict["id_claw_vtrigger_rojo_description"] = "claw_vtrigger_rojo_description"
        stringDict["id_claw_vtrigger_azul_description"] = "claw_vtrigger_azul_description"
        stringDict["id_claw_during_flying_barcelona_attack"] = "claw_during_flying_barcelona_attack"
        
        //Chun Movelist
        stringDict["id_up_to_three_times"] = "chun_up_to_three_times"
        stringDict["id_chun_vtrigger_description"] = "chun_vtrigger_description"
        stringDict["id_chun_vskill_description"] = "chun_vskill_description"
        stringDict["id_chun_senenshu_description"] = "chun_senenshu_description"
        stringDict["id_chun_kikoken_description"] = "chun_kikoken_description"
        stringDict["id_chun_airborne_lightning_legs_description"] = "chun_airborne_lightning_legs_description"
        stringDict["id_chun_spinning_bird_kick_description"] = "chun_spinning_bird_kick_description"
        stringDict["id_chun_critical_art_description"] = "chun_critical_art_description"
        
        //Ken Movelist
        stringDict["id_ken_hadoken_description"] = "ken_hadoken_description"
        stringDict["id_ken_shoryuken_description"] = "ken_shoryuken_description"
        stringDict["id_ken_tatsu_description"] = "ken_tatsu_description"
        stringDict["id_ken_airborne_tatsu_description"] = "ken_airborne_tatsu_description"
        stringDict["id_ken_vtrigger_description"] = "ken_vtrigger_description"
        stringDict["id_ken_vskill_description"] = "ken_vskill_description"
        stringDict["id_ken_thunder_kick_posttext"] = "ken_thunder_kick_posttext"
        stringDict["id_ken_thunder_kick_description"] = "hits_overhead"
        
        //Zangief Movelist
        stringDict["id_hold_buttons_for_special_lariat"] = "zangief_hold_buttons_for_special_lariat"
        stringDict["id_can_move_forward_while_holding_buttons"] = "zangief_can_move_forward_while_holding_buttons"
        stringDict["id_zangief_siberian_express_description"] = "zangief_siberian_express_description"
        stringDict["id_zangief_vtrigger_description"] = "zangief_vtrigger_description"
        stringDict["id_zangief_vskill_description"] = "zangief_vskill_description"
        
        //Dictator Movelist
        stringDict["id_after_head_press"] = "dictator_after_head_press"
        stringDict["id_before_head_press"] = "dictator_before_head_press"
        stringDict["id_psycho_reflect_hold_buttons"] = "dictator_psycho_reflect_hold_buttons"
        stringDict["id_dictator_psycho_blast_description"] = "dictator_psycho_blast_description"
        stringDict["id_devil_reverse_description"] = "dictator_devil_reverse_description"
        stringDict["id_dictator_vskill_description"] = "dictator_vskill_description"
        stringDict["id_dictator_vtrigger_description"] = "dictator_vtrigger_description"
        
        //Laura Movelist
        stringDict["id_laura_hold_buttons_to_power_up"] = "laura_hold_buttons_to_power_up"
        stringDict["id_laura_after_mp_or_ex_bolt_charge"] = "laura_after_mp_or_ex_bolt_charge"
        stringDict["id_laura_bolt_charge_description"] = "laura_bolt_charge_description"
        stringDict["id_laura_split_river_description"] = "laura_split_river_description"
        stringDict["id_laura_rodeo_break_description"] = "laura_rodeo_break_description"
        stringDict["id_laura_thunder_clap_description"] = "laura_thunder_clap_description"
        stringDict["id_laura_vtrigger_description"] = "laura_vtrigger_description"
        stringDict["id_laura_vskill_overhead_description"] = "laura_vskill_overhead_description"
        stringDict["id_laura_vskill_avante_description"] = "vskill_avante_description"
        stringDict["id_laura_vskill_esquiva_description"] = "vskill_esquiva_description"
        
        //Birdie Movelist
        stringDict["id_birdie_hanging_chain_posttext"] = "birdie_hanging_chain_posttext"
        stringDict["id_birdie_bull_head_description"] = "birdie_bull_head_description"
        stringDict["id_birdie_bull_horn_description"] = "birdie_bull_horn_description"
        stringDict["id_birdie_hanging_chain_description"] = "birdie_hanging_chain_description"
        stringDict["id_birdie_killing_head_description"] = "birdie_killing_head_description"
        stringDict["id_birdie_bull_revenger_description"] = "birdie_bull_revenger_description"
        stringDict["id_birdie_vtrigger_description"] = "birdie_vtrigger_description"
        
        //Mika Movelist
        stringDict["id_mika_shooting_peach_description"] = "mika_shooting_peach_description"
        stringDict["id_mika_wingless_airplane_description"] = "mika_wingless_airplane_description"
        stringDict["id_mika_typhoon_description"] = "mika_typhoon_description"
        stringDict["id_mika_brimstone_description"] = "mika_brimstone_description"
        stringDict["id_mika_vtrigger_posttext"] = "mika_vtrigger_posttext"
        stringDict["id_mika_vskill_posttext"] = "mika_vskill_posttext"
        stringDict["id_mika_vskill_description"] = "mika_vskill_description"
        stringDict["id_mika_passion_rope_throw_pretext"] = "mika_passion_rope_throw_pretext"
        stringDict["id_mika_passion_rope_throw_posttext"] = "mika_passion_rope_throw_posttext"
        
        //Rashid Movelist
        stringDict["id_rashid_repeat_buttons_to_extend"] = "rashid_repeat_buttons_to_extend"
        stringDict["id_rashid_vtrigger_description"] = "rashid_vtrigger_description"
        stringDict["id_rashid_vskill_divekick_pretext"] = "rashid_vskill_divekick_pretext"
        stringDict["id_rashid_vskill_rollkick_pretext"] = "rashid_vskill_rollkick_pretext"
        stringDict["id_rashid_spinning_mixer_description"] = "rashid_spinning_mixer_description"
        stringDict["id_rashid_whirlwind_shot_description"] = "rashid_whirlwind_shot_description"
        
        //Rashid Frame Data
        stringDict["id_rashid_eagle_spike_on_block_description"] = "rashid_eagle_spike_on_block_description"
        
        //Nash Movelist
        stringDict["id_nash_press_for_second_boom"] = "nash_press_for_second_boom"
        stringDict["id_nash_sonic_boom_description"] = "nash_sonic_boom_description"
        stringDict["id_nash_sonic_scythe_description"] = "nash_sonic_scythe_description"
        stringDict["id_nash_tragedy_assault_description"] = "nash_tragedy_assault_description"
        stringDict["id_nash_sonic_move_hide_description"] = "nash_sonic_move_hide_description"
        stringDict["id_nash_sonic_move_blitz_air_description"] = "nash_sonic_move_blitz_air_description"
        stringDict["id_nash_sonic_move_steel_air_description"] = "nash_sonic_move_steel_air_description"
        stringDict["id_nash_critical_art_description"] = "nash_critical_art_description"
        stringDict["id_nash_vskill_description"] = "nash_vskill_description"
        
        //Necalli Movelist
        stringDict["id_necalli_vskill_control_distance"] = "necalli_vskill_control_distance"
        stringDict["id_necalli_disc_guidance_description"] = "necalli_disc_guidance_description"
        stringDict["id_necalli_raging_light_description"] = "necalli_raging_light_description"
        stringDict["id_necalli_mask_of_tlalli_description"] = "necalli_mask_of_tlalli_description"
        stringDict["id_necalli_vtrigger_description"] = "necalli_vtrigger_description"
        stringDict["id_necalli_vskill_description"] = "necalli_vskill_description"
        stringDict["id_necalli_opening_dagger_description"] = "necalli_opening_dagger_description"
        
        //Cammy Movelist
        stringDict["id_during_hooligan_combination"] = "cammy_during_hooligan"
        stringDict["id_cammy_spiral_arrow_description"] = "cammy_spiral_arrow_description"
        stringDict["id_cammy_cannon_spike_description"] = "cammy_cannon_spike_description"
        stringDict["id_cammy_cannon_strike_description"] = "cammy_cannon_strike_description"
        stringDict["id_cammy_hooligan_combination_description"] = "cammy_hooligan_combination_description"
        stringDict["id_cammy_vtrigger_description"] = "cammy_vtrigger_description"
        stringDict["id_cammy_vskill_description"] = "cammy_vskill_description"
        stringDict["id_close_to_grounded_opponent_during_hooligan"] = "hooligan_close_to_grounded_opponent"
        stringDict["id_close_to_airborne_opponent_during_hooligan"] = "hooligan_close_to_airborne_opponent"
        
        //Dhalsim Movelist
        stringDict["id_dhalsim_critical_art_posttext"] = "dhalsim_critical_art_posttext"
        stringDict["id_dhalsim_yoga_fire_description"] = "dhalsim_yoga_fire_description"
        stringDict["id_dhalsim_yoga_flame_description"] = "dhalsim_yoga_flame_description"
        stringDict["id_dhalsim_yoga_teleport_description"] = "dhalsim_yoga_teleport_description"
        stringDict["id_dhalsim_vtrigger_description"] = "dhalsim_vtrigger_description"
        stringDict["id_dhalsim_vskill_description"] = "dhalsim_vskill_description"
        
        //Fang Movelist
        stringDict["id_fang_vskill_description"] = "fang_vskill_description"
        stringDict["id_fang_vtrigger_description"] = "fang_vtrigger_description"
        stringDict["id_fang_critical_art_description"] = "fang_critical_art_description"
    }
}
