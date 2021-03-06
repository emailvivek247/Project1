/ * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ G E T _ W E B P A Y _ T R A N _ H I S T _ R P T ]         S c r i p t   D a t e :   0 8 / 1 4 / 2 0 1 2   1 3 : 5 7 : 0 2   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   P R O C E D U R E   [ d b o ] . [ S P _ G E T _ W E B P A Y _ T R A N _ H I S T _ R P T ]    
 	 @ S I T E _ I D   I N T ,   @ F R O M _ D A T E   V A R C H A R ( 2 0 ) ,   @ T O _ D A T E   V A R C H A R ( 2 0 ) ,   @ T X _ T Y P E   V A R C H A R ( 2 0 )  
 A S  
 B E G I N  
 D E C L A R E   @ S Q L   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 D E C L A R E   @ C O N D I T I O N   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 S E T   @ S Q L   =   ' S E L E C T    
 	 N O D E . I D   A S   N O D E _ I D ,  
 	 N O D E . D E S C R I P T I O N   A S   N O D E _ N A M E ,  
 	 S I T E . I D   A S   S I T E _ I D ,  
 	 S I T E . D E S C R I P T I O N   A S   S I T E _ N A M E ,  
 	 I N F O . T X _ R E F E R E N C E _ N U M ,    
 	 I N F O . C A R D _ N U M B E R ,    
 	 I N F O . A M O U N T ,  
 	 I N F O . S E R V I C E _ F E E ,    
 	 I N F O . T X _ A M O U N T ,    
 	 I N F O . T X _ T Y P E ,    
 	 I N F O . C H E C K N U M ,    
 	 I N F O . A C C O U N T N A M E   A S   C A R D N A M E ,    
 	 I N F O . O R G _ R E F _ N U M , 	 	  
 	 I N F O . S E T T L E M E N T _ S T A T U S ,    
 	 I N F O . T X _ D A T E , 	  
 	 I N F O . M O D _ U S E R _ I D ,  
 	 I N F O . C O M M E N T S ,  
 	 P U R C H A S E D _ D O C U M E N T S   =   ( S E L E C T   C O U N T ( I D )   F R O M   E C O M M _ W E B P A Y _ P U R C H A S E D _ I T E M S   W H E R E   W E B T X _ I D   =   I N F O . I D ) ,  
 	 R E F U N D E D _ D O C U M E N T S   =   ( S E L E C T   C O U N T ( I D )   F R O M   E C O M M _ W E B P A Y _ P U R C H A S E D _ I T E M S   W H E R E   R E F U N D _ T R A N _ I D   =   I N F O . I D ) , 	  
 	 I N F O . A P P L I C A T I O N ,  
 	 C A S T (   ( ( ( I N F O . T X _ A M O U N T   *   I N F O . T R A N _ F E E _ P E R C E N T A G E ) / 1 0 0 )   +   I N F O . T R A N _ F E E _ F L A T )     A S   D E C ( 1 0 , 2 ) )   A S   T R A N S A C T I O N _ C O S T ,  
         C A S E   T X _ T Y P E  
 	 	 W H E N   ' ' C H A R G E ' '   T H E N  
 	 	 	 ( I N F O . T X _ A M O U N T   -   C A S T (   ( ( ( I N F O . T X _ A M O U N T   *   I N F O . T R A N _ F E E _ P E R C E N T A G E ) / 1 0 0 )   +   I N F O . T R A N _ F E E _ F L A T )     A S   D E C ( 1 0 , 2 ) ) )    
 	 	 W H E N   ' ' R E F U N D ' '   T H E N  
 	 	 	 0   -   ( I N F O . T X _ A M O U N T   +   C A S T (   ( ( ( I N F O . T X _ A M O U N T   *   I N F O . T R A N _ F E E _ P E R C E N T A G E ) / 1 0 0 )   +   I N F O . T R A N _ F E E _ F L A T )     A S   D E C ( 1 0 , 2 ) ) )    
 	 E N D 	 A S   N E T P R O F I T  
 F R O M   E C O M M _ W E B P A Y _ T X   I N F O  
 	  
 	   I N N E R   J O I N   E C O M M _ M E R C H A N T I N F O   M E R C H A N T   O N   M E R C H A N T . I D   =   I N F O . M E R C H A N T _ I D  
 	   I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   M E R C H A N T . S I T E _ I D  
 	   I N N E R   J O I N   E C O M M _ N O D E   N O D E   O N   N O D E . I D   =   S I T E . N O D E _ I D 	  
 	 W H E R E   ( 1 = 1 ) '  
 I F   ( @ F R O M _ D A T E   I S   N O T   N U L L   A N D   @ F R O M _ D A T E   < >   ' '   A N D   @ T O _ D A T E   I S   N O T   N U L L   A N D   @ T O _ D A T E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   c o n v e r t ( D A T E ,   I N F O . T X _ D A T E ,   1 0 1 )   > =   ' ' '   +   @ F R O M _ D A T E   +   ' ' '   A N D   c o n v e r t ( D A T E ,   I N F O . T X _ D A T E ,   1 0 1 )   < =   ' ' '   +     @ T O _ D A T E   +   ' ' ' '  
 I F   ( @ S I T E _ I D   I S   N O T   N U L L   A N D   @ S I T E _ I D   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   S I T E . I D   =   ' ' '   +     C O N V E R T ( V A R C H A R , @ S I T E _ I D )   +   ' ' ' '  
 I F   ( @ T X _ T Y P E   I S   N O T   N U L L   A N D   @ T X _ T Y P E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   I N F O . T X _ T Y P E   =   ' ' '   +     @ T X _ T Y P E   +   ' ' ' '  
  
 S E T   @ S Q L   =   @ S Q L   +   @ C O N D I T I O N   +   '   O R D E R   B Y   S I T E . D E S C R I P T I O N ,   I N F O . T X _ D A T E   A S C '  
  
 E x e c u t e   S P _ E X E C U T E S Q L     @ S Q L  
  
 E N D  
 G O  
 