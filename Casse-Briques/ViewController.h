//
//  ViewController.h
//  Casse-Briques
//
//  Created by 11408757 on 06/01/2015.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brique.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController<AVAudioPlayerDelegate,NSXMLParserDelegate>{
CGPoint vitesseBalle;
NSTimer *chrono;
    AVAudioPlayer *audioPlayer;
    int compteur;
    Brique *maBrique;
    NSMutableArray *tabriques;
    int niveau;
    
    
};

@property (weak, nonatomic) IBOutlet UIImageView *Balle;
@property (weak, nonatomic) IBOutlet UIImageView *Raquette;

@property (weak, nonatomic) IBOutlet UILabel *f;
@property (weak, nonatomic) IBOutlet UIButton *Reco;
@property (weak, nonatomic) IBOutlet UIImageView *vie1;
@property (weak, nonatomic) IBOutlet UIImageView *vie2;
@property (weak, nonatomic) IBOutlet UIImageView *vie3;
@property (weak, nonatomic) IBOutlet UILabel *perdu;
@property (weak, nonatomic) IBOutlet UIButton *level;

-(IBAction)Recomencer:(id)sender;
-(IBAction)Level:(id)sender;
- (id) creerBrique:(int) c withX:(int) x withY:(int) y;
-(void) loadDataFormatXML:(NSString*)nomFichier;
-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict;
-(BOOL)gagner;
@end
