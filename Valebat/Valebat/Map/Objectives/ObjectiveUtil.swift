//
//  ObjectiveUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 8/4/21.
//

class ObjectiveUtil {
    static func createObjectiveFromBiomeType(_ biomeType: BiomeTypeEnum) -> Objective {
        let biomeData: BiomeData = BiomeTypeEnum.getBiomeDataFromType(biomeType)
        return createObjectiveFromBiomeData(biomeData)
    }

    static func createObjectiveFromBiomeData(_ biomeData: BiomeData) -> Objective {
        return Objective(possibleTypes: biomeData.objectiveTypes, quantity: biomeData.objectiveQuantity)
    }
}
