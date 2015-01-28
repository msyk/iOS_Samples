//
//  MapDisplayViewController.m
//  PlaceMap
//
//  Created by demo on 2014/09/14.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "MapDisplayViewController.h"
#import "AppDelegate.h"
#import "PlaceDatabase.h"
#import <MapKit/MapKit.h>

@interface MapDisplayViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *placeName;

@end

@implementation MapDisplayViewController

- (void)viewDidLoad {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLoad];
    
    if([UIDevice currentDevice].userInterfaceIdiom
       == UIUserInterfaceIdiomPad) {
        UISplitViewController *svc = self.splitViewController;
        UINavigationItem *navItem = self.navigationItem;
        navItem.leftBarButtonItem = svc.displayModeButtonItem;
 //       navItem.leftItemsSupplementBackButton = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", self.navigationItem);
    NSLog(@"%@", self.navigationController.navigationBar.items);
    
    [super viewDidAppear: animated];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSArray *places = appDelegate.placeDB.places;
    
    NSLog(@"Selected = %@", places[self.selectedIndex][@"name"]);
    
    self.placeName.text = [NSString stringWithFormat: @"%@ [%@]",
                           places[self.selectedIndex][@"pref"],
                           places[self.selectedIndex][@"name"]];
    NSNumber *latitude = places[self.selectedIndex][@"latitude"];
    NSNumber *longitude = places[self.selectedIndex][@"longitude"];
    CLLocationCoordinate2D coordinate = {
        .latitude = latitude.doubleValue,
        .longitude = longitude.doubleValue
    };
    MKCoordinateSpan span = {
        .latitudeDelta = 0.01,
        .longitudeDelta = 0.01
    };
    MKCoordinateRegion region = {
        .center = coordinate,
        .span = span
    };
    self.mapView.region = region;
}

@end
