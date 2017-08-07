//
//  ViewController.swift
//  Remote-UI
//
//  Created by Sanjeev Ghimire on 7/7/17.
//  Copyright © 2017 Sanjeev Ghimire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var sendRobotContent: UIButton!
    
    @IBOutlet weak var colorChooserForLed: UISegmentedControl!
    
    
    @IBOutlet weak var textForSpeech: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions    
    @IBAction func sendRobotContentAPI(_ sender: UIButton) {
        let color: String = colorChooserForLed.titleForSegment(at: colorChooserForLed.selectedSegmentIndex)!
        let robotContent = RobotContent(id: "1",text: textForSpeech.text!, blinkColor: color)
        
        RemoteRobotAPI.RobotContentCreate(data: robotContent.asServerRobotContent()){ (returnedData, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            if let result = returnedData {
                print(result)
            }
            if let status = response?.statusCode {
                print("RobotContentCreate() finished with status code: \(status)")
            }
        }

        
    }
}

