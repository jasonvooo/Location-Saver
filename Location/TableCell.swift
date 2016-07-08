import UIKit

class TableCell: UITableViewCell {
    
    var background: UIView!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        
        //Background
        background = UIView(frame: CGRectMake(5, 5, screenSize.width-10, screenSize.height/10))
        background.alpha = 0.6
        background.layer.cornerRadius = 10
        background.backgroundColor = UIColor.lightGrayColor()
        background.layer.borderWidth = 1
        background.layer.borderColor = UIColor.grayColor().CGColor
        contentView.addSubview(background)
    }
    
    func setName(name:String){
        let titleBar = UIView(frame:CGRectMake(0,0,screenSize.width-10, screenSize.height/20))
        titleBar.backgroundColor = UIColor.whiteColor()
        let titleText = UILabel(frame:CGRectMake(20,0,screenSize.width-30,screenSize.height/20))
        titleText.text = name
        background.addSubview(titleBar)
        titleBar.addSubview(titleText)
    }
    
    func setDate(date:NSDate){
        let dateBar = UIView(frame:CGRectMake(0,screenSize.height/20 ,screenSize.width-10, screenSize.height/20))
        let dateText = UILabel(frame:CGRectMake(20,0,screenSize.width-30,screenSize.height/20))
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        dateText.text = dateFormatter.stringFromDate(date)
        dateText.font = dateText.font.fontWithSize(10)
        background.addSubview(dateBar)
        dateBar.addSubview(dateText)
    }
    
    func setImag(image:NSData){
        let img = UIImage(data: image)
        let imageView = UIImageView(frame: CGRectMake(screenSize.width-10 - screenSize.height/10, 0, screenSize.height/10, screenSize.height/10))
        imageView.image = img
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.whiteColor()
        imageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        imageView.layer.borderWidth = 1
        background.addSubview(imageView)
    }
    
    func setCategory(category:String){
        let banner = UIView(frame:CGRectMake(0,0,15,screenSize.height/10))
        switch category {
        case "Car":
            banner.backgroundColor = UIObject.UIColorFromHex(0x3B5998)
        case "Restaurant":
            banner.backgroundColor = UIObject.UIColorFromHex(0xFF3B30)
        case "Store":
            banner.backgroundColor = UIObject.UIColorFromHex(0x4CD964)
        case "Other":
            banner.backgroundColor = UIObject.UIColorFromHex(0x898C90)
        default:
            banner.backgroundColor = UIColor.redColor()
        }
        banner.layer.cornerRadius = 10
        background.addSubview(banner)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}