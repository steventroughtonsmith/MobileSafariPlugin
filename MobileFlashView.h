//
//  MobileFlashView.h
//  MobileFlash
//
//  Created by Steven Troughton-Smith on 10/02/2010.
//  Copyright Steven Troughton-Smith 2010. All rights reserved.
//



@interface MobileFlashView : UIView
{
	NSDictionary* _flashVars;

	id container;
}

@property (nonatomic, retain) id container;

@end
