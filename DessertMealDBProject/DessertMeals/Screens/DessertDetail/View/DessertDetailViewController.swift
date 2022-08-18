//
//  DessertDetailViewController.swift
//  DessertMeals
//

import UIKit

class DessertDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var idMeal: String = ""
    var dessertDetailData: DessertDetail?
    let viewModel = DessertDetailViewModel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var dessertDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseDetails()
        registerCells()
        setDetailTableViewDelegates()
    }
    
    private func parseDetails() {
        viewModel.getDessertDetails(idMeal: idMeal) { [weak self] in
            self?.dessertDetailData = self?.viewModel.dessertDetailModel
            DispatchQueue.main.async {
                self?.dessertDetailTableView.reloadData()
            }
        }
    }
    
    private func registerCells() {
        let nib = UINib(nibName: "DessertDetailTableViewCell", bundle: nil)
        dessertDetailTableView.register(nib, forCellReuseIdentifier: "DessertDetailTableViewCell")
    }
    
    private func setDetailTableViewDelegates() {
        dessertDetailTableView.dataSource = self
        dessertDetailTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dessertDetailData?.meals.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DessertDetailTableViewCell", for: indexPath) as? DessertDetailTableViewCell else {
            return UITableViewCell()
        }
        if let dessertDetailModel = self.dessertDetailData?.meals[indexPath.row] {
            cell.setDessertDetailData(mealDetailModel: dessertDetailModel)
//            cell.mealDetailModel = dessertDetailModel
        }
       
        if dessertDetailData != nil {
            title = (dessertDetailData?.meals[indexPath.row].strMeal)!
        }
        return cell
    }

}
