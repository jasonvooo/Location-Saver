import UIKit

class ViewController: UIViewController {

    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    func initialiseScreen(){
        
        
        //Background Image
        let backgroundImage = UIImageView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
        let pin = UIImage(named: "background") as UIImage!
        backgroundImage.image = pin
        self.view.addSubview(backgroundImage)
 
        
        //Load Button
        let load = UIObject.createButton(screenSize.width*0.1032, h: screenSize.height*0.8327, x: screenSize.width*0.7936, y: screenSize.height*0.1121, title: "", colour: 0x6DC067, radius: 5, s:#selector(ViewController.displayLoadMenu))
        load.backgroundColor = UIColor.clearColor()
        self.view.addSubview(load)
        
        //Save Button
        let save = UIObject.createButton(screenSize.width*0.1032,h: screenSize.height*0.6951,x: screenSize.width*0.7936,y: screenSize.height*0.1121,title: "",colour: 0x3B5998,radius: 5, s:#selector(ViewController.displaySaveMenu))
        save.backgroundColor = UIColor.clearColor()
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //UI colour from hex
   func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
