//
//  SetupPageViewController.swift
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-18.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

import UIKit

class SetupPageViewController: UIPageViewController {

    // MARK: - Constants
    private struct Constants {
        static let FirstSetupScene = "setupPageFirstScene"
        static let SecondSetupScene = "setupPageSecondScene"
        static let ThirdSetupScene = "setupPageThirdScene"
        static let FourthSetupScene = "setupPageFourthScene"
        static let FifthSetupScene = "setupPageFifthScene"
        static let SixthSetupScene = "setupPageSixthScene"
    }

    let manager = LunchtimeLocationManager.defaultManager()
    var scenes = [UIViewController]()

    // MARK: - Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstScene = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.FirstSetupScene) as? SetupPageFirstViewController
        let secondScene = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.SecondSetupScene) as? SetupPageSecondViewController
        let thirdScene = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.ThirdSetupScene) as? SetupPageThirdViewController
        let fourthScene = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.FourthSetupScene) as? SetupPageFourthViewController
        let fifthScene = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.FifthSetupScene) as? SetupPageFifthViewController
        let sixthScene = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.SixthSetupScene) as? SetupPageSixthViewController

        guard let first = firstScene, second = secondScene, third = thirdScene, fourth = fourthScene, fifth = fifthScene, sixth = sixthScene else {
            return
        }

        configureController()
        scenes = [first, second, third, fourth, fifth, sixth]
        setViewControllers([first], direction: .Forward, animated: true, completion: nil)
    }

    private func configureController() {
        view.backgroundColor = UIColor.whiteColor()
        dataSource = self
    }

}

// MARK: - UIPageViewControllerDataSource
extension SetupPageViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

        guard var index = scenes.indexOf(viewController) else {
            return nil
        }

        index++
        
        if index >= scenes.count {
            return nil;
        }

        return scenes[index]
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

        guard var index = scenes.indexOf(viewController) else {
            return nil
        }

        index--
        if index < 0 {
            return nil;
        }

        return scenes[index]
    }
}