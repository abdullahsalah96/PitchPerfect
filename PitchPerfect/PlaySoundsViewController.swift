//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Abdalla Elshikh on 4/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //adding outlets
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    //audio play params
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    //Buttons enums (tags)
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //retain aspect ratio to handle different screens and orientations
        // Do any additional setup after loading the view.
        snailButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        vaderButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit
        //setup audio playing
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying) //not playing audio
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton){
        //play sound based on button tag
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopButton(_ sender: UIButton){
        //stop playing sound
        stopAudio()
    }
}
