#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "Picasso.h"
#import "PicassoOpenGLView.h"

FOUNDATION_EXPORT double PicassoVersionNumber;
FOUNDATION_EXPORT const unsigned char PicassoVersionString[];

