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
        collectionView.reloadData() 
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .none
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
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return UICollectionViewCompositionalLayout(section: section)
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
        
        if selectedStory.name == "Terry and Trixie" {
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
            cardView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            cardView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            imageStory.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            imageStory.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            imageStory.widthAnchor.constraint(equalTo: cardView.widthAnchor),
            imageStory.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.8),
            
            storyLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            storyLabel.topAnchor.constraint(equalTo: imageStory.bottomAnchor, constant: 10),
            storyLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor)
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
