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
        appName.font = UIFont(name: "Arial-BoldMT", size: 40)
        appName.textColor = UIColorFromHex(0xD7D7D7)
        //appName.textAlignment = .Center
        self.view.addSubview(appName)
        
        //Load Button
        let load = UIObject.createButton(screenSize.width/2-100, h: screenSize.height/2-50, x: 200, y: 50, title: "Load", colour: 0x8E8E93, radius: 5, s:#selector(ViewController.displayLoadMenu))
        load.backgroundColor = UIColor.clearColor()
        load.layer.borderColor = UIColor.whiteColor().CGColor
        self.view.addSubview(load)
        
        //Save Button
        let save = UIObject.createButton(screenSize.width/2-100,h: screenSize.height/2+100,x: 200,y: 50,title: "Save",colour: 0x8E8E93,radius: 5, s:#selector(ViewController.displaySaveMenu))
        save.backgroundColor = UIColor.clearColor()
        save.layer.borderColor = UIColor.whiteColor().CGColor
        self.view.addSubview(save)
        
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
    
    //UI colour from hex
   func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
