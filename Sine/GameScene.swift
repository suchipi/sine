//
//  GameScene.swift
//  Sine
//
//  Created by Stephen Scott on 9/11/17.
//  Copyright © 2017 Stephen Scott. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    private var frequencyLabel: SKLabelNode?
    private var noteNameLabel: SKLabelNode?
    private let engine = AVAudioEngine.init()
    private let player = AVTonePlayerUnit.init()
    
    override func didMove(to view: SKView) {
        self.frequencyLabel = self.childNode(withName: "frequencyLabel") as? SKLabelNode
        self.noteNameLabel = frequencyLabel?.childNode(withName: "noteNameLabel") as? SKLabelNode
        
        frequencyLabel?.text = ""
        noteNameLabel?.text = ""
        
        player.amplitude = 1.0
        player.frequency = 880
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
    
    func updateRate(fromPoint point: CGPoint) {
        // Bottom of the screen should be 0, middle should be 1, top should be 2
        let rate = (((0.5 * self.size.height) + point.y) / self.size.height) * 2 // 0.0 to 2.0, where 1.0 is normal speed
        let frequency = Double(880 * rate)
        player.frequency = frequency
        frequencyLabel?.text = NSString(format: "%.0fHz", frequency) as String
        
        if let noteName = FrequencyTable.getNoteName(frequency: frequency) {
            noteNameLabel?.text = noteName as String
        }
    }
    
    func updateVolume(fromPoint point: CGPoint) {
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
    
    func touchMoved(toPoint point: CGPoint) {
        updateRate(fromPoint: point)
        updateVolume(fromPoint: point)
    }
    
    func touchUp(atPoint pos: CGPoint) {
        player.pause()
        player.reset()
        frequencyLabel?.text = ""
        noteNameLabel?.text = ""
    }
    
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
}
