//
//  PersistenceManager.swift
//  Valebat
//
//  Created by Zhang Yifan on 2/4/21.
//

import Foundation

class PersistenceManager {

    static private var instance: PersistenceManager!

    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }

    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("gamedata.json")
    }

    var gameData: GameData?

    static func getInstance() -> PersistenceManager {
        if instance == nil {
            initialise()
        }
        return instance
    }

    static private func initialise() {
        self.instance = PersistenceManager()
    }

    func load() {
        let entityManager = EntityManager.getInstance()
        guard let data = try? Data(contentsOf: Self.fileURL) else {
            entityManager.initialiseMaps()
            entityManager.initialiseGraph()
            self.gameData = GameData(levelData: LevelData(), playerData: PlayerData())
            saveAllData()
            return
        }
        guard let gameData = try? JSONDecoder().decode(GameData.self, from: data) else {
            fatalError("Can't decode saved data.")
        }

        self.gameData = gameData
        gameData.playerData.assignPlayerStats()
        gameData.levelData.assignLevelData()
        entityManager.addMapEntities()
        entityManager.initialiseGraph()
    }

    private func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let gameData = self?.gameData else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(gameData) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
                print("saved to file")
            } catch {
                fatalError("Can't write to file")
            }
        }
    }

    private func assignPlayerDataToStorage() {
        let playerStats = PlayerStatsManager.getInstance()
        let playerData = playerStats.convertToPlayerData()
        gameData?.playerData = playerData
    }

    private func assignLevelDataToStorage() {
        let levelData = LevelData(maps: MapUtil.maps, levelDataMap: LevelListUtil.levelDataMap)
        gameData?.levelData = levelData
    }

    func savePlayerData() {
        assignPlayerDataToStorage()
        save()
    }

    func saveLevelData() {
        assignLevelDataToStorage()
        save()
    }

    func saveAllData() {
        assignPlayerDataToStorage()
        assignLevelDataToStorage()
        save()
    }

}
