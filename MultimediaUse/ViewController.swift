//
//  ViewController.swift
//  MultimediaUse
//
//  Created by 김현수 on 2020/09/15.
//  Copyright © 2020 Hyun Soo Kim. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    //오디오 재생을 위한 객체의 참조를 저장하기 위한 변수
    var audioPlayer: AVAudioPlayer?
    
    @IBAction func videoPlay(_ sender: Any) {
        //번들(프로젝트)에 있는 비디오 파일의 경로를 생성
        let filePath = Bundle.main.path(forResource: "IPhone3G", ofType: "mov")
        //URL로 생성
        let url = URL(fileURLWithPath: filePath!)
        
        //비디오 재생기 생성
        let player = AVPlayer(url: url)
        
        //재생기를 화면에 출력
        let playerController = AVPlayerViewController()
        playerController.player = player
        //현재 화면에 추가하기
        self.addChild(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.view.frame
        //재생
        player.play()
    }
    
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
    
    //세그웨이를 이용해서 이동할 때 호출되는 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //이동할 뷰 컨트롤러 가져오기
        let destination = segue.destination as! AVPlayerViewController
        //비디오 다운로드 받을 URL 생성
        let url = URL(string: "http://www.ebookfrenzy.com/ios_book/movie/movie.mov")
        destination.player = AVPlayer(url: url!)
    }
}

