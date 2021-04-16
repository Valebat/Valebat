//
//  PersistenceManager.swift
//  Valebat
//
//  Created by Zhang Yifan on 2/4/21.
//

import Foundation

class PersistenceManager {

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
    weak var gameSession: GameSession?

    func load() {
        guard let gameSession = self.gameSession else {
            return
        }
        guard let data = try? Data(contentsOf: Self.fileURL) else {
            loadInitialData()
            return
        }
        guard let gameData = try? JSONDecoder().decode(GameData.self, from: data) else {
            do {
                let outfile = Self.fileURL
                try FileManager.default.removeItem(at: outfile)
                loadInitialData()
            } catch {
                fatalError("Can't write to file")
            }
            return
        }
        let entityManager = gameSession.entityManager

        self.gameData = gameData
        gameData.playerData.assignPlayerStats(gameSession: gameSession)
        gameData.levelData.assignLevelData(gameSession: gameSession)
        entityManager.immediateAddMapEntities()
        entityManager.initialiseGraph()
        entityManager.initialiseObservers()
    }

    func loadInitialData() {
        gameSession?.entityManager.setup()
        self.gameData = GameData(levelData: LevelData(), playerData: PlayerData())
        saveAllData()
    }

    private func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let gameData = self?.gameData else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(gameData) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }

    private func assignPlayerDataToStorage() {
        guard let gameSession = self.gameSession else {
            return
        }
        let playerData = PlayerData.convertToPlayerData(gameSession: gameSession)
        gameData?.playerData = playerData
    }

    private func assignLevelDataToStorage() {
        guard let gameSession = self.gameSession else {
            return
        }
        let levelData = LevelData(maps: gameSession.mapManager.maps, gameSession: gameSession)
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
