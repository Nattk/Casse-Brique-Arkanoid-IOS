//
//  Brique.m
//  Casse-Briques
//
//  Created by 11408757 on 13/01/2015.
//  Copyright (c) 2015 11408757. All rights reserved.
//

#import "Brique.h"

@implementation Brique



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithCouleur : (int)c  withX:(int)x withY:(int)y{


    self= [super initWithFrame:CGRectMake(x, y, 50, 50)];
    
    Couleur = c;
    switch (c) {
        case 0:
            self.image = [UIImage imageNamed:@"rouge"];
            break;
            
        case 1:
            self.image = [UIImage imageNamed:@"bleu"];
            break;
            
        case 2:
            self.image = [UIImage imageNamed:@"orange"];
       
        case 3:
            self.image = [UIImage imageNamed:@"vert"];
            break;
            
        case 4:
            self.image = [UIImage imageNamed:@"jaune"];
            break;
            
            
        
        default:
            
            
            break;
    }
    return self;



}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end



