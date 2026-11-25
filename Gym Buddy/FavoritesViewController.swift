import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favorites: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        styleNavigationBar()
        
        view.backgroundColor = .gymBackground
        tableView.backgroundColor = .gymBackground
        tableView.separatorColor = .darkGray
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites = FavoritesManager.shared.loadFavorites()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "FavoriteCell")
        cell.backgroundColor = .gymBackground
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .lightGray
        let exercise = favorites[indexPath.row]
        
        cell.textLabel?.text = exercise.name
        cell.detailTextLabel?.text = "\(exercise.bodyPart) • \(exercise.target)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favorites.remove(at: indexPath.row)
            FavoritesManager.shared.saveFavorites(favorites)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedExercise = favorites[indexPath.row]
            
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
