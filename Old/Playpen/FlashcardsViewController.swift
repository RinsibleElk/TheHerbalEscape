//
//  DynamicsViewController.swift
//  Playpen
//
//  Created by Oliver Samson on 21/11/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import UIKit
import PureLayout

class FlashcardsViewController: UIViewController {
    @IBOutlet weak var safeView: UIView!
    @IBOutlet weak var backgroundView: UIImageView!
    var imageView1 = UIImageView(image: #imageLiteral(resourceName: "flashcards"))
    var imageView2 = UIImageView(image: #imageLiteral(resourceName: "game"))
    var imageView3 = UIImageView(image: #imageLiteral(resourceName: "mortarboard"))
    var labelView1 = UILabel()
    var labelView2 = UILabel()
    var labelView3 = UILabel()
    var card1 = UIView()
    var card2 = UIView()
    var card3 = UIView()
    var card4 = UIView()
    var card5 = UIView()
    var card6 = UIView()
    var view1 = UIView()
    var view2 = UIView()
    var view3 = UIView()
    var view4 = UIView()
    var view5 = UIView()
    var view6 = UIView()
    var viewConstraints : NSArray?
    var didSetupConstraints = false
    var side : Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        labelView1.text = "Side 1"
        labelView1.textAlignment = .center
        labelView2.text = "Side 2"
        labelView2.textAlignment = .center
        labelView3.text = "Side 3"
        labelView3.textAlignment = .center
        imageView1.contentMode = .scaleAspectFill
        imageView2.contentMode = .scaleAspectFill
        imageView3.contentMode = .scaleAspectFill
        card1.layer.borderWidth = 3
        card1.layer.borderColor = UIColor.black.cgColor
        card1.layer.cornerRadius = 30
        card1.layer.backgroundColor = UIColor.white.cgColor
        card2.layer.borderWidth = 3
        card2.layer.borderColor = UIColor.black.cgColor
        card2.layer.cornerRadius = 30
        card2.layer.backgroundColor = UIColor.white.cgColor
        card3.layer.borderWidth = 3
        card3.layer.borderColor = UIColor.black.cgColor
        card3.layer.cornerRadius = 30
        card3.layer.backgroundColor = UIColor.white.cgColor
        card4.layer.borderWidth = 3
        card4.layer.borderColor = UIColor.black.cgColor
        card4.layer.cornerRadius = 30
        card4.layer.backgroundColor = UIColor.white.cgColor
        card5.layer.borderWidth = 3
        card5.layer.borderColor = UIColor.black.cgColor
        card5.layer.cornerRadius = 30
        card5.layer.backgroundColor = UIColor.white.cgColor
        card6.layer.borderWidth = 3
        card6.layer.borderColor = UIColor.black.cgColor
        card6.layer.cornerRadius = 30
        card6.layer.backgroundColor = UIColor.white.cgColor
        card1.addSubview(imageView1)
        card2.addSubview(labelView1)
        card3.addSubview(imageView2)
        card4.addSubview(labelView2)
        card5.addSubview(imageView3)
        card6.addSubview(labelView3)
        view1.addSubview(card1)
        view2.addSubview(card2)
        view3.addSubview(card3)
        view4.addSubview(card4)
        view5.addSubview(card5)
        view6.addSubview(card6)
        side = 1
        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        view6.isHidden = true
        safeView.addSubview(view1)
        safeView.addSubview(view2)
        safeView.addSubview(view3)
        safeView.addSubview(view4)
        safeView.addSubview(view5)
        safeView.addSubview(view6)

        // Bootstrap Auto Layout
        view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        if (!didSetupConstraints) {
            // Note that we use autoCreateAndInstallConstraints() here in order to easily collect all the constraints into a single array.
            viewConstraints = NSLayoutConstraint.autoCreateAndInstallConstraints {
                self.view1.autoPinEdgesToSuperviewEdges()
                self.view2.autoPinEdgesToSuperviewEdges()
                self.view3.autoPinEdgesToSuperviewEdges()
                self.view4.autoPinEdgesToSuperviewEdges()
                self.view5.autoPinEdgesToSuperviewEdges()
                self.view6.autoPinEdgesToSuperviewEdges()
                self.card1.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
                self.card2.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
                self.card3.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
                self.card4.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
                self.card5.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
                self.card6.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
                self.imageView1.autoAlignAxis(toSuperviewAxis: .horizontal)
                self.imageView1.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
                self.imageView1.autoPinEdge(toSuperviewEdge: .right, withInset: 40)
                self.imageView2.autoAlignAxis(toSuperviewAxis: .horizontal)
                self.imageView2.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
                self.imageView2.autoPinEdge(toSuperviewEdge: .right, withInset: 40)
                self.imageView3.autoAlignAxis(toSuperviewAxis: .horizontal)
                self.imageView3.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
                self.imageView3.autoPinEdge(toSuperviewEdge: .right, withInset: 40)
                self.labelView1.autoAlignAxis(toSuperviewAxis: .horizontal)
                self.labelView1.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
                self.labelView1.autoPinEdge(toSuperviewEdge: .right, withInset: 40)
                self.labelView2.autoAlignAxis(toSuperviewAxis: .horizontal)
                self.labelView2.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
                self.labelView2.autoPinEdge(toSuperviewEdge: .right, withInset: 40)
                self.labelView3.autoAlignAxis(toSuperviewAxis: .horizontal)
                self.labelView3.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
                self.labelView3.autoPinEdge(toSuperviewEdge: .right, withInset: 40)
                } as NSArray?
            didSetupConstraints = true
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        var frontView : UIView!
        var backView : UIView!
        switch side {
        case 1:
            frontView = view1
            backView = view2
            side = 2
        case 2:
            frontView = view2
            backView = view3
            side = 3
        case 3:
            frontView = view3
            backView = view4
            side = 4
        case 4:
            frontView = view4
            backView = view5
            side = 5
        case 5:
            frontView = view5
            backView = view6
            side = 6
        default:
            frontView = view6
            backView = view1
            side = 1
        }
        backView.isHidden = false
        let direction = sender.direction
        var frontViewEndFrame : CGRect!
        var backViewStartFrame : CGRect!
        let originLeft = CGPoint(x: frontView.frame.origin.x - frontView.frame.width - 50, y: frontView.frame.origin.y)
        let originRight = CGPoint(x: frontView.frame.origin.x + frontView.frame.width + 50, y: frontView.frame.origin.y)
        let originUp = CGPoint(x: frontView.frame.origin.x, y: frontView.frame.origin.y - frontView.frame.height - 50)
        let originDown = CGPoint(x: frontView.frame.origin.x, y: frontView.frame.origin.y + frontView.frame.height + 50)
        switch direction {
        case .right:
            frontViewEndFrame = CGRect(origin: originRight, size: frontView.frame.size)
            backViewStartFrame = CGRect(origin: originLeft, size: frontView.frame.size)
        case .left:
            frontViewEndFrame = CGRect(origin: originLeft, size: frontView.frame.size)
            backViewStartFrame = CGRect(origin: originRight, size: frontView.frame.size)
        case .up:
            frontViewEndFrame = CGRect(origin: originUp, size: frontView.frame.size)
            backViewStartFrame = CGRect(origin: originDown, size: frontView.frame.size)
        default:
            frontViewEndFrame = CGRect(origin: originDown, size: frontView.frame.size)
            backViewStartFrame = CGRect(origin: originUp, size: frontView.frame.size)
        }
        backView.frame = backViewStartFrame
        let backViewEndFrame = frontView.frame
        UIView.animate(withDuration: 1.0,
                       animations: {
                        frontView.frame = frontViewEndFrame
                        backView.frame = backViewEndFrame
        },
                       completion: { (finished:Bool) in
                        frontView.isHidden = true
                        frontView.frame = backViewEndFrame
        })
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        var frontView : UIView!
        var backView : UIView!
        switch side {
        case 1:
            frontView = view1
            backView = view2
            side = 2
        case 2:
            frontView = view2
            backView = view3
            side = 3
        case 3:
            frontView = view3
            backView = view4
            side = 4
        case 4:
            frontView = view4
            backView = view5
            side = 5
        case 5:
            frontView = view5
            backView = view6
            side = 6
        default:
            frontView = view6
            backView = view1
            side = 1
        }
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: frontView, duration: 1.0, options: transitionOptions, animations: {
            frontView.isHidden = true
        })
        UIView.transition(with: backView, duration: 1.0, options: transitionOptions, animations: {
            backView.isHidden = false
        })
    }
}
