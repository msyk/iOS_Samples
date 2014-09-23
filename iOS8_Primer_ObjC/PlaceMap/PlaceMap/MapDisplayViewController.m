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
//        UINavigationController *masterNavVC = svc.viewControllers[0];
//        UIViewController *masterVC = masterNavVC.topViewController;
        UINavigationItem *navItem = self.navigationItem;
        navItem.leftBarButtonItem = svc.displayModeButtonItem;
//        navItem.leftBarButtonItem.title = masterVC.navigationItem.title;
        navItem.leftItemsSupplementBackButton = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidAppear: animated];
    
    //    NSLog(@"Selected = %d", self.selectedIndex);
    
    //    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    //    NSArray *places = appDelegate.placeDB.places;
    //
    //    NSLog(@"Selected = %@", places[self.selectedIndex][@"name"]);
    //
    //    self.placeName.text = [NSString stringWithFormat: @"%@ [%@]",
    //                           places[self.selectedIndex][@"pref"],
    //                           places[self.selectedIndex][@"name"]];
    
    //    CLLocationCoordinate2D coordinate;
    //    NSNumber *num = places[self.selectedIndex][@"latitude"];
    //    coordinate.latitude = num.doubleValue;
    //    num = places[self.selectedIndex][@"longitude"];
    //    coordinate.longitude = num.doubleValue;
    //    self.mapView.centerCoordinate = coordinate;
    
    //    MKCoordinateRegion region;
    //    CLLocationCoordinate2D coordinate;
    //    NSNumber *num = places[self.selectedIndex][@"latitude"];
    //    coordinate.latitude = num.doubleValue;
    //    num = places[self.selectedIndex][@"longitude"];
    //    coordinate.longitude = num.doubleValue;
    //    region.center = coordinate;
    //    MKCoordinateSpan span;
    //    span.latitudeDelta = span.longitudeDelta = 0.01; //1 = 111km
    //    region.span = span;
    //    self.mapView.region = region;
    
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
    
//    UISplitViewController *svc = self.splitViewController;
//          UINavigationController *masterNavVC = svc.viewControllers[0];
//           UIViewController *masterVC = masterNavVC.topViewController;
//    UINavigationController *navVC = svc.viewControllers[1];
//    UINavigationItem *navItem = navVC.topViewController.navigationItem;
//    navItem.leftBarButtonItem = svc.displayModeButtonItem;
//           navItem.leftBarButtonItem.title = masterVC.navigationItem.title;
//    navItem.leftItemsSupplementBackButton = YES;
//    [self updateMasterButton];
}

//- (void)viewDidLayoutSubviews
//{
//    NSLog(@"%s", __FUNCTION__);
//
//    UISplitViewController *svc = self.splitViewController;
//    UINavigationController *masterNavVC = svc.viewControllers[0];
//    UIViewController *masterVC = masterNavVC.topViewController;
//    UINavigationController *navVC = svc.viewControllers[1];
//    UINavigationItem *navItem = navVC.topViewController.navigationItem;
//    navItem.leftBarButtonItem = svc.displayModeButtonItem;
//    navItem.leftBarButtonItem.title = masterVC.navigationItem.title;
//    navItem.leftItemsSupplementBackButton = YES;
//}
//
//- (void)updateMasterButton
//{
//    
//    UISplitViewController *svc = self.splitViewController;
//    if (svc.displayMode == UISplitViewControllerDisplayModeAllVisible)  {
//        self.navigationItem.leftBarButtonItem = nil;
//    } else if (svc.displayMode == UISplitViewControllerDisplayModePrimaryHidden)  {
//        if (! self.navigationItem.leftBarButtonItem)    {
//            UIBarButtonItem *button = svc.displayModeButtonItem;
//            self.navigationItem.leftBarButtonItem = button;
//        }
//        UINavigationController *vc = svc.viewControllers[0];
//        NSString *masterTitle = vc.topViewController.navigationItem.title;
//        self.navigationItem.leftBarButtonItem.title = masterTitle;
//    }
//    
//}
//

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
