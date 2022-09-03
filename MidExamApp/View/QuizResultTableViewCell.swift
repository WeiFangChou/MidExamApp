//
//  QuizResultTableViewCell.swift
//  MidExamApp
//
//  Created by WeiFangChou on 2022/8/24.
//

import UIKit

class QuizResultTableViewCell: UITableViewCell {
    
    let Identifier = "QuizResultCell"

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var correctImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
