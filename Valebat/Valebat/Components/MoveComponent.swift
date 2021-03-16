import SpriteKit
import GameplayKit

class MoveComponent: GKComponent {

    private var node: SKSpriteNode {
        guard let node = entity?.component(ofType: SpriteComponent.self)?.node else {
            fatalError("This entity don't have node")
        }
        return node
    }

    override init() {
        super.init()
    }

    func move(to position: CGPoint) {
        node.run(SKAction.move(to: position, duration: 0.5))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
