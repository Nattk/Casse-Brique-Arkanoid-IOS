//
//  Brique.h
//  Casse-Briques
//
//  Created by 11408757 on 13/01/2015.
//  Copyright (c) 2015 11408757. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Brique : UIImageView{

int Couleur;

}
-(id)initWithCouleur : (int)c  withX:(int) X withY:(int)y;
@end
