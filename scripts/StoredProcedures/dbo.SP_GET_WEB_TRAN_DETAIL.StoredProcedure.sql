/ * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ G E T _ W E B _ T R A N _ D E T A I L ]         S c r i p t   D a t e :   0 8 / 1 4 / 2 0 1 2   1 3 : 5 7 : 0 1   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   P R O C E D U R E     [ d b o ] . [ S P _ G E T _ W E B _ T R A N _ D E T A I L ]    
 	 	 @ U S E R N A M E   V A R C H A R ( 5 0 ) ,   @ T X _ I D   I N T ,   @ I S _ R E F U N D   C H A R ( 1 )   =   ' N '  
 A S  
 B E G I N  
  
 I F   ( @ I S _ R E F U N D   =   ' N ' )  
 	 S E L E C T  
 	 	 	   w e b T x . I D   A S   w e b T x _ I D  
 	 	 	 , w e b T x . T X _ R E F E R E N C E _ N U M   A S   w e b T x _ T X _ R E F E R E N C E _ N U M  
 	 	 	 , w e b T x . A M O U N T   A S   w e b T x _ A M O U N T  
 	 	 	 , w e b T x . S E R V I C E _ F E E   A S   w e b T x _ S E R V I C E _ F E E  
 	 	 	 , w e b T x . T X _ A M O U N T   A S   w e b T x _ T X _ A M O U N T  
 	 	 	 , w e b T x . T X _ D A T E   A S   w e b T x _ T X _ D A T E 	   	 	 	  
 	 	 	 , w e b T x . C A R D _ N U M B E R   A S   w e b T x _ C A R D _ N U M B E R  
 	 	 	 , w e b T x . A C C O U N T N A M E   A S   w e b T x _ A C C O U N T N A M E  
 	 	 	 , w e b T x . T X _ T Y P E   A S   w e b T x _ T X _ T Y P E  
 	 	 	 , w e b T x . D A T E _ T I M E _ C R E A T E D   A S   w e b T x _ D A T E _ T I M E _ C R E A T E D  
 	 	 	 , s i t e . N A M E   A S   s i t e _ N A M E  
 	 	 	 , a c c e s s . A C C E S S _ D E S C R   A S   a c c e s s _ A C C E S S _ D E S C R  
 	 	 	 , w e b T x I t e m s . P R O D U C T _ I D   A S   w e b T x I t e m s _ P R O D U C T _ I D  
 	 	 	 , w e b T x I t e m s . P R O D U C T _ T Y P E   A S   w e b T x I t e m s _ P R O D U C T _ T Y P E  
 	 	 	 , w e b T x I t e m s . P A G E _ C O U N T   A S   w e b T x I t e m s _ P A G E _ C O U N T  
 	 	 	 , w e b T x I t e m s . A M O U N T   A S   w e b T x I t e m s _ A M O U N T  
 	 	 	 , w e b T x I t e m s . S E R V I C E _ F E E   A S   w e b T x I t e m s _ S E R V I C E _ F E E  
 	 	 	 , w e b T x I t e m s . T O T A L _ A M O U N T   A S   w e b T x I t e m s _ T O T A L _ A M O U N T  
 	 	 	 , w e b T x I t e m s . I S _ R E F U N D E D 	 A S   w e b T x I t e m s _ I S _ R E F U N D E D 	  
 	 	 	 , w e b T x I t e m s . D A T E _ T I M E _ M O D   A S   w e b T x I t e m s _ D A T E _ T I M E _ M O D  
 	 	 	 , ( S E L E C T   e w t . C O M M E N T S   A S   e w t _ C O M M E N T S   F R O M   E C O M M _ W E B P A Y _ T X   e w t   w h e r e   e w t . I D   =   w e b T x I t e m s . R E F U N D _ T R A N _ I D )   A S   c o m m e n t s  
 	 	 	 , w e b T x I t e m s . D O W N L O A D _ U R L   A S   w e b T x I t e m s _ D O W N L O A D _ U R L  
 	 	 	 , w e b T x I t e m s . I S _ D O C U M E N T _ A V A I L A B L E   A S   w e b T x I t e m s _ I S _ D O C U M E N T _ A V A I L A B L E 	   	  
 	 	 F R O M  
 	 	 	 E C O M M _ W E B P A Y _ T X   w e b T x  
 	 	 	 I N N E R   J O I N   E C O M M _ W E B P A Y _ P U R C H A S E D _ I T E M S   w e b T x I t e m s   O N   w e b T x I t e m s . W E B T X _ I D   =   w e b T x . I D      
 	 	 	 I N N E R   J O I N   A U T H _ U S E R S   u s e r s   O N   w e b T x . U S E R _ I D   =   u s e r s . I D  
 	 	 	 I N N E R   J O I N   A U T H _ A C C E S S   a c c e s s   O N   a c c e s s . I D   =   w e b T x I t e m s . A C C E S S _ I D  
 	 	 	 I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   s i t e a c c e s s   O N   s i t e a c c e s s . A C C E S S _ I D   =   a c c e s s . I D  
 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   s i t e   O N   s i t e . I D   =   s i t e a c c e s s . S I T E _ I D 	 	    
 	 	 W H E R E  
 	 	 	 u s e r s . E M A I L _ I D   =   @ U S E R N A M E   A N D  
 	 	 	 w e b T x . I D               =   @ T X _ I D  
 	 	 O R D E R   B Y    
 	 	 	 s i t e . N A M E ,    
 	 	 	 a c c e s s . A C C E S S _ D E S C R ,    
 	 	 	 w e b T x . T X _ D A T E   d e s c  
 E L S E    
 	 S E L E C T  
 	 	 	 w e b T x . I D   A S   w e b T x _ I D  
 	 	 	 , w e b T x . T X _ R E F E R E N C E _ N U M   A S   w e b T x _ T X _ R E F E R E N C E _ N U M  
 	 	 	 , w e b T x . A M O U N T   A S   w e b T x _ A M O U N T  
 	 	 	 , w e b T x . S E R V I C E _ F E E   A S   w e b T x _ S E R V I C E _ F E E  
 	 	 	 , w e b T x . T X _ A M O U N T   A S   w e b T x _ T X _ A M O U N T  
 	 	 	 , w e b T x . T X _ D A T E   A S   w e b T x _ T X _ D A T E 	 	 	 	  
 	 	 	 , w e b T x . C A R D _ N U M B E R   A S   w e b T x _ C A R D _ N U M B E R  
 	 	 	 , w e b T x . A C C O U N T N A M E   A S   w e b T x _ A C C O U N T N A M E  
 	 	 	 , w e b T x . T X _ T Y P E   A S   w e b T x _ T X _ T Y P E  
 	 	 	 , w e b T x . D A T E _ T I M E _ C R E A T E D   A S   w e b T x _ D A T E _ T I M E _ C R E A T E D  
 	 	 	 , s i t e . N A M E   A S   s i t e _ N A M E  
 	 	 	 , a c c e s s . A C C E S S _ D E S C R   A S   a c c e s s _ A C C E S S _ D E S C R  
 	 	 	 , w e b T x I t e m s . P R O D U C T _ I D   A S   w e b T x I t e m s _ P R O D U C T _ I D  
 	 	 	 , w e b T x I t e m s . P R O D U C T _ T Y P E   A S   w e b T x I t e m s _ P R O D U C T _ T Y P E  
 	 	 	 , w e b T x I t e m s . P A G E _ C O U N T   A S   w e b T x I t e m s _ P A G E _ C O U N T  
 	 	 	 , w e b T x I t e m s . A M O U N T   A S   w e b T x I t e m s _ A M O U N T  
 	 	 	 , w e b T x I t e m s . S E R V I C E _ F E E   A S   w e b T x I t e m s _ S E R V I C E _ F E E  
 	 	 	 , w e b T x I t e m s . T O T A L _ A M O U N T   A S   w e b T x I t e m s _ T O T A L _ A M O U N T  
 	 	 	 , w e b T x I t e m s . I S _ R E F U N D E D   A S   w e b T x I t e m s _ I S _ R E F U N D E D  
 	 	 	 , w e b T x I t e m s . D A T E _ T I M E _ M O D   A S   w e b T x I t e m s _ D A T E _ T I M E _ M O D  
 	 	 	 , ( S E L E C T   C O M M E N T S   F R O M   E C O M M _ W E B P A Y _ T X   w h e r e   I D   =   w e b T x I t e m s . R E F U N D _ T R A N _ I D )   A S   c o m m e n t s  
 	 	 	 , w e b T x I t e m s . D O W N L O A D _ U R L   A S   w e b T x I t e m s _ D O W N L O A D _ U R L  
 	 	 	 , w e b T x I t e m s . I S _ D O C U M E N T _ A V A I L A B L E   A S   w e b T x I t e m s _ I S _ D O C U M E N T _ A V A I L A B L E 	 	  
 	 	 F R O M  
 	 	 	 E C O M M _ W E B P A Y _ T X   w e b T x  
 	 	 	 I N N E R   J O I N   E C O M M _ W E B P A Y _ P U R C H A S E D _ I T E M S   w e b T x I t e m s   O N   w e b T x I t e m s . R E F U N D _ T R A N _ I D   =   w e b T x . I D      
 	 	 	 I N N E R   J O I N   A U T H _ U S E R S   u s e r s   O N   w e b T x . U S E R _ I D   =   u s e r s . I D  
 	 	 	 I N N E R   J O I N   A U T H _ A C C E S S   a c c e s s   O N   a c c e s s . I D   =   w e b T x I t e m s . A C C E S S _ I D  
 	 	 	 I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   s i t e a c c e s s   O N   s i t e a c c e s s . A C C E S S _ I D   =   a c c e s s . I D  
 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   s i t e   O N   s i t e . I D   =   s i t e a c c e s s . S I T E _ I D 	 	    
 	 	 W H E R E  
 	 	 	 u s e r s . E M A I L _ I D   =   @ U S E R N A M E   A N D  
 	 	 	 w e b T x . I D               =   @ T X _ I D  
 	 	 O R D E R   B Y    
 	 	 	 s i t e . N A M E ,    
 	 	 	 a c c e s s . A C C E S S _ D E S C R ,    
 	 	 	 w e b T x . T X _ D A T E   d e s c  
 	  
 E N D  
 G O  
 