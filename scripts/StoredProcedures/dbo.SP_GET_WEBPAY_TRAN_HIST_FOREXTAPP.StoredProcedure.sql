/ * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ G E T _ W E B P A Y _ T R A N _ H I S T _ F O R E X T A P P ]         S c r i p t   D a t e :   0 8 / 1 4 / 2 0 1 2   1 3 : 5 7 : 0 1   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   P R O C E D U R E     [ d b o ] . [ S P _ G E T _ W E B P A Y _ T R A N _ H I S T _ F O R E X T A P P ]    
 	 @ S I T E _ N A M E   V A R C H A R ( 5 0 ) ,   @ F R O M _ D A T E   D A T E T I M E ,   @ T O _ D A T E   D A T E T I M E ,   @ T X _ T Y P E   V A R C H A R ( 1 0 )  
 A S  
 B E G I N  
 D E C L A R E   @ S Q L   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 D E C L A R E   @ C O N D I T I O N   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 S E T   @ S Q L   =   ' S E L E C T  
 	 I N F O . I D   A S   I N F O _ I D ,    
 	 I N F O . T X _ R E F E R E N C E _ N U M   A S   I N F O _ T X _ R E F E R E N C E _ N U M ,    
 	 I N F O . C A R D _ N U M B E R   A S   I N F O _ C A R D _ N U M B E R ,    
 	 I N F O . A M O U N T   A S   I N F O _ A M O U N T ,  
 	 I N F O . S E R V I C E _ F E E   A S   I N F O _ S E R V I C E _ F E E ,    
 	 I N F O . T X _ A M O U N T   A S   I N F O _ T X _ A M O U N T ,    
 	 I N F O . T A X   A S   I N F O _ T A X ,  
 	 I N F O . T X _ T Y P E   A S   I N F O _ T X _ T Y P E ,    
 	 I N F O . A C C O U N T N A M E   A S   I N F O _ A C C O U N T N A M E ,    
 	 I N F O . O R G _ R E F _ N U M   A S   I N F O _ O R G _ R E F _ N U M , 	 	  
 	 I N F O . S E T T L E M E N T _ S T A T U S   A S   I N F O _ S E T T L E M E N T _ S T A T U S ,    
 	 I N F O . T X _ D A T E   A S   I N F O _ T X _ D A T E , 	  
 	 I N F O . M O D _ U S E R _ I D   A S   I N F O _ M O D _ U S E R _ I D ,  
 	 I N F O . C O M M E N T S   A S   I N F O _ C O M M E N T S ,  
 	 P U R C H A S E D _ D O C U M E N T S   =   ( S E L E C T   C O U N T ( I D )   F R O M   E C O M M _ W E B P A Y _ P U R C H A S E D _ I T E M S   W H E R E   W E B T X _ I D   =   I N F O . I D ) ,  
 	 R E F U N D E D _ D O C U M E N T S   =   ( S E L E C T   C O U N T ( I D )   F R O M   E C O M M _ W E B P A Y _ P U R C H A S E D _ I T E M S   W H E R E   R E F U N D _ T R A N _ I D   =   I N F O . I D ) , 	  
 	 I N F O . A P P L I C A T I O N   A S   I N F O _ A P P L I C A T I O N ,  
 	 I T E M S . I D   A S   I T E M S _ I D ,  
 	 I T E M S . P R O D U C T _ I D   A S   I T E M S _ P R O D U C T _ I D ,  
 	 I T E M S . I T E M _ N A M E   A S   I T E M S _ I T E M _ N A M E ,  
 	 I T E M S . P R O D U C T _ T Y P E   A S   I T E M S _ P R O D U C T _ T Y P E ,  
 	 I T E M S . P A G E _ C O U N T   A S   I T E M S _ P A G E _ C O U N T ,  
 	 I T E M S . I T E M _ Q U A N T I T Y   A S   I T E M S _ I T E M _ Q U A N T I T Y ,  
 	 I T E M S . A M O U N T   A S   I T E M S _ A M O U N T ,  
 	 I T E M S . S E R V I C E _ F E E   A S   I T E M S _ S E R V I C E _ F E E ,  
 	 I T E M S . T A X   A S   I T E M S _ T A X ,  
 	 I T E M S . T O T A L _ A M O U N T   A S   I T E M S _ T O T A L _ A M O U N T ,  
 	 I T E M S . D O W N L O A D _ U R L   A S   I T E M S _ D O W N L O A D _ U R L ,  
 	 I T E M S . R E F U N D _ T R A N _ I D   A S   I T E M S _ R E F U N D _ T R A N _ I D ,  
 	 I T E M S . I S _ R E F U N D E D   A S   I T E M S _ I S _ R E F U N D E D ,  
 	 I T E M S . C A S E _ N U M B E R   A S   I T E M S _ C A S E _ N U M B E R ,  
 	 I T E M S . P A R T Y _ R O L E   A S   I T E M S _ P A R T Y _ R O L E ,  
 	 I T E M S . P A R T Y _ S E Q   A S   I T E M S _ P A R T Y _ S E Q ,  
 	 I N F O . O F F I C E _ L O C _ N A M E   A S   I N F O _ O F F I C E _ L O C _ N A M E ,  
 	 I N F O . O F F I C E _ L O C _ A D D R L I N E 1   A S   I N F O _ O F F I C E _ L O C _ A D D R L I N E 1 ,  
 	 I N F O . O F F I C E _ L O C _ A D D R L I N E 2   A S   I N F O _ O F F I C E _ L O C _ A D D R L I N E 2 ,  
 	 I N F O . O F F I C E _ L O C _ C I T Y   A S   I N F O _ O F F I C E _ L O C _ C I T Y ,  
 	 I N F O . O F F I C E _ L O C _ S T A T E   A S   I N F O _ O F F I C E _ L O C _ S T A T E ,  
 	 I N F O . O F F I C E _ L O C _ Z I P   A S   I N F O _ O F F I C E _ L O C _ Z I P ,  
 	 I N F O . O F F I C E _ L O C _ P H O N E   A S   I N F O _ O F F I C E _ L O C _ P H O N E ,  
 	 I N F O . O F F I C E _ L O C _ C O M M E N T S 1   A S   I N F O _ O F F I C E _ L O C _ C O M M E N T S 1 ,  
 	 I N F O . O F F I C E _ L O C _ C O M M E N T S 2   A S   I N F O _ O F F I C E _ L O C _ C O M M E N T S 2  
 F R O M   E C O M M _ W E B P A Y _ T X   I N F O  
 	   I N N E R   J O I N   E C O M M _ W E B P A Y _ P U R C H A S E D _ I T E M S   I T E M S   O N   I T E M S . W E B T X _ I D   =   I N F O . I D 	  
 	   I N N E R   J O I N   E C O M M _ M E R C H A N T I N F O   M E R C H A N T   O N   M E R C H A N T . I D   =   I N F O . M E R C H A N T _ I D  
 	   I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   M E R C H A N T . S I T E _ I D  
 	   I N N E R   J O I N   E C O M M _ N O D E   N O D E   O N   N O D E . I D   =   S I T E . N O D E _ I D 	  
 	 W H E R E   ( 1 = 1 ) '  
 I F   ( @ F R O M _ D A T E   I S   N O T   N U L L   A N D   @ F R O M _ D A T E   < >   ' '   A N D   @ T O _ D A T E   I S   N O T   N U L L   A N D   @ T O _ D A T E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   I N F O . T X _ D A T E   > =   C O N V E R T ( D A T E T I M E , ' ' '   +       c o n v e r t ( v a r c h a r ,   @ F R O M _ D A T E ,   1 2 0 )   +   ' ' ' )   A N D   I N F O . T X _ D A T E   < =   C O N V E R T ( D A T E T I M E , ' ' '   +       c o n v e r t ( v a r c h a r ,   @ T O _ D A T E ,   1 2 0 )   +   ' ' ' ) '  
 I F   ( @ S I T E _ N A M E   I S   N O T   N U L L   A N D   @ S I T E _ N A M E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   S I T E . N A M E   =   ' ' '   +     @ S I T E _ N A M E   +   ' ' ' '  
 I F   ( @ T X _ T Y P E   I S   N O T   N U L L   A N D   @ T X _ T Y P E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   I N F O . T X _ T Y P E   =   ' ' '   +     @ T X _ T Y P E   +   ' ' ' '  
  
 S E T   @ S Q L   =   @ S Q L   +   @ C O N D I T I O N   +   '   O R D E R   B Y   S I T E . D E S C R I P T I O N ,   I N F O . T X _ D A T E   A S C '  
 E x e c u t e   S P _ E X E C U T E S Q L     @ S Q L  
 E N D  
 G O  
 