/ * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ T R A N S A C T I O N _ L O O K U P ]         S c r i p t   D a t e :   0 8 / 1 4 / 2 0 1 2   1 3 : 5 7 : 0 2   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   P R O C E D U R E     [ d b o ] . [ S P _ T R A N S A C T I O N _ L O O K U P ]    
 	 	 @ T R A N S A C T I O N _ R E F _ N U M   V A R C H A R ( 5 0 ) ,   @ A C C O U N T N A M E   V A R C H A R ( 5 0 ) ,   @ A C C O U N T N U M B E R   V A R C H A R ( 5 0 ) ,   @ T R A N S _ D A T E   V A R C H A R ( 1 0 ) ,   @ P A Y M E N T _ C H A N N E L   V A R C H A R ( 1 0 ) ,   @ S I T E _ N A M E   V A R C H A R ( 5 0 ) 	  
 A S  
 B E G I N  
 D E C L A R E   @ S Q L   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 D E C L A R E   @ C O N D I T I O N   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 S E T   @ S Q L   =   ' S E L E C T   D I S T I N C T  
                         T X . I D   A S   T X _ I D  
                         , T X . T X _ R E F E R E N C E _ N U M   A S   T X _ T X _ R E F E R E N C E _ N U M  
                         , T X . O R G _ R E F _ N U M   A S   T X _ O R G _ R E F _ N U M  
                         , T X . A M O U N T   A S   T X _ A M O U N T  
                         , T X . S E R V I C E _ F E E   A S   T X _ S E R V I C E _ F E E  
                         , T X . T X _ A M O U N T   A S   T X _ T X _ A M O U N T  
                         , T X . C O M M E N T S   A S   T X _ C O M M E N T S  
                         , T X . T X _ T Y P E   A S   T X _ T X _ T Y P E  
                         , T X . C H E C K N U M   A S   T X _ C H E C K N U M  
                         , T X . T X _ D A T E   A S   T X _ T X _ D A T E     	                                          
                         , T X . C A R D _ N U M B E R   A S   T X _ C A R D _ N U M B E R  
                         , T X . A C C O U N T N A M E   A S   T X _ A C C O U N T N A M E                          
                         , T X . M O D _ U S E R _ I D   A S   T X _ M O D _ U S E R _ I D  
                         , T X . D A T E _ T I M E _ C R E A T E D   A S   T X _ D A T E _ T I M E _ C R E A T E D  
                         , T X . S E T T L E M E N T _ S T A T U S   A S   T X _ S E T T L E M E N T _ S T A T U S  
                         , T X . C R E A T E D _ B Y   A S   T X _ C R E A T E D _ B Y   '  
 I F   ( @ P A Y M E N T _ C H A N N E L   =   ' O T C ' )                          
 	 S E T   @ S Q L   =   @ S Q L   +   '   F R O M   E C O M M _ O T C _ T X   T X   I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T X . S I T E _ I D   '  
 I F   ( @ P A Y M E N T _ C H A N N E L   =   ' R E C U R R I N G ' )                          
 	 S E T   @ S Q L   =   @ S Q L   +   '   F R O M   E C O M M _ R E C U R _ T X _ H I S T _ I N F O   T X   I N N E R   J O I N   A U T H _ A C C E S S   A C C E S S   O N   A C C E S S . I D   =   T X . A C C E S S _ I D   I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   S I T E A C C E S S   O N   S I T E A C C E S S . A C C E S S _ I D   =   A C C E S S . I D  
 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   S I T E A C C E S S . S I T E _ I D   '  
 I F   ( @ P A Y M E N T _ C H A N N E L   =   ' W E B ' )                          
 	 S E T   @ S Q L   =   @ S Q L   +   '   F R O M   E C O M M _ W E B P A Y _ T X   T X   I N N E R   J O I N   E C O M M _ W E B P A Y _ P U R C H A S E D _ I T E M S   w e b T x I t e m s   O N   ( w e b T x I t e m s . W E B T X _ I D   =   T X . I D   O R   T X . I D   =   w e b T x I t e m s . R E F U N D _ T R A N _ I D )  
 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T X . S I T E _ I D   ' 	  
 S E T   @ S Q L   =   @ S Q L   +   '   W H E R E   ( 1 = 1 )   '  
 I F   ( @ T R A N S A C T I O N _ R E F _ N U M   I S   N O T   N U L L   A N D   @ T R A N S A C T I O N _ R E F _ N U M   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   T X . T X _ R E F E R E N C E _ N U M   =   ' ' '   +   @ T R A N S A C T I O N _ R E F _ N U M   +   ' ' ' '  
 I F   ( @ A C C O U N T N A M E   I S   N O T   N U L L   A N D   @ A C C O U N T N A M E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   T X . A C C O U N T N A M E   L I K E   ' ' % '   +     @ A C C O U N T N A M E   +   ' % ' ' '  
 I F   ( @ A C C O U N T N U M B E R   I S   N O T   N U L L   A N D   @ A C C O U N T N U M B E R   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   T X . C A R D _ N U M B E R   =   ' ' '   +   @ A C C O U N T N U M B E R   +   ' ' ' '  
 I F   ( @ T R A N S _ D A T E   I S   N O T   N U L L   A N D   @ T R A N S _ D A T E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   C O N V E R T ( V A R C H A R ( 1 0 ) ,   T X . T X _ D A T E ,   1 0 1 )   =   ' ' '   +   @ T R A N S _ D A T E   +   ' ' ' '  
 I F   ( @ S I T E _ N A M E   I S   N O T   N U L L   A N D   @ S I T E _ N A M E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   S I T E . N A M E   =   ' ' '   +     @ S I T E _ N A M E   +   ' ' ' '  
 S E T   @ S Q L   =   @ S Q L   +   @ C O N D I T I O N    
 E x e c u t e   S P _ E X E C U T E S Q L     @ S Q L  
 P R I N T   @ S Q L  
 E N D  
 G O  
 