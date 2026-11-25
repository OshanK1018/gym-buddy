import UIKit

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var muscle: String = ""
    var type: String = ""
    var difficulty: String = ""
    
    var exercises: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Results"
        styleNavigationBar()
        
        view.backgroundColor = .gymBackground
        tableView.backgroundColor = .gymBackground
        tableView.separatorColor = .darkGray
        
        tableView.dataSource = self
        tableView.delegate = self
           
        loadExercises()
    }
    
    func loadExercises() {
        APIManager.shared.fetchExercises(muscle: muscle, type: type, difficulty: difficulty) { [weak self] exercises in
            DispatchQueue.main.async {
                self?.exercises = exercises
                self?.tableView.reloadData()
                
                if exercises.isEmpty {
                    let alert = UIAlertController(
                        title: "No Results",
                        message: "Try chest, back, shoulders, upper arms, lower arms, upper legs, lower legs, waist, cardio, or neck.",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ResultCell")
        cell.backgroundColor = .gymBackground
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .lightGray
        let exercise = exercises[indexPath.row]
        
        cell.textLabel?.text = exercise.name
        cell.detailTextLabel?.text = "\(exercise.bodyPart) • \(exercise.target)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedExercise = exercises[indexPath.row]
        
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "ExerciseDetailViewController") as? ExerciseDetailViewController {
            detailVC.exercise = selectedExercise
            navigationController?.pushViewController(detailVC, animated: true)
        }
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
