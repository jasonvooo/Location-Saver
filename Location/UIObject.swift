import UIKit

class UIObject : NSObject {
    
    //UI colour from hex
    static func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    //Universal button creator to simplify code
    static func createButton(w:CGFloat,h:CGFloat,x:CGFloat,y:CGFloat,title:String,colour:UInt32,radius:CGFloat,s:Selector)-> UIButton{
        let button = UIButton(frame:CGRectMake(w, h, x, y))
        button.backgroundColor = UIColorFromHex(colour)
        button.setTitle(title, forState: UIControlState.Normal)
        button.layer.cornerRadius = radius
        button.addTarget(nil, action: s, forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    static func createNavBar(w:CGFloat,h:CGFloat,x:CGFloat,y:CGFloat,title:String,leftTitle:String,leftS:Selector,rightTitle:String,rightS:Selector)-> UINavigationBar{
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: x, y: y, width: w, height: h))
        navBar.backgroundColor = UIColorFromHex(0x6DC067)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let navItem = UINavigationItem(title: title);
        if(leftTitle != ""){
            let backItem = UIBarButtonItem(title:leftTitle, style:.Plain, target:nil, action:leftS)
            navItem.leftBarButtonItem = backItem;
            navBar.setItems([navItem], animated: false);
            if(rightTitle != ""){
                let titleColour: NSDictionary = [NSForegroundColorAttributeName: UIColor.redColor()]
                let deleteItem = UIBarButtonItem(title:rightTitle, style:.Plain, target:nil, action:rightS)
                deleteItem.setTitleTextAttributes(titleColour as? [String : AnyObject], forState: .Normal)
                navItem.rightBarButtonItem = deleteItem;
                
            }
            navBar.setItems([navItem], animated: false);
        }
        return navBar
    }
    
    static func createLabel()-> UILabel{
        let label = UILabel()
        return label
    }
    
}