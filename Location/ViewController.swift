import UIKit

class ViewController: UIViewController {

    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: CGRectMake(-20, 0, screenSize.width+20, screenSize.height))
        let pin = UIImage(named: "loginn") as UIImage!
        backgroundImage.image = pin
        self.view.addSubview(backgroundImage)
        
        let appName = UILabel(frame: CGRectMake(screenSize.width/2 - 62, 100, 250, 50))
        appName.text = "Laver"
        appName.font = UIFont(name: "Arial-BoldMT", size: 45)
        appName.textColor = UIColor.whiteColor()
        
        self.view.addSubview(appName)
    
        let saveButton = createButton(screenSize.width/2-100,height: screenSize.height/2+100,x: 200,y: 100,title: "Save",colour: 0x34aadc,radius: 5)
        saveButton.addTarget(self, action: #selector(ViewController.displaySaveMenu), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(saveButton)
        
        let loadButton = createButton(screenSize.width/2-100, height: screenSize.height/2-50, x: 200, y: 100, title: "Load", colour: 0x34aadc, radius: 5)
        loadButton.addTarget(self, action: #selector(ViewController.displayLoadMenu), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loadButton)
    }
    
    func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func done() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func displaySaveMenu(){
        let vc = storyboard?.instantiateViewControllerWithIdentifier("SaveMenu") as! SaveMenu
        presentViewController(vc, animated: true, completion: nil)

    }
    
    func displayLoadMenu(){
        let loadMenu:LoadMenu = LoadMenu()
        self.presentViewController(loadMenu, animated: true, completion: nil)
    }

    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

    func createButton(width:CGFloat,height:CGFloat,x:CGFloat,y:CGFloat,title:String,colour:UInt32,radius:CGFloat)-> UIButton{
        let button = UIButton(frame:CGRectMake(width, height, x, y))
        button.backgroundColor = UIColorFromHex(colour)
        button.setTitle(title, forState: UIControlState.Normal)
        button.layer.cornerRadius = radius
        return button
    }

}

