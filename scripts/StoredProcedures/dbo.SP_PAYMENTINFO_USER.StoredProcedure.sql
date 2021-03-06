/ * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ P A Y M E N T I N F O _ U S E R ]         S c r i p t   D a t e :   0 8 / 1 4 / 2 0 1 2   1 3 : 5 7 : 0 2   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   P R O C E D U R E     [ d b o ] . [ S P _ P A Y M E N T I N F O _ U S E R ]    
 	 @ U S E R N A M E   V A R C H A R ( 5 0 ) ,  
 	 @ N O D E N A M E   V A R C H A R ( 5 0 )  
 A S    
 B E G I N  
 D E C L A R E   @ S Q L   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 D E C L A R E   @ C O N D I T I O N   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 S E T   @ S Q L   =   ' S E L E C T  
 	     M E R C H A N T . U S E R N A M E   A S   M E R C H A N T _ U S E R N A M E ,    
 	     M E R C H A N T . P A S S W O R D   A S   M E R C H A N T _ P A S S W O R D ,  
 	     M E R C H A N T . V E N D O R N A M E   A S   M E R C H A N T _ V E N D O R N A M E ,  
 	     M E R C H A N T . P A R T N E R   A S   M E R C H A N T _ P A R T N E R , 	        
 	     S I T E . T I M E Z O N E   A S   S I T E _ T I M E Z O N E ,  
 	     E S A . S I T E _ I D     A S   E S A _ S I T E _ I D ,  
             ( S E L E C T   D E S C R I P T I O N   F R O M   E C O M M _ S I T E   S I T E   W H E R E   S I T E . I D   =   E S A . S I T E _ I D )   A S   S I T E ,  
             A A . A C C E S S _ C D   A S   A A _ A C C E S S _ C D ,                          
             A A . A C C E S S _ D E S C R   A S   A A _ A C C E S S _ D E S C R ,              
             E S F . F E E   A S   E S F _ F E E ,  
             E S F . T E R M   A S   E S F _ T E R M ,  
             ( S E L E C T   C O D E   F R O M   C O D E L O O K U P   L O O K U P   W H E R E   L O O K U P . I D   =   E S F . S U B S C R I P T I O N _ T Y P _ I D )   A S   P E R I O D ,  
             C C . I D   A S   C C _ I D ,                                      
             C C . A C C O U N T N A M E   A S   C C _ A C C O U N T N A M E ,  
             C C . A C C O U N T N U M B E R   A S   C C _ A C C O U N T N U M B E R ,  
             C C . E X P M O N   A S   C C _ E X P M O N ,  
             C C . E X P Y E A R   A S   C C _ E X P Y E A R ,  
             C C . A D D R E S S _ 1   A S   C C _ A D D R E S S _ 1 ,  
             C C . A D D R E S S _ 2   A S   C C _ A D D R E S S _ 2 ,  
             C C . C I T Y   A S   C C _ C I T Y ,  
             C A S T ( C C . S T A T E   A S   V A R C H A R ( 2 ) )   A S   C C _ S T A T E ,  
             C C . Z I P   A S   C C _ Z I P ,  
             C C . P H O N E   A S   C C _ P H O N E ,  
             A U . I D     A S   A U _ I D ,  
             A U A . I D   A S   A U A _ I D ,  
             E U A . I D   A S   E U A _ I D ,  
             E U A . P A Y _ P A L _ I D   A S   E U A _ P A Y _ P A L _ I D ,  
             E U A . U S E R _ A C C E S S _ I D   A S   E U A _ U S E R _ A C C E S S _ I D ,  
             E U A . D A T E _ T I M E _ C R E A T E D   A S   E U A _ D A T E _ T I M E _ C R E A T E D ,  
             A A . I D   A S   A A _ I D ,  
             M E R C H A N T . I D   A S   M E R C H A N T _ I D ,  
             A U A . I S _ A U T H O R I Z E D   A S   A U A _ I S _ A U T H O R I Z E D ,  
             M E R C H A N T . T R A N _ F E E _ P E R C E N T A G E   A S   M E R C H A N T _ T R A N _ F E E _ P E R C E N T A G E ,  
             M E R C H A N T . T R A N _ F E E _ F L A T   A S   M E R C H A N T _ T R A N _ F E E _ F L A T ,  
             S H A R E . C L I E N T _ S H A R E   A S   S H A R E _ C L I E N T _ S H A R E  
 F R O M  
             A U T H _ A C C E S S   A A  
             I N N E R   J O I N   A U T H _ U S E R S _ A C C E S S   A U A   O N   A U A . A C C E S S _ I D   =   A A . I D  
             I N N E R   J O I N   A U T H _ U S E R S   A U   O N   A U A . U S E R _ I D   =   A U . I D    
             L E F T   O U T E R   J O I N   E C O M M _ P R O F I T _ S H A R E   S H A R E   O N   S H A R E . A C C E S S _ I D   =   A A . I D  
             L E F T   O U T E R   J O I N   E C O M M _ C C I N F O   C C   O N   C C . U S E R _ I D   =   A U . I D    
             L E F T   O U T E R   J O I N   E C O M M _ U S E R S _ A C C O U N T   E U A   O N   E U A . U S E R _ A C C E S S _ I D   =   A U A . I D  
             I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   E S A   O N   E S A . A C C E S S _ I D   =   A A . I D  
             I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   E S A . S I T E _ I D  
             I N N E R   J O I N   E C O M M _ N O D E   N O D E   O N   N O D E . I D   =   S I T E . N O D E _ I D  
             I N N E R   J O I N   E C O M M _ M E R C H A N T I N F O   M E R C H A N T   O N   M E R C H A N T . S I T E _ I D   =   S I T E . I D  
             I N N E R   J O I N   E C O M M _ S U B S C R I P T I O N F E E   E S F   O N   E S F . S I T E A C C E S S _ I D   =   E S A . I D  
             I N N E R   J O I N   C O D E L O O K U P   L O O K U P   O N   E S F . S U B S C R I P T I O N _ T Y P _ I D   =   L O O K U P . I D   W H E R E   ( 1 = 1 )   A N D   I S _ M I C R O P A Y M E N T _ A C C O U N T   =   ' ' N ' '   A N D   A U A . I S _ A C C E S S _ O V E R R I D D E N   =   ' ' N ' '   '  
              
              
   S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   L O O K U P . C A T E G O R Y   =   ' ' R E C U R R I N G _ S U B S C R I P T I O N ' '   A N D   E S F . F E E   >   0     A N D   M E R C H A N T . A C T I V E   =   ' ' Y ' '   A N D                    
             A A . A C C E S S _ C D   N O T   I N   (  
                                                                 S E L E C T   P A I D A C C E S S   F R O M   V _ G E T U S E R A C C E S S _ P A I D  
                                                                 W H E R E   U S E R N A M E   =   ' ' '   +   @ U S E R N A M E   +   ' ' '  
                                                     ) '  
 I F   ( @ U S E R N A M E   I S   N O T   N U L L   A N D   @ U S E R N A M E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   A U . E M A I L _ I D   =   ' ' '   +     @ U S E R N A M E   +   ' ' ' '  
 I F   ( @ N O D E N A M E   I S   N O T   N U L L   A N D   @ N O D E N A M E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   N O D E . N A M E   =   ' ' '   +     @ N O D E N A M E   +   ' ' ' '  
 S E T   @ S Q L   =   @ S Q L   +   @ C O N D I T I O N    
 E x e c u t e   S P _ E X E C U T E S Q L     @ S Q L  
 E N D  
 G O  
 