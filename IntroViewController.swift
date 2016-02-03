//
//  IntroViewController.swift
//  NJToDo
//
//  Created by Nugget Jiang on 16/1/21.
//  Copyright © 2016年 Nugget Jiang. All rights reserved.
//

import UIKit
import StarWars

class IntroViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backToRoot(segue:UIStoryboardSegue){
        
    }
    @IBAction func presentButton(sender: AnyObject) {
        self.performSegueWithIdentifier("presentSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController
        destination.transitioningDelegate = self
        let navigation = destination as? UINavigationController
        navigation?.topViewController as? ProfileViewController

    }
    
    
}


extension IntroViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        //        return StarWarsUIDynamicAnimator()
        //        return StarWarsUIViewAnimator()
        return StarWarsGLAnimator()
        
    }
}
