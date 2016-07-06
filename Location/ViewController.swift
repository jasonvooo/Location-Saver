import UIKit

class ViewController: UIViewController {

    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    func initialiseScreen(){
        //Background Image
        let backgroundImage = UIImageView(frame: CGRectMake(-20, 0, screenSize.width+20, screenSize.height))
        let pin = UIImage(named: "loginn") as UIImage!
        backgroundImage.image = pin
        self.view.addSubview(backgroundImage)
        
        //Title
        let appName = UILabel(frame: CGRectMake(screenSize.width/2 - 62, 100, 250, 50))
        appName.text = "Laver"
        appName.font = UIFont(name: "Arial-BoldMT", size: 45)
        appName.textColor = UIColor.whiteColor()
        self.view.addSubview(appName)
        
        //Save Button
        self.view.addSubview(UIObject.createButton(screenSize.width/2-100,h: screenSize.height/2+100,x: 200,y: 100,title: "Save",colour: 0x34aadc,radius: 5, s:#selector(ViewController.displaySaveMenu)))
        
        //Load Button
        self.view.addSubview(UIObject.createButton(screenSize.width/2-100, h: screenSize.height/2-50, x: 200, y: 100, title: "Load", colour: 0x34aadc, radius: 5, s:#selector(ViewController.displayLoadMenu)))
    }
    
    func displaySaveMenu(){
        let vc = storyboard?.instantiateViewControllerWithIdentifier("SaveMenu") as! SaveMenu
        presentViewController(vc, animated: true, completion: nil)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func displayLoadMenu(){
        let loadMenu:LoadMenu = LoadMenu()
        self.presentViewController(loadMenu, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseScreen()
    }
}

