//
//  ViewController.swift
//  MultimediaUse
//
//  Created by 김현수 on 2020/09/15.
//  Copyright © 2020 Hyun Soo Kim. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //오디오 재생을 위한 객체의 참조를 저장하기 위한 변수
    var audioPlayer: AVAudioPlayer?
    
    @IBAction func audioPlay(_ sender: Any) {
        //백그라운드에서 오디오 재생이 이어지도록 설정
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playback, mode: .default, policy: AVAudioSession.RouteSharingPolicy.longFormAudio, options: [])
        } catch let error {
            NSLog(error.localizedDescription)
        }
        
        //오디오 재생
        audioPlayer?.play()
    }
    
    @IBAction func audioStop(_ sender: Any) {
        audioPlayer?.stop()
    }
    
    @IBAction func changeVolumn(_ sender: Any) {
        let slider = sender as! UISlider
        audioPlayer?.volume = slider.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //재생할 음원 파일의 URL을 생성
        //번들의 test.mp3
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: ".mp3")!, relativeTo: nil)
        //오디오 재생기 초기화
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        //재생 준비
        audioPlayer!.prepareToPlay()
    }


}

