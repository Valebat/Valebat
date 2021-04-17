//
//  ClientScnee.swift
//  Valebat
//
//  Created by Sreyans Sipani on 17/4/21.
//

import SpriteKit
import GameplayKit

class ClientScene: SKScene {

    weak var viewController: ClientViewController?

    var coopManager: CoopManager?

    var inputHUDDisplay: UserInputNode!
    var playerHUDDisplay: PlayerHUD!
    private var lastUpdateTime: TimeInterval = 0

    var userInputInfo: UserInputInfo = UserInputInfo()

    override func sceneDidLoad() {
        self.lastUpdateTime = 0
//        self.coopManager = CoopManager()
        setUpScene()
    }

    func touchDown(atPoint pos: CGPoint) {

    }

    func touchMoved(toPoint pos: CGPoint) {

    }

    func touchUp(atPoint pos: CGPoint) {

    }

    private func setUpScene() {
        setUpUserInputHUD()
        setUpPlayerHUD()
    }

    private func setUpPlayerHUD() {
        guard let refNode = SKReferenceNode(fileNamed: "PlayerHUD") else {
            return
        }
        addChild(refNode)
        refNode.position = CGPoint(x: size.width/2, y: size.height/2)
        guard let baseNode = refNode.childNode(withName: "//baseHUD") as? PlayerHUD else {
            return
        }
        playerHUDDisplay = baseNode
        baseNode.xScale = size.width / baseNode.frame.width
        baseNode.yScale = size.height / baseNode.frame.height
    }

    private func setUpUserInputHUD() {
        inputHUDDisplay = UserInputNode(screenSize: self.size)
        addChild(inputHUDDisplay)
        inputHUDDisplay.userInputInfo = userInputInfo
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint: touch.location(in: self)) }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchMoved(toPoint: touch.location(in: self)) }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchUp(atPoint: touch.location(in: self)) }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchUp(atPoint: touch.location(in: self)) }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        // Initialize _lastUpdateTime if it has not already been
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }
        // Calculate time since last update
        let deltaTime = currentTime - self.lastUpdateTime
        AudioManager.update(seconds: deltaTime)

        renderSprites(sprites: loadSpriteData())

        self.lastUpdateTime = currentTime

    }

    // Gives sprites which have changed
    func loadSpriteData() -> Set<SpriteData> {
        // TODO: Fetch from coop manager
        let sampleSprite = SpriteData(idx: UUID(), name: "character",
                                      width: Float(ViewConstants.playerWidth),
                                      height: Float(ViewConstants.playerHeight),
                                      xPos: 100.0, yPos: 100.0, orientation: 0.0)
        return [sampleSprite]
    }

    func renderSprites(sprites: Set<SpriteData>) {
        self.removeAllChildren()
        setUpScene()
        for sprite in sprites {
            let spriteNode = SKSpriteNode(texture: CustomTexture.initialise(imageNamed: sprite.name),
                                          color: SKColor.white,
                                          size: CGSize(width: CGFloat(sprite.width),
                                                       height: CGFloat(sprite.height)))
            spriteNode.position = CGPoint(x: CGFloat(sprite.xPos), y: CGFloat(sprite.yPos))
            spriteNode.zRotation = CGFloat(sprite.orientation)
            addChild(spriteNode)
        }
    }

    // Fix this - makes no sense but didn't compile without :(
    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
