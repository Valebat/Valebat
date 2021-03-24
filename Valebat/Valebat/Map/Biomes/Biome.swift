//
//  Biome.swift
//  Valebat
//
//  Created by Jing Lin Shi on 24/3/21.
//

protocol Biome {
    var biomeType: BiomeTypeEnum { get }

    init()

    func getBiomeData() -> BiomeData
}
