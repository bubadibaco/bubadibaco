//
//  GameViewController.swift
//  bubadibaco
//
//  Created by Michael Eko on 15/07/24.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    public var backgroundMusicPlayer: AVAudioPlayer?
    private let stories = ["Terry and Trixie", "Locked Story", "Locked Story"]
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "HomeBackground")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        setupCollectionView()
        playBackgroundMusic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        collectionView.contentInsetAdjustmentBehavior = .never
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width - 60, height: view.frame.height)
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: StoryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "mainMusic", withExtension: "mp3") else { return }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.volume = 0.5
            backgroundMusicPlayer?.play()
        } catch {
            print("Error playing background music: \(error)")
        }
    }
}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.identifier, for: indexPath) as! StoryCollectionViewCell
        let isUnlocked = indexPath.item == 0
        cell.configure(with: stories[indexPath.item], isUnlocked: isUnlocked)
        cell.imageStory.isUserInteractionEnabled = isUnlocked
        if isUnlocked {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playButtonTapped(_:)))
            cell.imageStory.addGestureRecognizer(tapGesture)
            cell.imageStory.tag = indexPath.item
        }
        return cell
    }
    
    @objc func playButtonTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        print("Play button tapped for story at index \(index)")
        
        let chooseAvatarVC = ChooseAvatarViewController()
        chooseAvatarVC.modalPresentationStyle = .fullScreen
        present(chooseAvatarVC, animated: true, completion: nil)
    }
}

class StoryCollectionViewCell: UICollectionViewCell {

    static let identifier = "StoryCollectionViewCell"
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let storyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageStory: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        
        contentView.addSubview(cardView)
        cardView.addSubview(imageStory)
        cardView.addSubview(storyLabel)
        
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cardView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            cardView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            imageStory.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            imageStory.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            imageStory.widthAnchor.constraint(equalTo: cardView.widthAnchor),
            imageStory.heightAnchor.constraint(equalTo: cardView.heightAnchor),
            
            storyLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            storyLabel.topAnchor.constraint(equalTo: imageStory.bottomAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with story: String, isUnlocked: Bool) {
        storyLabel.text = story
        
        if isUnlocked {
            imageStory.image = UIImage(named: "unlockedImage")
        } else {
            imageStory.image = UIImage(named: "lockedImage")
        }
    }
}
