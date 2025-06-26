//
//  ProfileLayoutViewController.swift
//  ProfileLayout
//
//  Created by Artur Harutyunyan on 26.06.25.
//

import UIKit

struct User {
    let name = "Max Verstappen"
    let photo = "Max"
    let bio = "Tu Tu Tu Tu Max Verstappen"
    let followers = "14.5M"
    let following = "701"
    let posts = "33"
    var isFollowing = false
}

class ProfileLayoutViewController: UIViewController {
    private let profileUI = ProfileUI()
    private var user = User()
    private let mainStack = UIStackView()
    private let headerStack = UIStackView()
    private let statisticSection = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupMainStack()
        setupHeaderStack()
        setupBio()
        setupStatistics()
    }
}

private extension ProfileLayoutViewController {
    private func setupMainStack() {
        view.addSubview(mainStack)
        mainStack.axis = .vertical
        mainStack.spacing = 20
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            mainStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupHeaderStack() {
        mainStack.addArrangedSubview(headerStack)
        headerStack.axis = .horizontal
        headerStack.distribution = .equalSpacing
        headerStack.alignment = .center
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        
        profileUI.profilePhoto.image = UIImage(named: user.photo) ?? UIImage(systemName: "person.circle.fill")
        
        profileUI.nameLabel.text = user.name
        
        profileUI.followButton.setTitle(user.isFollowing ? "Unfollow" : "Follow", for: .normal)
        profileUI.followButton.addTarget(self, action: #selector(toggleFollow), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            profileUI.profilePhoto.widthAnchor.constraint(equalToConstant: 100),
            profileUI.profilePhoto.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        headerStack.addArrangedSubview(profileUI.profilePhoto)
        headerStack.addArrangedSubview(profileUI.nameLabel)
        headerStack.addArrangedSubview(profileUI.followButton)
    }
    
    private func setupBio() {
        profileUI.bioLabel.text = user.bio
        mainStack.addArrangedSubview(profileUI.bioLabel)
    }
    
    private func setupStatistics() {
        mainStack.addArrangedSubview(statisticSection)
        statisticSection.axis = .horizontal
        statisticSection.distribution = .equalSpacing
        statisticSection.alignment = .center
        statisticSection.translatesAutoresizingMaskIntoConstraints = false
        
        profileUI.followerCount.text = "\(user.followers)"
        profileUI.followingCount.text = "\(user.following)"
        profileUI.postsCount.text = "\(user.posts)"
        
        [profileUI.followersStack, profileUI.followingStack, profileUI.postsStack].forEach {
            statisticSection.addArrangedSubview($0)
        }
    }
    
    @objc private func toggleFollow() {
        user.isFollowing.toggle()
        updateUI()
    }
    
    private func updateUI() {
        profileUI.followButton.setTitle(user.isFollowing ? "Unfollow" : "Follow", for: .normal)
    }
}

fileprivate final class ProfileUI {
    let profilePhoto: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 50
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followButton: UIButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.filled()
        
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        config.baseBackgroundColor = .systemBlue
        btn.tintColor = .white
        btn.configuration = config
        
        return btn
    }()
    
    let bioLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    func makeStatStack(_ title: String, _ valueLabel: UILabel) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .center
        
        valueLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        valueLabel.textColor = .label
        valueLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    let followerCount = UILabel()
    lazy var followersStack: UIStackView = {
        return makeStatStack("Followers", followerCount)
    }()
    
    let followingCount = UILabel()
    lazy var followingStack: UIStackView = {
        return makeStatStack("Following", followingCount)
    }()
    
    let postsCount = UILabel()
    lazy var postsStack: UIStackView = {
        return makeStatStack("Posts", postsCount)
    }()
}

#Preview() {
    ProfileLayoutViewController()
}
