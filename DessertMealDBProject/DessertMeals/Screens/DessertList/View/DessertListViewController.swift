//
//  DessertListViewController.swift
//  DessertMeals
//

import UIKit

class DessertListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var viewModel = DessertListViewModel()
    var dessertData: Desserts?
    var filteredData: [Meal] = []
    var cellTapped: Int?
    
    @IBOutlet weak var dessertListTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Desserts"
        parseDesserts()
        registerCells()
        setTableViewSearchBarDelegates()
    }
    
    private func parseDesserts() {
        viewModel.getAllDesserts { [weak self] in
            self?.dessertData = self?.viewModel.dessertListModel
            self?.filteredData = (self?.viewModel.dessertListModel!.meals)!
            DispatchQueue.main.async {
                self?.dessertListTableView.reloadData()
            }
        }
    }
    
    private func registerCells() {
        let nib = UINib(nibName: "DessertListTableViewCell", bundle: nil)
        dessertListTableView.register(nib, forCellReuseIdentifier: "DessertListTableViewCell")
    }
    
    private func setTableViewSearchBarDelegates() {
        dessertListTableView.dataSource = self
        dessertListTableView.delegate = self
        searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
   }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellTapped = indexPath.row
        performSegue(withIdentifier: "showDetailView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dessertListTableView.dequeueReusableCell(withIdentifier: "DessertListTableViewCell", for: indexPath) as? DessertListTableViewCell else {
            return UITableViewCell()
        }
        let dessertModel = filteredData[indexPath.row]
        cell.setDessertData(mealModel: dessertModel)
//        cell.mealModel = dessertModel
        return cell
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DessertDetailViewController {
            destination.idMeal = (filteredData[cellTapped!].idMeal)
            dessertListTableView.deselectRow(at: dessertListTableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        guard let dessertData = dessertData else {
            return
        }
        if searchText.isEmpty {
            filteredData = dessertData.meals
        } else {
            for dessert in dessertData.meals {
                if dessert.strMeal.uppercased().contains(searchText.uppercased()) {
                    filteredData.append(dessert)
                }
            }
        }
        self.dessertListTableView.reloadData()
    }
}
