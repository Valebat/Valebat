import SpriteKit
import GameplayKit

class SpellComponent: SpriteComponent {
    override func update(deltaTime seconds: TimeInterval) {
        print("update")
        self.node.position = CGPoint(x: self.node.position.x, y: self.node.position.y)
    }
}
