

import UIKit

final class ProfileViewController: UIViewController {

        private let profileImageView = UIImageView()
        private let nameLabel = UILabel()
        private let usernameLabel = UILabel()
        private let descriptionLabel = UILabel()
        private let logoutButton = UIButton()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            startSetupProfileImage()
            startSetupNameProfile()
            startSetupTagNameProfile()
            startSetupDescriptionProfile()
            startSetupExitButton()
        }
        
        private func startSetupProfileImage() {
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profileImageView.clipsToBounds = true
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.image = UIImage(named: "Photo")
            
            view.addSubview(profileImageView)
            
            NSLayoutConstraint.activate([
                profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 52),
                profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                profileImageView.widthAnchor.constraint(equalToConstant: 70),
                profileImageView.heightAnchor.constraint(equalToConstant: 70)
            ])
        }
        
        private func startSetupNameProfile() {
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.text = "Екатерина Новикова"
            nameLabel.textColor = .white
            nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
            
            view.addSubview(nameLabel)
            
            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
                nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        }
        
        private func startSetupTagNameProfile() {
            usernameLabel.translatesAutoresizingMaskIntoConstraints = false
            usernameLabel.text = "@ekaterina_nov"
            usernameLabel.textColor = .gray
            usernameLabel.font = UIFont.systemFont(ofSize: 13)
            
            view.addSubview(usernameLabel)
            
            NSLayoutConstraint.activate([
                usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
                usernameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                usernameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        }
        
        private func startSetupDescriptionProfile() {
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.text = "Hello, world!"
            descriptionLabel.textColor = .white
            descriptionLabel.font = UIFont.systemFont(ofSize: 13)
            
            view.addSubview(descriptionLabel)
            
            NSLayoutConstraint.activate([
                descriptionLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
                descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
        }
        
        private func startSetupExitButton() {
            logoutButton.translatesAutoresizingMaskIntoConstraints = false
            logoutButton.setImage(UIImage(named: "ipad.and.arrow.forward"), for: .normal)
            
            view.addSubview(logoutButton)
            
            NSLayoutConstraint.activate([
                logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75),
                logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                logoutButton.widthAnchor.constraint(equalToConstant: 24),
                logoutButton.heightAnchor.constraint(equalToConstant: 24)
            ])
        }
    }
