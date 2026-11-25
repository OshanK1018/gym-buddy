import UIKit

class HomeViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let bodyPartLabel = UILabel()
    let muscleTextField = UITextField()
    let searchButton = UIButton(type: .system)
    let favoritesButton = UIButton(type: .system)
    let aboutTitleLabel = UILabel()
    let aboutTextLabel = UILabel()
    let howToTitleLabel = UILabel()
    let howToTextLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        //        view.backgroundColor = UIColor(
        //                red: 17/255,
        //                green: 24/255,
        //                blue: 39/255,
        //                alpha: 1
        //            )
        //            contentView.backgroundColor = view.backgroundColor
        view.backgroundColor = .gymBackground
        scrollView.backgroundColor = .gymBackground
        contentView.backgroundColor = .gymBackground
        setupUI()
    }
    
    func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let views = [
            titleLabel,
            subtitleLabel,
            bodyPartLabel,
            muscleTextField,
            searchButton,
            favoritesButton,
            aboutTitleLabel,
            aboutTextLabel,
            howToTitleLabel,
            howToTextLabel
        ]
        
        for item in views {
            item.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(item)
        }
        
        titleLabel.text = "GYM BUDDY"
        titleLabel.font = UIFont(name: "BebasNeue-Regular", size: 48) ?? .boldSystemFont(ofSize: 48)
        titleLabel.textAlignment = .center
        
        subtitleLabel.text = "Find Exercises"
        subtitleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        
        bodyPartLabel.text = "Body Part"
        bodyPartLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        muscleTextField.placeholder = "chest, back, shoulders, upper arms"
        muscleTextField.borderStyle = .roundedRect
        muscleTextField.autocapitalizationType = .none
        muscleTextField.textColor = .white
        muscleTextField.tintColor = .white
        muscleTextField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.backgroundColor = .systemBlue
        searchButton.tintColor = .white
        searchButton.layer.cornerRadius = 12
        searchButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        
        favoritesButton.setTitle("View Favorites", for: .normal)
        favoritesButton.backgroundColor = .systemGreen
        favoritesButton.tintColor = .white
        favoritesButton.layer.cornerRadius = 12
        favoritesButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        favoritesButton.addTarget(self, action: #selector(favoritesTapped), for: .touchUpInside)
        
        aboutTitleLabel.text = "About Gym Buddy"
        aboutTitleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        
        aboutTextLabel.text = "Gym Buddy is an exercise reference app that helps users find exercises by body part. Gym Buddy allows you to look up exercises for the body part you enter. You will get a list of names of exercises for that body part with the equipment needed, a difficulty indicator, and instructions on how to properly execute the exercise. Proper form is everything in the gym to avoid injuries and to create actual progress in the gym."
        aboutTextLabel.font = .systemFont(ofSize: 16)
        aboutTextLabel.numberOfLines = 0
        
        howToTitleLabel.text = "How to Use"
        howToTitleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        
        howToTextLabel.text = """
        Type one of the supported body parts into the search box, then tap Search. Tap an exercise to see instructions. Tap Save to Favorites to keep it for later. Your favorites can be seen in the home page when you press the View Favorties button.
        
        Supported body parts:
        Chest, Back, Shoulders, Upper arms, Lower arms, Upper legs, Lower legs, Waist, Cardio, Neck
        """
        howToTextLabel.font = .systemFont(ofSize: 16)
        howToTextLabel.numberOfLines = 0
        titleLabel.textColor = .white
        subtitleLabel.textColor = .white
        bodyPartLabel.textColor = .white
        aboutTitleLabel.textColor = .white
        aboutTextLabel.textColor = .white
        howToTitleLabel.textColor = .white
        howToTextLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 45),
            subtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            subtitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            
            bodyPartLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 35),
            bodyPartLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            bodyPartLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            
            muscleTextField.topAnchor.constraint(equalTo: bodyPartLabel.bottomAnchor, constant: 10),
            muscleTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            muscleTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            muscleTextField.heightAnchor.constraint(equalToConstant: 48),
            
            searchButton.topAnchor.constraint(equalTo: muscleTextField.bottomAnchor, constant: 35),
            searchButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            searchButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            searchButton.heightAnchor.constraint(equalToConstant: 52),
            
            favoritesButton.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 16),
            favoritesButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            favoritesButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            favoritesButton.heightAnchor.constraint(equalToConstant: 52),
            
            aboutTitleLabel.topAnchor.constraint(equalTo: favoritesButton.bottomAnchor, constant: 45),
            aboutTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            aboutTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            
            aboutTextLabel.topAnchor.constraint(equalTo: aboutTitleLabel.bottomAnchor, constant: 10),
            aboutTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            aboutTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            
            howToTitleLabel.topAnchor.constraint(equalTo: aboutTextLabel.bottomAnchor, constant: 35),
            howToTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            howToTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            
            howToTextLabel.topAnchor.constraint(equalTo: howToTitleLabel.bottomAnchor, constant: 10),
            howToTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            howToTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            howToTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    @objc func searchTapped() {
        print("Search tapped")
        
        let muscle = muscleTextField.text ?? ""
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let resultsVC = storyboard.instantiateViewController(withIdentifier: "ResultsViewController") as? ResultsViewController {
            resultsVC.muscle = muscle
            resultsVC.type = ""
            resultsVC.difficulty = ""
            navigationController?.pushViewController(resultsVC, animated: true)
        } else {
            print("Could not open ResultsViewController")
        }
    }
    
    @objc func favoritesTapped() {
        print("Favorites tapped")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let favoritesVC = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController") as? FavoritesViewController {
            navigationController?.pushViewController(favoritesVC, animated: true)
        } else {
            print("Could not open FavoritesViewController")
        }
    }
}
    extension UIColor {
        static let gymBackground = UIColor(
            red: 0.067,
            green: 0.094,
            blue: 0.153,
            alpha: 1.0
        )
    }

