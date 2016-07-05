import UIKit
import MapKit

class SaveMenu : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    var initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initMapView()
        self.view.backgroundColor = UIColor.whiteColor()
        let test = createButton(screenSize.width/2-150,height: screenSize.height - 65,x: 300,y: 50,title: "Save",colour: 0x4CD964,radius: 5)
        test.addTarget(self, action: #selector(SaveMenu.saveLocation), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(test)
        
        let nav = UILabel(frame:CGRectMake(0, 0, screenSize.width, 44 + UIApplication.sharedApplication().statusBarFrame.size.height))
        nav.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(nav)
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.sharedApplication().statusBarFrame.size.height
            , width: screenSize.width, height: 44))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Location Saver");
        let backItem = UIBarButtonItem(title:"Back", style:.Plain, target:nil, action:#selector(SaveMenu.backMain))
        navItem.leftBarButtonItem = backItem;
        navBar.setItems([navItem], animated: false);

    }
    //UI colour from hex
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    //Universal button creator to simplify code
    func createButton(width:CGFloat,height:CGFloat,x:CGFloat,y:CGFloat,title:String,colour:UInt32,radius:CGFloat)-> UIButton{
        let button = UIButton(frame:CGRectMake(width, height, x, y))
        button.backgroundColor = UIColorFromHex(colour)
        button.setTitle(title, forState: UIControlState.Normal)
        button.layer.cornerRadius = radius
        return button
    }
    
    func saveLocation() {
        let alert = UIAlertController(title: "Saved", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func backMain() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func initMapView(){
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true

        /*
        //Pin Icon
        let pinIcon = UIImageView(frame: CGRectMake(screenSize.width/2-10, screenSize.width/2-20, 20, 20))
        let pin = UIImage(named: "pinny") as UIImage!
        pinIcon.image = pin
        mapView.addSubview(pinIcon)
         */

    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
    }

}
