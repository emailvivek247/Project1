/ * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ G E T _ R E C E I P T _ D E T A I L S _ R P T ]         S c r i p t   D a t e :   0 8 / 1 4 / 2 0 1 2   1 3 : 5 7 : 0 1   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   P R O C E D U R E     [ d b o ] . [ S P _ G E T _ R E C E I P T _ D E T A I L S _ R P T ]   	  
 	   @ T R A N _ R E F _ N U M   V A R C H A R ( 2 0 ) ,   @ S I T E _ I D   I N T  
 A S  
 S E T   N O C O U N T   O N  
 D E C L A R E   @ S Q L   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 D E C L A R E   @ C O N D I T I O N   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 S E T   @ S Q L   =   ' S E L E C T    
 	 T X . O F F I C E _ L O C _ N A M E   A S   B U S I N E S S N A M E ,  
 	 T X . O F F I C E _ L O C _ A D D R L I N E 1   A S   A D D R E S S _ L I N E _ 1 ,  
 	 T X . O F F I C E _ L O C _ A D D R L I N E 2   A S   A D D R E S S _ L I N E _ 2 ,  
 	 T X . O F F I C E _ L O C _ C I T Y   A S   C I T Y ,  
 	 T X . O F F I C E _ L O C _ S T A T E   A S   S T A T E ,  
 	 T X . O F F I C E _ L O C _ Z I P   A S   Z I P ,  
 	 T X . O F F I C E _ L O C _ P H O N E   A S   P H O N E ,  
 	 T X . O F F I C E _ L O C _ C O M M E N T S 1   A S   C O M M E N T S _ 1 ,  
 	 T X . O F F I C E _ L O C _ C O M M E N T S 2   A S   C O M M E N T S _ 2 ,  
 	 T X . T X _ R E F E R E N C E _ N U M ,  
 	 T X . C A R D _ N U M B E R ,  
 	 T X . A M O U N T ,  
 	 T X . S E R V I C E _ F E E ,  
 	 T X . T X _ A M O U N T ,  
 	 T X . C O M M E N T S ,  
 	 T X . T X _ T Y P E ,  
 	 T X . C H E C K N U M ,  
 	 T X . A C C O U N T N A M E ,  
 	 T X . M A C H I N E N A M E ,  
 	 T X . T X _ D A T E ,  
 	 T X . O R G _ R E F _ N U M ,  
 	 T X . M O D _ U S E R _ I D ,  
 	 T X . S I G N A T U R E ,  
 	 T X . A U T H _ C O D E ,  
 	 T X . C A R D _ T Y P E  
 F R O M    
 	 E C O M M _ O T C _ T X   T X  
 	 L E F T   O U T E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T X . S I T E _ I D  
 W H E R E  
 	 ( 1   = 1 )   '      
 I F   ( @ T R A N _ R E F _ N U M   I S   N O T   N U L L   A N D   @ T R A N _ R E F _ N U M   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   T X . T X _ R E F E R E N C E _ N U M   =   ' ' '   +     @ T R A N _ R E F _ N U M   +   ' ' ' ' 	  
 I F   ( @ S I T E _ I D   I S   N O T   N U L L   A N D   @ S I T E _ I D   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   S I T E . I D   =   ' ' '   +     C O N V E R T ( V A R C H A R , @ S I T E _ I D )   +   ' ' ' '  
 S E T   @ S Q L   =   @ S Q L   +   @ C O N D I T I O N  
 E x e c u t e   S P _ E X E C U T E S Q L     @ S Q L  
 G O  
 