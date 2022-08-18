//
//  DessertListTableViewCell.swift
//  DessertMeals
//

import UIKit

class DessertListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dessertName: UILabel!
    @IBOutlet weak var dessertImage: UIImageView!
    
    let viewModel = DessertListViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dessertName.text = nil
        dessertImage.image = nil
    }
    
    func setDessertData(mealModel: Meal?) {
        if let mealModel = mealModel {
            dessertName.text = viewModel.configureName(model: mealModel)
            dessertImage.downloadImage(urlString: viewModel.configureImageUrl(model: mealModel))
        }
    }
}
