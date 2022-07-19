//
//  ServerData.swift
//  Interceptor
//
//  Created by Christian Mitteldorf on 07/05/2021.
//

import Foundation
import XMLCoder

extension OGameAPI {

    public struct ServerData: Decodable {
        public let name: String?
        public let number: Int
        public let language: String
        public let timezone: String
        public let timezoneOffset: String
        public let domain: String
        public let version: String
        public let speed: Int
        public let galaxies: Int
        public let systems: Int
        public let acs: Bool
        public let rapidFire: Bool
        public let defToTF: Bool
        public let debrisFactor: Float
        public let debrisFactorDef: Float
        public let repairFactor: Float
        public let newbieProtectionLimit: Int
        public let newbieProtectionHigh: Int
        // TODO: Fix parsing of non-integer top scores
        // Due to Bermuda bug accounts can have incredibly high points
        // which then is returned as a scientific number by the API,
        // e.g. "1.0363090034999E+17"
        //public let topScore: Int
        public let bonusFields: Int
    }
}
// TODO: Add remaining fields, and check xml output for more
//    donut_galaxy: bool
//    donut_system: bool
//    wf_enabled: bool
//    wf_min_res_lost: int
//    wf_min_loss_percentage: int
//    wf_repairable_percentage: int
//    global_deuterium_save_factor: float
//    bash_limit: bool
//    probe_cargo: bool
//    research_speed: int
//    new_account_dark_matter: int
//    cargo_hyperspace_tech_percentage: int
//    marketplace_enabled: bool
//    marketplace_metal_trade_ratio: float
//    marketplace_crystal_trade_ratio: float
//    marketplace_deuterium_trade_ratio: float
//    marketplace_price_range_lower: float
//    marketplace_price_range_upper: float
//    marketplace_tax_normal_user: float
//    marketplace_tax_admiral: float
//    marketplace_tax_cancel_offer: float
//    marketplace_tax_not_sold: float
//    marketplace_offer_timeout: int
//    character_classes_enabled: bool
//    miner_bonus_resource_production: float
//    miner_bonus_faster_trading_ships: float
//    miner_bonus_increased_cargo_capacity_for_trading_ships: float
//    miner_bonus_increased_additional_fleet_slots: int
//    resource_buggy_production_boost: float
//    resource_buggy_max_production_boost: float
//    resource_buggy_energy_consumption_per_unit: int
//    warrior_bonus_faster_combat_ships: float
//    warrior_bonus_faster_recyclers: float
//    warrior_bonus_recycler_fuel_consumption: float
//    combat_debris_field_limit: float
//    explorer_bonus_research_speed: float
//    explorer_bonus_increased_expedition_outcome: float
//    explorer_bonus_larger_planets: float
//    explorer_unit_items_per_day: int
//    resource_production_increase_crystal: float
//    resource_production_increase_crystal_pos1: float
//    resource_production_increase_crystal_pos2: float
//    resource_production_increase_crystal_pos3: float
