//
//  VideoPlayerView.swift
//  YoutubeClone
//
//  Created by Nikolas on 17/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import UIKit
import AVFoundation


class VideoPlayerView: UIView {
    
    
    let activityIndicatorView: UIActivityIndicatorView = {
       
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        //In order to see the activityIndicatorView:
        aiv.startAnimating()
        
        return aiv
    }()
    
    lazy var videoButton: UIButton = {
        
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //To set button's color as white:
        button.tintColor = .white
        //Till video is loaded, hide pause button:
        button.isHidden = true
        
        button.addTarget(self, action: #selector(handleVideoButton), for: .touchUpInside)
        
        return button
    }()
    
    let controlsContainerView: UIView = {
       
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        
        return view
    }()
    
    let videoLengthLabel: UILabel = {
        
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let currentTimeLabel: UILabel = {
        
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var videoSlider: UISlider = {
        
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        //To set completed part of video slider's color:
        slider.minimumTrackTintColor = .red
        //To set uncomplete part of video slider's color:
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .red
        
        //In order to keep track the progress of the video, do this:
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        
        return slider
    }()
    
    var player: AVPlayer?
    
    var isVideoPlaying = false
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        //In order not to the playerView overlaps the controlsContainerView, I add playerView before controlsContainerView.
        setupPlayerView()
        
        setupGradientLayer()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        //To center the activityIndicatorView:
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(videoButton)
        //To center the pauseButton:
        videoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        videoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        videoButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        //To put it a little more right.
        currentTimeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        //To put it a little more up.
        currentTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        backgroundColor = .black
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupPlayerView() {
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        guard let url = URL(string: urlString) else { return }
        
        player = AVPlayer(url: url)
        
        //In order to play the video, should render the video first:
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        
        player?.play()
        
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        //Track progress of video player like this:
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            
            let seconds = CMTimeGetSeconds(progressTime)
            let secondsString = String(format: "%02d", Int(seconds) % 60)
            let minutesString = String(format: "%02d", Int(seconds) / 60)
            self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
            
            //Slider moves from 0 to 1, and everytime it shows the percentage of video completed/played and find this with the current played time and the actual duration of the clip.
            //Move the slider thumb:
            guard let duration = self.player?.currentItem?.duration else { return }
            //The whole duration of the video in seconds.
            let durationInSeconds = CMTimeGetSeconds(duration)
            
            self.videoSlider.value = Float(seconds / durationInSeconds)
        })
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //This is when the player is ready and rendering frames.
        if keyPath == "currentItem.loadedTimeRanges" {
            
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            
            videoButton.isHidden = false
            
            isVideoPlaying = true
            
            guard let duration = player?.currentItem?.duration else { return }
            let seconds = CMTimeGetSeconds(duration)
            
            let secondsText = Int(seconds) % 60 //Get seconds or remainder of seconds, if seconds is 29 get 29, if seconds is 80 get 20.
            //To show a second zero in minutes, 00 instead of 0, do this:
            let minutesText = String(format: "%02d", Int(seconds) / 60)
            videoLengthLabel.text = "00:\(secondsText)"
        }
    }
    
    
    @objc func handleVideoButton() {
        
        if isVideoPlaying {
            
            player?.pause()
            
            videoButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            
            player?.play()
            
            videoButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
        isVideoPlaying = !isVideoPlaying
    }
    
    
    @objc func handleSlider() {
        
        guard let duration = player?.currentItem?.duration else { return }
        let totalSeconds = CMTimeGetSeconds(duration)
        let value = Float64(videoSlider.value) * totalSeconds
        
        let seekTime = CMTime(value: Int64(value), timescale: 1)
        
        player?.seek(to: seekTime, completionHandler: { (completedSeek) in
            
            
        })
    }
    
    
    private func setupGradientLayer() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
       //Set gradientLayer locations.
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
}
