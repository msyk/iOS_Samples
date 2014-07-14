//
//  MapDisplayViewController.m
//  PlaceMap
//
//  Created by demo on 2014/06/26.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "MapDisplayViewController.h"
#import "AppDelegate.h"
#import "PlaceDatabase.h"
#import <MapKit/MapKit.h>

@interface MapDisplayViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *placeName;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) UIPopoverController *masterPOC;

@end

@implementation MapDisplayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    [self updateContent];
    
//    CLLocationCoordinate2D coordinate;
//    NSNumber *num = places[self.selectedIndex][@"latitude"];
//    coordinate.latitude = num.doubleValue;
//    num = places[self.selectedIndex][@"longitude"];
//    coordinate.longitude = num.doubleValue;
//    self.mapView.centerCoordinate = coordinate;

}

- (void)updateContent
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSArray *places = appDelegate.placeDB.places;
    
    NSLog(@"Selected = %@", places[self.selectedIndex][@"name"]);
    
    self.placeName.text = [NSString stringWithFormat: @"%@ [%@]",
                           places[self.selectedIndex][@"pref"],
                           places[self.selectedIndex][@"name"]];
    MKCoordinateRegion region;
    CLLocationCoordinate2D coordinate;
    NSNumber *num = places[self.selectedIndex][@"latitude"];
    coordinate.latitude = num.doubleValue;
    num = places[self.selectedIndex][@"longitude"];
    coordinate.longitude = num.doubleValue;
    region.center = coordinate;
    MKCoordinateSpan span;
    span.latitudeDelta = span.longitudeDelta = 0.01; //1 = 111km
    region.span = span;
    self.mapView.region = region;
    
//    MKPlacemark *pm = [[MKPlacemark alloc] initWithCoordinate: coordinate
//                                            addressDictionary: nil];
//    [self.mapView addAnnotation: pm];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)splitViewController: (UISplitViewController *)svc
     willShowViewController: (UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)button
{
    NSLog(@"%s", __FUNCTION__);
    
    self.toolbar.items = nil;
    self.masterPOC = nil;
}

- (void)splitViewController: (UISplitViewController *)svc
     willHideViewController: (UIViewController *)aViewController
          withBarButtonItem: (UIBarButtonItem *)barButtonItem
       forPopoverController: (UIPopoverController *)pc
{
    NSLog(@"%s", __FUNCTION__);
    
    barButtonItem.title = @"Prefectural Capital";
    self.toolbar.items = @[barButtonItem];
    self.masterPOC = pc;
}
@end
