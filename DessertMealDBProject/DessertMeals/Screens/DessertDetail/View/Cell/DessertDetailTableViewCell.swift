//
//  DessertDetailTableViewCell.swift
//  DessertMeals
//

import UIKit

class DessertDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredientTitle: UILabel!
    @IBOutlet weak var measurementTitle: UILabel!
    @IBOutlet weak var ingredient: UILabel!
    @IBOutlet weak var measure: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var instructionsTitle: UILabel!
    
    let viewModel = DessertDetailViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ingredient.text = nil
        ingredientTitle.text = nil
        measure.text = nil
        measurementTitle.text = nil
        instructionsLabel.text = nil
        instructionsTitle.text = nil
    }
    
    func setDessertDetailData(mealDetailModel: MealDetails?) {
        let result = viewModel.configureTitles()
        ingredientTitle.text = result.ingredientTitle
        measurementTitle.text = result.measurementTitle
        instructionsTitle.text = result.instructionsTitle
        if let mealDetailModel = mealDetailModel {
            ingredient.text = viewModel.configureIngredients(model: mealDetailModel)
            measure.text = viewModel.configureMeasurements(model: mealDetailModel)
            instructionsLabel.text = viewModel.configureInstructions(model: mealDetailModel)
        }
    }
}
