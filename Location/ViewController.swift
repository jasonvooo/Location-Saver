import UIKit

class ViewController: UIViewController {

    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let saveButton = createButton(screenSize.width/2-50,height: screenSize.height/2+100,x: 100,y: 50,title: "Save",colour: 0x34aadc,radius: 5)
        saveButton.addTarget(self, action: #selector(ViewController.displaySaveMenu), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(saveButton)
        
        let loadButton = createButton(screenSize.width/2-50, height: screenSize.height/2, x: 100, y: 50, title: "Load", colour: 0x34aadc, radius: 5)
        loadButton.addTarget(self, action: #selector(ViewController.displayLoadMenu), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loadButton)

        
    }
    
    func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func done() {
        //save things
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func displaySaveMenu(){
        let saveMenu:SaveMenu = SaveMenu()
        self.presentViewController(saveMenu, animated: true, completion: nil)

    }
    
    func displayLoadMenu(){
        //let loadMeu:LoadMenu = LoadMenu()
        //self.presentViewController(loadMenu, animated: true, completion: nil)
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

