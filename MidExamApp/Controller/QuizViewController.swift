//
//  QuizViewController.swift
//  MidExamApp
//
//  Created by WeiFangChou on 2022/8/10.
//

import UIKit



class QuizViewController: UIViewController {
    
    var quizIndex = 0
    var quizs:[Quiz] = []
    var usersQuizsAnswer:[Int] = []
    
    @IBOutlet weak var quizImageView: UIImageView!
    
    @IBOutlet weak var quizIndexlabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet var answerButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateUI()
    }
    
    
    func updateUI() {
            changeQuiz(index: quizIndex)
    }
    
    func changeQuiz(index: Int) {
        if index >= quizs.count {
            let alertController = UIAlertController(title: "Done", message: "Done?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Yes !", style: .default) { alertAction in
                print("OK")
                self.performSegue(withIdentifier: "showResult", sender: nil)
            }
            let cancelAction = UIAlertAction(title: "No !", style: .default) { alertAction in
                print("Cancel")
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
        }else{
//            print(index)
            let colors:[UIColor] = [.systemRed,.systemBlue,.systemOrange,.systemGreen].shuffled()
            //quizImageView.image = UIImage(named: quizs[index].imageUrl)
            questionLabel.text = quizs[index].question
            for i in 0..<4 {
                answerButton[i].setTitle(quizs[index].answers[i].option, for: .normal)
                answerButton[i].backgroundColor = colors[i]
                answerButton[i].tag = i
            }
            quizIndexlabel.text = "\(index+1) / \(self.quizs.count)"
            
        }
    }
    
    @IBAction func answerButtonClick(_ sender: UIButton) {
        let buttonIndex = sender.tag
        quizIndex += 1
        
        switch buttonIndex {
        case 0...3:
            changeQuiz(index: quizIndex)
            usersQuizsAnswer.append(buttonIndex)
        default:
            break
        }
        
    }
    @IBAction func nextandlastButtonClick(_ sender: UIButton) {
        switch sender.tag{
            case 0:
                quizIndex -= 1
                if(quizIndex < 0){
                    quizIndex = quizs.count - 1
                }
                changeQuiz(index: quizIndex)
                break
            case 1:
                quizIndex += 1
                if(quizIndex > quizs.count - 1){
                    quizIndex = 0
                }
                changeQuiz(index: quizIndex)
                break
        default:
            break
        }
    }
    
    func doneQuiz(quizs: [Quiz]) {
//        print(quizs)
//        print(usersQuizsAnswer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ResultViewController{
            controller.quizs = self.quizs
            controller.usersAnswer = self.usersQuizsAnswer
        }
    }
    
}
