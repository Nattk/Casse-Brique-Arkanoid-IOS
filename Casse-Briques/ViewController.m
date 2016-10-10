//
//  ViewController.m
//  Casse-Briques
//
//  Created by 11408757 on 06/01/2015.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
int niveau=1;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    niveau=1;
	// Do any additional setup after loading the view, typically from a nib.
    NSString* myNewString = [NSString stringWithFormat:@"%i",niveau];
    NSString *varyingString1 = @"niveau";
    NSString *str = [NSString stringWithFormat: @"%@%@", varyingString1, myNewString];
    
    vitesseBalle=CGPointMake(10, 15);
    tabriques = [[NSMutableArray alloc] init];
    chrono =[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(boucleJeu) userInfo:nil repeats:YES];
        _f.hidden=YES;
        _Reco.hidden=YES;
        compteur=0;
        _perdu.hidden=YES;
        _level.hidden=YES;
        [self loadDataFormatXML:str];
    
    NSData *soundFileData;
    soundFileData = [NSData dataWithContentsOfURL:
                     [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                             pathForResource:@"son.mp3" ofType:NULL]]];
    audioPlayer = [[AVAudioPlayer alloc] initWithData:soundFileData error:NULL];
    audioPlayer.delegate = self;
    audioPlayer.numberOfLoops = -1;
    [audioPlayer setVolume:1.0];
    [audioPlayer play];
    
    
    //maBrique = [self creerBrique:4 withX:(250) withY:(250)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//La boucle Jeu
-(void) boucleJeu{

Boolean victoire=[self gagner];
   
_Balle.center = CGPointMake(_Balle.center.x + vitesseBalle.x
                           ,_Balle.center.y + vitesseBalle.y);
    
    
    if (_Balle.center.x > self.view.bounds.size.width || _Balle.center.x < 0) {
        vitesseBalle.x = -vitesseBalle.x;

    }
    
    
    if (_Balle.center.y > self.view.bounds.size.height|| _Balle.center.y < 0) {
        vitesseBalle.y = -vitesseBalle.y;
        
    }
    
    for (int i=0; i<[tabriques count]; i++) {
        Brique *b=tabriques[i];
        if ((CGRectIntersectsRect(_Balle.frame, b.frame))&&(b.hidden == NO)) {
            b.hidden=YES;
            vitesseBalle.y=-vitesseBalle.y;
        }
    }
    
    
    if(victoire==TRUE){
    
    _f.hidden=NO;
    _Reco.hidden=NO;
    _level.hidden=NO;
    [chrono invalidate];
    
    
    }
    
        
    
   if ((CGRectIntersectsRect(_Balle.frame, _Raquette.frame))&&(_Raquette.hidden == NO)){
            vitesseBalle.y=-vitesseBalle.y;
   }
    
    if (_Balle.center.y > self.view.bounds.size.height) {
        _Balle.center = CGPointMake(200 + vitesseBalle.x
                                    ,250+ vitesseBalle.y);
        compteur++;
        
        sleep(2);
    
    }
    
    
    if (compteur==1) {
        _vie1.hidden=YES;
    }
    
    else if(compteur==2){
         _vie2.hidden=YES;
        
    }
    else if(compteur==3){
        
        _vie3.hidden=YES;
        _Reco.hidden=NO;
        _perdu.hidden=NO;
        [chrono invalidate];
    }
    else{
        
        _vie1.hidden=NO;
        _vie2.hidden=NO;
        _vie3.hidden=NO;
    
    
    }
    
        
        
        
    }


-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch =[[event allTouches] anyObject];
    
    CGPoint location =[touch locationInView:touch.view];
    
    _Raquette.center = CGPointMake(location.x, _Raquette.center.y);

}

-(IBAction)Recomencer:(id)sender{
 
    
    NSString* myNewString = [NSString stringWithFormat:@"%i",niveau];
    NSString *varyingString1 = @"niveau";
    NSString *str = [NSString stringWithFormat: @"%@%@", varyingString1, myNewString];
    _level.hidden=YES;
    _f.hidden=YES;
    _Reco.hidden=YES;
    compteur=0;
    _perdu.hidden=YES;
    
    chrono =[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(boucleJeu) userInfo:nil repeats:YES];
     [self loadDataFormatXML:str];

}

-(IBAction)Level:(id)sender{
    niveau++;
    NSString* myNewString = [NSString stringWithFormat:@"%i",niveau];
    NSString *varyingString1 = @"niveau";
    NSString *str = [NSString stringWithFormat: @"%@%@", varyingString1, myNewString];
    _level.hidden=YES;
    _f.hidden=YES;
    _Reco.hidden=YES;
    chrono =[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(boucleJeu) userInfo:nil repeats:YES];
    [self loadDataFormatXML:str];

}

- (id) creerBrique:(int) c withX:(int) x withY:(int) y{
    Brique * b =[[Brique alloc]initWithCouleur:c withX:(x) withY:(y)];
    [self.view addSubview:b];
    return b;

}

-(void) loadDataFormatXML:(NSString*)nomFichier
{
    NSString* myNewString = [NSString stringWithFormat:@"%i",niveau];
    NSString *varyingString1 = @"niveau";
    NSString *str = [NSString stringWithFormat: @"%@%@", varyingString1, myNewString];
    
    NSString* path =[[NSBundle mainBundle] pathForResource: str
                                                     ofType: @"xml"];
    NSData* data =[NSData dataWithContentsOfFile: path];
    
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData: data];
    
    [parser setDelegate:self];
    
    [parser parse];
    
    
}
-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict{

    if ([elementName isEqualToString:@"brique"]) {
        int couleur =[[attributeDict valueForKey:@"couleur"] intValue];
        int x =[[attributeDict valueForKey:@"x"] intValue];
        int y =[[attributeDict valueForKey:@"y"] intValue];
        
        Brique *b = [self creerBrique:couleur withX:(x) withY:(y)];
        [tabriques addObject:b];


    }
    

    
    
}

-(BOOL) gagner{
   
        Boolean drap= TRUE;
        for (int i=0;i<[tabriques count] ; i++) {
            Brique *b=tabriques[i];
            if(b.hidden==NO){
                
                drap=FALSE;
            }
            
        }
    
    return drap;
    }


@end