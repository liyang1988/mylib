#import <UIKit/UIKit.h>




@interface UIImageView (AGCInitials)

- (void)setImageWithInitials:(nonnull NSString*)initials;
- (void)setImageWithInitials:(nonnull NSString*)initials andTextAttributes:(nonnull NSDictionary*)textAttributes;
- (void)setImageWithInitialsFromName:(nonnull NSString*)name;
- (void)setImageWithInitialsFromName:(nonnull NSString*)name separatedByString:(nonnull NSString*)separator;
- (void)setImageWithInitialsFromName:(nonnull NSString*)name withTextAttributes:(nonnull NSDictionary*)textAttributes;
- (void)setImageWithInitialsFromName:(nonnull NSString*)name separatedByString:(nonnull NSString*)separator withTextAttributes:(nonnull NSDictionary*)textAttributes;
- (void)setImageWithInitials:(nonnull NSString*)initials stringToGenerateColor:(nonnull NSString*)stringToGenerateColor textAttributes:(nonnull NSDictionary*)textAttributes; //Designated initializer

@end