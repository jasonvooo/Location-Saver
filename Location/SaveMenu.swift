import UIKit
import MapKit

class SaveMenu : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    let shift = UIApplication.sharedApplication().statusBarFrame.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initMapView()
        self.view.backgroundColor = UIColor.whiteColor()
        
        //Save button
        self.view.addSubview(UIObject.createButton(screenSize.width/2-150,h: screenSize.height - 65,x: 300,y: 50,title: "Save",colour: 0x4CD964,radius: 5, s: #selector(SaveMenu.displaySaveOption)))
        
        //Navigation bar background
        let nav = UILabel(frame:CGRectMake(0, 0, screenSize.width, 44 + UIApplication.sharedApplication().statusBarFrame.size.height))
        nav.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(nav)
        
        
        //Navigation bar
        self.view.addSubview(UIObject.createNavBar(screenSize.width, h: 44, x: 0, y: shift, title: "Location Saver", leftTitle: "Back", leftS: #selector(SaveMenu.backMain)))

    }
    
    func displaySaveOption(){
        let centre = mapView.centerCoordinate
        let saveOption:SaveOption = SaveOption(sender: self, latitude: centre.latitude, longitude: centre.longitude)
        self.presentViewController(saveOption, animated: true, completion: nil)
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

        
        //Pin Icon
        let pinIcon = UIImageView(frame: CGRectMake(screenSize.width/2, screenSize.height/2, 20, 20))
        let pin = UIImage(named: "pinny") as UIImage!
        pinIcon.image = pin
        mapView.addSubview(pinIcon)
        

    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        print("Errors: " + error.localizedDescription)
    }

}
