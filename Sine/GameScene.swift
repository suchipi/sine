import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    private var frequencyLabel: SKLabelNode?
    private var noteNameLabel: SKLabelNode?
    private let engine = AVAudioEngine.init()
    private let player = AVTonePlayerUnit.init()
    
    // MARK: - Lifecycle methods
    override func didMove(to view: SKView) {
        self.frequencyLabel = self.childNode(withName: "frequencyLabel") as? SKLabelNode
        self.noteNameLabel = frequencyLabel?.childNode(withName: "noteNameLabel") as? SKLabelNode
        
        frequencyLabel?.text = ""
        noteNameLabel?.text = ""
        
        player.amplitude = 1.0
        player.frequency = 440
        engine.attach(player)
        engine.connect(player, to: engine.mainMixerNode, format: AVAudioFormat.init(standardFormatWithSampleRate: player.sampleRate, channels: 1))
        engine.prepare()
        do {
            try engine.start()
        } catch {
            fatalError("Could not start engine")
        }
    }
    
    override func willMove(from view: SKView) {
        engine.stop()
    }
    
    // MARK: - Touch lifecycle methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    // MARK: - Helpers
    private func updateRate(fromPoint point: CGPoint) {
        // Bottom of the screen should be 0, top should be 1
        let screenPos = ((0.5 * self.size.height) + point.y) / self.size.height
        
        let minNote = FrequencyTable.getFrequency("A3");
        let maxNote = FrequencyTable.getFrequency("C8");
        
        let frequency = Double(minNote + (maxNote - minNote) * Double(pow(screenPos, 2)));
        
        player.frequency = frequency;
        frequencyLabel?.text = NSString(format: "%.0fHz", frequency) as String
        
        if let noteName = FrequencyTable.getNoteName(frequency: frequency) {
            noteNameLabel?.text = noteName as String
        }
    }
    
    private func updateVolume(fromPoint point: CGPoint) {
        // Left side of the screen should be 0, right side of the screen should be 1
        let volume = ((0.5 * self.size.width) + point.x) / self.size.width
        player.amplitude = Double(volume)
    }
    
    func touchDown(atPoint point: CGPoint) {
        updateRate(fromPoint: point)
        updateVolume(fromPoint: point)
        
        player.preparePlaying()
        player.play()
    }
    
    private func touchMoved(toPoint point: CGPoint) {
        updateRate(fromPoint: point)
        updateVolume(fromPoint: point)
    }
    
    private func touchUp(atPoint pos: CGPoint) {
        player.pause()
        player.reset()
        frequencyLabel?.text = ""
        noteNameLabel?.text = ""
    }
}
