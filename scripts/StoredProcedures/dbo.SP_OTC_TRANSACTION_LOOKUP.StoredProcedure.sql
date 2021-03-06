/ * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ O T C _ T R A N S A C T I O N _ L O O K U P ]         S c r i p t   D a t e :   0 8 / 1 4 / 2 0 1 2   1 3 : 5 7 : 0 2   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   P R O C E D U R E     [ d b o ] . [ S P _ O T C _ T R A N S A C T I O N _ L O O K U P ]    
 	 	 @ T R A N S A C T I O N _ R E F _ N U M   V A R C H A R ( 5 0 ) ,   @ S I T E _ N A M E   V A R C H A R ( 5 0 ) 	  
 A S  
 B E G I N  
 D E C L A R E   @ S Q L   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 D E C L A R E   @ C O N D I T I O N   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 S E T   @ S Q L   =   ' S E L E C T  
                         O T C T x . I D   A S   O T C T x _ I D  
                         , O T C T x . T X _ R E F E R E N C E _ N U M   A S   O T C T x _ T X _ R E F E R E N C E _ N U M  
                         , O T C T x . O R G _ R E F _ N U M   A S   O T C T x _ O R G _ R E F _ N U M  
                         , O T C T x . A M O U N T   A S   O T C T x _ A M O U N T  
                         , O T C T x . S E R V I C E _ F E E   A S   O T C T x _ S E R V I C E _ F E E  
                         , O T C T x . T X _ A M O U N T   A S   O T C T x _ T X _ A M O U N T  
                         , O T C T x . C O M M E N T S   A S   O T C T x _ C O M M E N T S  
                         , O T C T x . T X _ T Y P E   A S   O T C T x _ T X _ T Y P E  
                         , O T C T x . C H E C K N U M   A S   O T C T x _ C H E C K N U M  
                         , O T C T x . T X _ D A T E   A S   O T C T x _ T X _ D A T E     	                                          
                         , O T C T x . C A R D _ N U M B E R   A S   O T C T x _ C A R D _ N U M B E R  
                         , O T C T x . A C C O U N T N A M E   A S   O T C T x _ A C C O U N T N A M E                          
                         , O T C T x . M A C H I N E N A M E   A S   O T C T x _ M A C H I N E N A M E  
                         , O T C T x . M O D _ U S E R _ I D   A S   O T C T x _ M O D _ U S E R _ I D  
                         , O T C T x . D A T E _ T I M E _ C R E A T E D   A S   O T C T x _ D A T E _ T I M E _ C R E A T E D  
                         , O T C T x . S E T T L E M E N T _ S T A T U S   A S   O T C T x _ S E T T L E M E N T _ S T A T U S  
                         , O T C T x . C A R D _ T Y P E   A S   O T C T x _ C A R D _ T Y P E  
                         , O T C T x . S I G N A T U R E   A S   O T C T x _ S I G N A T U R E  
                         , s i t e . I D   A S   s i t e _ I D  
                         , s i t e . N A M E   A S   s i t e _ N A M E  
                         , m e r c h a n t . I D   A S   m e r c h a n t _ I D  
                         , m e r c h a n t . P A R T N E R   A S   m e r c h a n t _ P A R T N E R  
                         , m e r c h a n t . V E N D O R N A M E   A S   m e r c h a n t _ V E N D O R N A M E  
                         , m e r c h a n t . U S E R N A M E   A S   m e r c h a n t _ U S E R N A M E  
                         , m e r c h a n t . P A S S W O R D   A S   m e r c h a n t _ P A S S W O R D  
                         , m e r c h a n t . T R A N _ F E E _ P E R C E N T A G E   A S   m e r c h a n t _ T R A N _ F E E _ P E R C E N T A G E  
                         , m e r c h a n t . T R A N _ F E E _ F L A T   A S   m e r c h a n t _ T R A N _ F E E _ F L A T    
             F R O M  
                         E C O M M _ O T C _ T X   O T C T x    
                         I N N E R   J O I N   E C O M M _ S I T E   s i t e   O N   s i t e . I D   =   O T C T x . S I T E _ I D                  
                         I N N E R   J O I N   E C O M M _ M E R C H A N T I N F O   m e r c h a n t   o n   m e r c h a n t . S I T E _ I D   =   s i t e . I D 	  
 	 W H E R E   ( 1 = 1 )   A N D   M E R C H A N T . I D   =   O T C T x . M E R C H A N T _ I D '  
 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   O T C T x . T X _ R E F E R E N C E _ N U M   =   ' ' '   +   @ T R A N S A C T I O N _ R E F _ N U M   +   ' ' ' '  
 I F   ( @ S I T E _ N A M E   I S   N O T   N U L L   A N D   @ S I T E _ N A M E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   S I T E . N A M E   =   ' ' '   +     @ S I T E _ N A M E   +   ' ' ' '  
 S E T   @ S Q L   =   @ S Q L   +   @ C O N D I T I O N    
 E x e c u t e   S P _ E X E C U T E S Q L     @ S Q L  
 p r i n t   @ s q l  
 E N D  
 G O  
 