//
//  QuizSession.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 02/01/2018.
//  Copyright © 2018 Oliver Samson. All rights reserved.
//

import Foundation
import GameKit

/// Implementation of IQuizSession.
class QuizSession: IQuizSession {
    // MAR: - Private properties
    private var index: Int = 0
    private var questions = [QuizQuestion]()
    private var answerStates = [QuizAnswerState]()
    private var results = [Bool]()
    private var showingAnswers = false

    // MARK: - IQuizSession
    var hasMoreQuestionsToShow: Bool {
        return index < questions.count
    }

    var continueEnabled: Bool {
        get {
            return index < questions.count && (showingAnswers || answerStates.contains(.Selected))
        }
    }
    
    var continueText: String {
        get {
            if showingAnswers {
                if index == questions.count - 1 {
                    return "View Results"
                }
                else {
                    return "Next Question"
                }
            }
            else {
                return "Confirm"
            }
        }
    }
    
    func continueTapped() -> QuizTransition {
        if showingAnswers {
            var isCorrect = true
            for answerState in answerStates {
                if answerState == .SelectedIncorrect || answerState == .UnselectedIncorrect {
                    isCorrect = false
                }
            }
            index = index + 1
            results.append(isCorrect)
            showingAnswers = false
            for answerIndex in 0...3 {
                answerStates[answerIndex] = .Normal
            }
            if hasMoreQuestionsToShow {
                return .Transition
            }
            else {
                return .Results
            }
        }
        else {
            showingAnswers = true
            let quizAnswers = questions[index].Answers
            for answerIndex in 0...3 {
                if quizAnswers[answerIndex].IsCorrect {
                    if answerStates[answerIndex] == .Selected {
                        answerStates[answerIndex] = .SelectedCorrect
                    }
                    else {
                        answerStates[answerIndex] = .UnselectedIncorrect
                    }
                }
                else if answerStates[answerIndex] == .Selected {
                    answerStates[answerIndex] = .SelectedIncorrect
                }
            }
            return .NoTransition
        }
    }
    
    var currentQuestion: QuizQuestion {
        return questions[index]
    }

    func toggleAnswer(answerIndex: Int) {
        let isMultipleChoice = questions[index].SupportsMultipleSelection
        if !showingAnswers {
            if !isMultipleChoice {
                for i in 0...3 {
                    if i + 1 == answerIndex {
                        answerStates[i] = answerStates[i].toggle()
                    }
                    else {
                        answerStates[i] = .Normal
                    }
                }
            }
            else {
                answerStates[answerIndex - 1] = answerStates[answerIndex - 1].toggle()
            }
        }
    }
    
    func getState(answerIndex: Int) -> QuizAnswerState {
        return answerStates[answerIndex - 1]
    }
    
    // MARK: - Initializers
    init(randomSeed: UInt64?, course: String?, progressController: IProgressController, contentRepository:IContentRepository) {
        answerStates.append(.Normal)
        answerStates.append(.Normal)
        answerStates.append(.Normal)
        answerStates.append(.Normal)

        let randomSource = GKMersenneTwisterRandomSource()
        if (randomSeed != nil) {
            randomSource.seed = randomSeed!
        }
        
        // Get some due progress objects.
        let progress = progressController.fetchProgress(course: course)
        var showCount = 10

        // Split the progress objects by whether they are actually due or not.
        var dueProgress = [IProgressFacade]()
        var notDueProgress = [IProgressFacade]()
        let date = Date()
        for progressObject in progress {
            if progressObject.dueDate <= date {
                dueProgress.append(progressObject)
            }
            else {
                notDueProgress.append(progressObject)
            }
        }

        // Randomly insert due quiz questions into the pile.
        questions = [QuizQuestion]()
        while (showCount > 0 && (dueProgress.count > 0 || notDueProgress.count > 0)) {
            let index = randomSource.nextInt(upperBound: dueProgress.count > 0 ? dueProgress.count : notDueProgress.count)
            var progressObject: IProgressFacade
            if dueProgress.count > 0 {
                progressObject = dueProgress.remove(at: index)
            }
            else {
                progressObject = notDueProgress.remove(at: index)
            }
            
            // Get the question.
            let question = contentRepository.fetchQuestion(question: progressObject.question)
            
            // Randomise the side to show.
            let reverseSide = question.ReverseTestQuestion != nil && randomSource.nextBool()

            // Get all the possible questions and answers.
            let testContent = contentRepository.fetchContent(contentKey: ContentKey(contentType: question.BaseContentType, contentName: progressObject.name))
            let allContent = contentRepository.allContent(contentType: question.BaseContentType)
            
            // Select the specific question (in the case of Many-to-Many relationship or reverse Many-to-One relationship).
            var questionText: String
            var isSingleChoice: Bool
            var answers = [QuizAnswer]()
            if !reverseSide {
                let allAnswerStrings =
                    (question.RelationshipType != .ManyToMany ?
                        allContent.map({ (content) -> String in
                            return content.getValue(name: question.TargetFieldName)!
                        }) : allContent.collect({ (content) -> [String] in
                            return content.getValues(name: question.TargetFieldName)
                        })).distinct()
                questionText = testContent.getValue(name: question.BaseFieldName)!
                if question.RelationshipType != .ManyToMany {
                    isSingleChoice = true
                    let correctAnswer = testContent.getValue(name: question.TargetFieldName)!
                    answers.append(QuizAnswer(answer: correctAnswer, isCorrect: true, imageName: nil))
                    var indices = [Int]()
                    while indices.count < 3 {
                        let index = randomSource.nextInt(upperBound: allAnswerStrings.count)
                        if allAnswerStrings[index] != correctAnswer && !indices.contains(where: { (i:Int) -> Bool in
                            return (i == index)
                        }) {
                            indices.append(index)
                        }
                    }
                    for index in indices {
                        answers.append(QuizAnswer(answer: allAnswerStrings[index], isCorrect: false, imageName: nil))
                    }
                }
                else {
                    isSingleChoice = false
                    let correctAnswerStrings = testContent.getValues(name: question.TargetFieldName)
                    let numCorrectAnswers = (correctAnswerStrings.count > 1 && randomSource.nextBool()) ? 2 : 1
                    let numIncorrectAnswers = 4 - numCorrectAnswers
                    var correctIndices = [Int]()
                    while correctIndices.count < numCorrectAnswers {
                        let index = randomSource.nextInt(upperBound: correctAnswerStrings.count)
                        if !correctIndices.contains(where: { (i:Int) -> Bool in
                            return (i == index)
                        }) {
                            correctIndices.append(index)
                        }
                    }
                    let correctAnswerStringToUse = correctIndices.map({ (index) -> String in
                        return correctAnswerStrings[index]
                    })
                    var incorrectIndices = [Int]()
                    while incorrectIndices.count < numIncorrectAnswers {
                        let index = randomSource.nextInt(upperBound: allAnswerStrings.count)
                        let suggestedAnswerString = allAnswerStrings[index]
                        if !correctAnswerStringToUse.contains(where: { (answerString) -> Bool in
                            return answerString == suggestedAnswerString
                        }) && !incorrectIndices.contains(where: { (i:Int) -> Bool in
                            return (i == index)
                        }) {
                            incorrectIndices.append(index)
                        }
                    }
                    for correctAnswerString in correctAnswerStringToUse {
                        answers.append(QuizAnswer(answer: correctAnswerString, isCorrect: true, imageName: nil))
                    }
                    for index in incorrectIndices {
                        answers.append(QuizAnswer(answer: allAnswerStrings[index], isCorrect: false, imageName: nil))
                    }
                }
            }
            else if question.RelationshipType == .ManyToMany || question.RelationshipType == .ManyToOne {
                if (question.RelationshipType == .ManyToMany) {
                    let possibleQuestions = testContent.getValues(name: question.TargetFieldName)
                    let index = randomSource.nextInt(upperBound: possibleQuestions.count)
                    questionText = possibleQuestions[index]
                }
                else {
                    questionText = testContent.getValue(name: question.TargetFieldName)!
                }
                isSingleChoice = false

                // Fetch all correct answers, which will include the one that we know, plus all incorrect answers separately.
                let keyCorrectAnswer = testContent.getValue(name: question.BaseFieldName)!
                var correctAnswers = [String]()
                var incorrectAnswers = [String]()
                if (question.RelationshipType == .ManyToMany) {
                    for content in allContent {
                        let answerString = content.getValue(name: question.BaseFieldName)!
                        if answerString != keyCorrectAnswer {
                            if content.getValues(name: question.TargetFieldName).contains(questionText) {
                                correctAnswers.append(answerString)
                            }
                            else {
                                incorrectAnswers.append(answerString)
                            }
                        }
                    }
                }
                else {
                    for content in allContent {
                        let answerString = content.getValue(name: question.BaseFieldName)!
                        if answerString != keyCorrectAnswer {
                            if content.getValue(name: question.TargetFieldName)! == questionText {
                                correctAnswers.append(answerString)
                            }
                            else {
                                incorrectAnswers.append(answerString)
                            }
                        }
                    }
                }
                
                // How many correct answers to show.
                let numCorrectAnswers = (correctAnswers.count == 0 || randomSource.nextBool()) ? 1 : 2
                let numIncorrectAnswers = 4 - numCorrectAnswers
                answers.append(QuizAnswer(answer: keyCorrectAnswer, isCorrect: true, imageName: nil))
                if (numCorrectAnswers == 2) {
                    let index = randomSource.nextInt(upperBound: correctAnswers.count)
                    answers.append(QuizAnswer(answer: correctAnswers[index], isCorrect: true, imageName: nil))
                }
                var incorrectIndices = [Int]()
                while incorrectIndices.count < numIncorrectAnswers {
                    let index = randomSource.nextInt(upperBound: incorrectAnswers.count)
                    if !incorrectIndices.contains(where: { (i:Int) -> Bool in
                        return (i == index)
                    }) {
                        incorrectIndices.append(index)
                    }
                }
                for index in incorrectIndices {
                    answers.append(QuizAnswer(answer: incorrectAnswers[index], isCorrect: false, imageName: nil))
                }
            }
            else {
                questionText = testContent.getValue(name: question.TargetFieldName)!
                let correctAnswer = testContent.getValue(name: question.BaseFieldName)!
                isSingleChoice = true
                var incorrectAnswers = [String]()
                let imageFieldName = question.ReverseTestAnswerImageFieldName
                answers.append(QuizAnswer(answer: correctAnswer, isCorrect: true, imageName: imageFieldName == nil ? nil : testContent.getValue(name: imageFieldName!)))
                for content in allContent {
                    let answerString = content.getValue(name: question.BaseFieldName)!
                    if answerString != correctAnswer {
                        incorrectAnswers.append(answerString)
                    }
                }
                var incorrectIndices = [Int]()
                while incorrectIndices.count < 3 {
                    let index = randomSource.nextInt(upperBound: incorrectAnswers.count)
                    if !incorrectIndices.contains(where: { (i:Int) -> Bool in
                        return (i == index)
                    }) {
                        incorrectIndices.append(index)
                    }
                }
                for index in incorrectIndices {
                    if imageFieldName == nil {
                        answers.append(QuizAnswer(answer: incorrectAnswers[index], isCorrect: false, imageName: nil))
                    }
                    else {
                        let name = incorrectAnswers[index]
                        let content = contentRepository.fetchContent(contentKey: ContentKey(contentType: question.BaseContentType, contentName: name))
                        answers.append(QuizAnswer(answer: name, isCorrect: false, imageName: content.getValue(name: imageFieldName!)))
                    }
                }
            }

            // Randomly sort the answers.
            var sortedAnswers = [QuizAnswer]()
            while answers.count > 1 {
                sortedAnswers.append(answers.remove(at: randomSource.nextInt(upperBound: answers.count)))
            }
            sortedAnswers.append(answers[0])
            
            // Add the quiz question.
            let questionWithoutReplacements = reverseSide ? question.ReverseTestQuestion! : question.TestQuestion
            let fullQuestionText = questionWithoutReplacements.replacingOccurrences(of: "$1", with: questionText)
            let course = contentRepository.fetchCourse(courseName: question.Course)
            questions.append(QuizQuestion(color: course.Color, questionName: question.Name, contentName: testContent.contentKey.ContentName, questionText: fullQuestionText, supportsMultipleSelection: !isSingleChoice, answers: sortedAnswers))
            showCount = showCount - 1
        }
    }
    
    var numCorrect: Int {
        get {
            var numCorrect = 0
            for result in results {
                if result {
                    numCorrect = numCorrect + 1
                }
            }
            return numCorrect
        }
    }
    
    var numIncorrect: Int {
        get {
            var numIncorrect = 0
            for result in results {
                if !result {
                    numIncorrect = numIncorrect + 1
                }
            }
            return numIncorrect
        }
    }
    
    var haveSaved: Bool = false
    
    func save(progressController: IProgressController) {
        if !haveSaved {
            var index = 0
            let date = Date()
            while index < results.count && index < questions.count {
                let progress = progressController.fetchProgress(progressKey: questions[index])
                if progress != nil {
                    if results[index] {
                        switch progress!.lastDifficulty {
                        case .easy:
                            var timeInterval = DateComponents()
                            timeInterval.day = ProgressDateIntervals.veryEasyDays
                            progress!.dueDate = Calendar.current.date(byAdding: timeInterval, to: date)!
                            progress!.easyCount = 1
                            progress!.lastDifficulty = .veryEasy
                        case .veryEasy:
                            var timeInterval = DateComponents()
                            timeInterval.day = ProgressDateIntervals.veryEasyDays
                            progress!.dueDate = Calendar.current.date(byAdding: timeInterval, to: date)!
                            progress!.easyCount = progress!.easyCount + 1
                            progress!.lastDifficulty = .veryEasy
                        case .hard:
                            var timeInterval = DateComponents()
                            timeInterval.day = ProgressDateIntervals.easyDays
                            progress!.dueDate = Calendar.current.date(byAdding: timeInterval, to: date)!
                            progress!.easyCount = 0
                            progress!.lastDifficulty = .easy
                        case .veryHard:
                            var timeInterval = DateComponents()
                            timeInterval.day = ProgressDateIntervals.hardDays
                            progress!.dueDate = Calendar.current.date(byAdding: timeInterval, to: date)!
                            progress!.easyCount = 0
                            progress!.lastDifficulty = .hard
                        }
                    }
                    else {
                        progress!.easyCount = 0
                        switch progress!.lastDifficulty {
                        case .easy:
                            var timeInterval = DateComponents()
                            timeInterval.day = ProgressDateIntervals.hardDays
                            progress!.dueDate = Calendar.current.date(byAdding: timeInterval, to: date)!
                            progress!.lastDifficulty = .hard
                        case .veryEasy:
                            var timeInterval = DateComponents()
                            timeInterval.day = ProgressDateIntervals.easyDays
                            progress!.dueDate = Calendar.current.date(byAdding: timeInterval, to: date)!
                            progress!.lastDifficulty = .easy
                        case .hard:
                            var timeInterval = DateComponents()
                            timeInterval.day = ProgressDateIntervals.veryHardDays
                            progress!.dueDate = Calendar.current.date(byAdding: timeInterval, to: date)!
                            progress!.lastDifficulty = .veryHard
                        case .veryHard:
                            var timeInterval = DateComponents()
                            timeInterval.day = ProgressDateIntervals.veryHardDays
                            progress!.dueDate = Calendar.current.date(byAdding: timeInterval, to: date)!
                            progress!.lastDifficulty = .veryHard
                        }
                    }
                }
                index = index + 1
            }
            do {
                try progressController.save()
            }
            catch {
                // TODO Log some results
            }
        }
    }
}
