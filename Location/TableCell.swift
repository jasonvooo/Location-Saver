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
        //Name
        let titleBar = UIView(frame:CGRectMake(0,0,screenSize.width-10, screenSize.height/20))
        titleBar.backgroundColor = UIColor.whiteColor()
        let titleText = UILabel(frame:CGRectMake(20,0,screenSize.width-30,screenSize.height/20))
        titleText.text = name
        background.addSubview(titleBar)
        titleBar.addSubview(titleText)
        
        //Banner
        let banner = UIView(frame:CGRectMake(0,0,15,screenSize.height/10))
        banner.backgroundColor = UIColor.redColor()
        banner.layer.cornerRadius = 10
        background.addSubview(banner)
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
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}