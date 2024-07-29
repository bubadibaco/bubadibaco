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
    private var collectionView: UICollectionView!
    private var stories: [Story] {
        return StoryManager.shared.stories
    }
    
    private var carImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "HomeBackground")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        setupCollectionView()
        setupCarAnimation()
        playBackgroundMusic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.reloadData()
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: StoryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 0
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }

    private func setupCarAnimation() {
        carImageView = UIImageView(image: UIImage(named: "car"))
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        carImageView.contentMode = .scaleAspectFit
        view.addSubview(carImageView)
        
        NSLayoutConstraint.activate([
            carImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -100),
            carImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            carImageView.widthAnchor.constraint(equalToConstant: 150),
            carImageView.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        view.layoutIfNeeded()
        animateCar()
    }

    private func animateCar() {
        let initialPosition = carImageView.frame.origin.x
        print("Initial car position: \(initialPosition)")
        
        UIView.animate(withDuration: 5.0, delay: 0, options: [.curveLinear, .repeat], animations: {
            self.carImageView.frame.origin.x = self.view.frame.width
        }) { _ in
            print("Animation completed")
            self.carImageView.frame.origin.x = initialPosition
            self.animateCar()
        }
    }
    
    private func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "mainMusic", withExtension: "mp3") else {
            print("Error: Background music file not found!")
            return
        }
        
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
        let story = stories[indexPath.item]
        cell.configure(with: story)
        cell.imageStory.isUserInteractionEnabled = story.isUnlocked
        if story.isUnlocked {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playButtonTapped(_:)))
            cell.imageStory.addGestureRecognizer(tapGesture)
            cell.imageStory.tag = indexPath.item
        }
        return cell
    }
    
    @objc func playButtonTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        let selectedStory = stories[index]
        print("Play button tapped for story: \(selectedStory.name)")
        
        if selectedStory.name == "Terry or Trixie's House" {
            StoryManager.shared.unlockNextStory(after: selectedStory)
            collectionView.reloadData()
        }

        let chooseAvatarVC = ChooseAvatarViewController()
        chooseAvatarVC.modalPresentationStyle = .fullScreen
        present(chooseAvatarVC, animated: true, completion: nil)
    }
}

class StoryCollectionViewCell: UICollectionViewCell {

    static let identifier = "StoryCollectionViewCell"
    
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
        
        contentView.addSubview(imageStory)
        contentView.addSubview(storyLabel)
        
        NSLayoutConstraint.activate([
            imageStory.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageStory.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30),
            imageStory.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            imageStory.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            storyLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            storyLabel.topAnchor.constraint(equalTo: imageStory.bottomAnchor, constant: 10),
            storyLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with story: Story) {
        storyLabel.text = story.name
        
        if story.isUnlocked {
            imageStory.image = UIImage(named: "unlockedImage")
        } else {
            imageStory.image = UIImage(named: "lockedImage")
        }
    }
}
