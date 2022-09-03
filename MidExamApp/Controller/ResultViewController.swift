//
//  ResultViewController.swift
//  MidExamApp
//
//  Created by WeiFangChou on 2022/8/10.
//

import UIKit

class ResultViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{


    var score = 0
    var quizs : [Quiz] = []
    var usersAnswer : [Int] = []
    var usersQuizAnswer: [Bool] = []
    
    @IBOutlet weak var scorelabel: UILabel!
    @IBOutlet weak var quizsHistroy: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        quizsHistroy.delegate = self
        quizsHistroy.dataSource = self
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.setHidesBackButton(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        score = checkQuizAnswer(quiz: self.quizs, answer: self.usersAnswer).1
        title = String("Score : \(score)")
    }
    
    func checkQuizAnswer(quiz quizs: [Quiz], answer userAnswer: [Int]) -> ([Bool], Int){
        var score = 0
        var checkQuizsAnswer:[Bool] = []
        for index in 0..<quizs.count{
            let quiz = quizs[index]
            let answer = userAnswer[index]
            for answerIndex in 0..<quiz.answers.count{
                if(quiz.answers[answerIndex].isCorrect){
                    if(answer == answerIndex){
//                        print(quiz.answers[answerIndex],"is Correct !")
                        //Correct Answer
                        usersQuizAnswer.append(true)
                        score += 10
                    }else{
                        //Wrong Answer
                        usersQuizAnswer.append(false)
                    }
                }
            }
            
            
        }


        return (checkQuizsAnswer,score)
    }

    
    @IBAction func playAgainClick(_ sender: UIButton) {
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuizResultCell", for: indexPath) as? QuizResultTableViewCell else {
            return UITableViewCell()
        }
        let index = self.quizs[indexPath.row]
        cell.questionLabel.text = index.question
        cell.answerLabel.text = "你的答案：" + index.answers[usersAnswer[indexPath.row]].option
        cell.correctImage.image = UIImage(named: usersQuizAnswer[indexPath.row] ? "correct" : "wrong")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
