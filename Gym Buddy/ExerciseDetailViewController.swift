import UIKit

class ExerciseDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var muscleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var toggleButton: UIButton!
    
    var exercise: Exercise?
    var isExpanded = false
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Exercise Detail"
            styleNavigationBar()
            
            instructionsTextView.isScrollEnabled = true
            instructionsTextView.isEditable = false
            instructionsTextView.isSelectable = true
            
            view.backgroundColor = .gymBackground
            instructionsTextView.backgroundColor = .gymBackground
            
            nameLabel.textColor = .white
            muscleLabel.textColor = .white
            typeLabel.textColor = .white
            difficultyLabel.textColor = .white

            instructionsTextView.textColor = .white
            instructionsTextView.backgroundColor = .gymBackground
            
            if let exercise = exercise {
                nameLabel.text = exercise.name
                muscleLabel.text = "Target: \(exercise.target)"
                typeLabel.text = "Equipment: \(exercise.equipment)"
                difficultyLabel.text = "Difficulty: \(exercise.difficultyText)"
            }
            updateInstructions()
        }
    func updateInstructions() {
        guard let exercise = exercise else { return }
        
        let formatted = exercise.instructionsText
        
        if isExpanded {
            instructionsTextView.text = formatted
            toggleButton.setTitle("Show Less", for: .normal)
        } else {
            instructionsTextView.text = formatted.shortened(to: 200)
            toggleButton.setTitle("Show More", for: .normal)
        }
    }
    
    
    @IBAction func toggleTapped(_ sender: UIButton) {
        isExpanded.toggle()
        updateInstructions()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let exercise = exercise else { return }
        
        var favorites = FavoritesManager.shared.loadFavorites()
        
        let alreadySaved = favorites.contains { $0.name == exercise.name && $0.type == exercise.type }
        
        if !alreadySaved {
            favorites.append(exercise)
            FavoritesManager.shared.saveFavorites(favorites)
        }
        
        let alert = UIAlertController(title: "Saved", message: "Exercise added to favorites.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    func styleNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gymBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
    }
}
