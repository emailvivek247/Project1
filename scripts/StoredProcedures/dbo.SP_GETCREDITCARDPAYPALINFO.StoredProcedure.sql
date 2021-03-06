/ * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ G E T C R E D I T C A R D P A Y P A L I N F O ]         S c r i p t   D a t e :   0 8 / 1 4 / 2 0 1 2   1 3 : 5 7 : 0 2   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   P R O C E D U R E     [ d b o ] . [ S P _ G E T C R E D I T C A R D P A Y P A L I N F O ]    
 	 @ U S E R N A M E   V A R C H A R ( 5 0 )  
 A S    
 S E L E C T  
         S I T E . I D   A S   S I T E _ I D ,  
         P A Y _ P A L _ I D   =   ( S E L E C T   T O P   1   P A Y _ P A L _ I D   F R O M   E C O M M _ U S E R S _ A C C O U N T   W H E R E   U S E R _ A C C E S S _ I D   =   U S E R A C C E S S . I D 	 ) , 	  
 	 M E R C H A N T . U S E R N A M E   A S   M E R C H A N T _ U S E R N A M E ,  
 	 M E R C H A N T . P A S S W O R D   A S   M E R C H A N T _ P A S S W O R D ,  
 	 M E R C H A N T . V E N D O R N A M E   A S   M E R C H A N T _ V E N D O R N A M E ,  
 	 M E R C H A N T . P A R T N E R   A S   M E R C H A N T _ P A R T N E R ,  
 	 A C C O U N T I D   =   ( S E L E C T   T O P   1   I D   F R O M   E C O M M _ C C I N F O   W H E R E   U S E R _ I D   =   U S E R S . I D ) ,                                            
 	 U S E R S . I D   A S   U S E R S _ I D ,  
 	 C R E A T E D D A T E   =   ( S E L E C T   T O P   1   D A T E _ T I M E _ C R E A T E D   F R O M   E C O M M _ C C I N F O   W H E R E   U S E R _ I D   =   U S E R S . I D ) ,  
 	 L O O K U P . C O D E   A S   L O O K U P _ C O D E ,  
 	 M E R C H A N T . T R A N _ F E E _ P E R C E N T A G E   A S   M E R C H A N T _ T R A N _ F E E _ P E R C E N T A G E ,  
         M E R C H A N T . T R A N _ F E E _ F L A T   A S   M E R C H A N T _ T R A N _ F E E _ F L A T ,  
         S H A R E . C L I E N T _ S H A R E   A S   S H A R E _ C L I E N T _ S H A R E ,  
         U S E R A C C O U N T . M A R K _ F O R _ C A N C E L L A T I O N   A S   U S E R A C C O U N T _ M A R K _ F O R _ C A N C E L L A T I O N ,  
         A C C E S S . I D   A S   A C C E S S _ I D                
 F R O M  
 	 E C O M M _ S I T E   S I T E  
 	 I N N E R   J O I N   E C O M M _ M E R C H A N T I N F O   M E R C H A N T   O N   M E R C H A N T . S I T E _ I D   =   S I T E . I D  
 	 I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   S I T E A C C E S S   O N   S I T E A C C E S S . S I T E _ I D   =   S I T E . I D  
 	 I N N E R   J O I N   E C O M M _ S U B S C R I P T I O N F E E   F E E   O N   F E E . S I T E A C C E S S _ I D   =   S I T E A C C E S S . I D  
 	 I N N E R   J O I N   C O D E L O O K U P   L O O K U P   O N   L O O K U P . I D   =   F E E . S U B S C R I P T I O N _ T Y P _ I D  
 	 I N N E R   J O I N   A U T H _ A C C E S S   A C C E S S   O N   A C C E S S . I D   =   S I T E A C C E S S . A C C E S S _ I D 	  
 	 L E F T   O U T E R   J O I N   E C O M M _ P R O F I T _ S H A R E   S H A R E   O N   A C C E S S . I D   =   S H A R E . A C C E S S _ I D  
 	 I N N E R   J O I N   A U T H _ U S E R S _ A C C E S S   U S E R A C C E S S   O N   U S E R A C C E S S . A C C E S S _ I D   =   A C C E S S . I D  
 	 I N N E R   J O I N   A U T H _ U S E R S   U S E R S   O N   U S E R S . I D   =   U S E R A C C E S S . U S E R _ I D  
 	 L E F T   O U T E R   J O I N   E C O M M _ U S E R S _ A C C O U N T   U S E R A C C O U N T   O N   U S E R A C C E S S . I D   =   U S E R A C C O U N T . U S E R _ A C C E S S _ I D  
 W H E R E    
 	 U S E R S . E M A I L _ I D   =   @ U S E R N A M E   A N D  
 	 U S E R S . A C T I V E   =   ' Y '   A N D  
 	 M E R C H A N T . A C T I V E   =   ' Y '   A N D  
 	 S I T E . A C T I V E   =   ' Y '   A N D  
 	 S I T E A C C E S S . A C T I V E   =   ' Y '   A N D  
 	 A C C E S S . A C T I V E   =   ' Y '   A N D  
 	 L O O K U P . C O D E   < >   ' F R E E '  
 G O  
 