//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Abdalla Elshikh on 4/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController : UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder:AVAudioRecorder!

    //defining outlets
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stopRecordButton.isEnabled = false //disable record button

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func recordAudio(_ sender: Any) {
        //setup
        recordLabel.text = "Started Recording"
        stopRecordButton.isEnabled = true
        recordButton.isEnabled = false
        //start recording
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        //stop recording
        recordLabel.text = "Tap to Record"
        recordButton.isEnabled = true
        stopRecordButton.isEnabled = false
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        //if finished recording perform segue
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //prepare for segue and send audio URL
        if segue.identifier == "stopRecording"{
            let playSoundsViewController = segue.destination as! PlaySoundsViewController //instantiate Playsound VC
            let recordedAudioURL = sender as! URL //set url
            playSoundsViewController.recordedAudioURL = recordedAudioURL
            
        }
    }
    
}

