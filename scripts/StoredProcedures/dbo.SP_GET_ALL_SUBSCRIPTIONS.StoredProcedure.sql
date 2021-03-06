/ * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ G E T _ A L L _ S U B S C R I P T I O N S ]         S c r i p t   D a t e :   0 8 / 1 4 / 2 0 1 2   1 3 : 5 7 : 0 0   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   P R O C E D U R E     [ d b o ] . [ S P _ G E T _ A L L _ S U B S C R I P T I O N S ]    
 	 @ U S E R N A M E   V A R C H A R ( 5 0 ) ,  
 	 @ R E G I S T E R E D N O D E   V A R C H A R ( 5 0 ) ,  
 	 @ C U R R E N T S I T E   V A R C H A R ( 5 0 )  
 A S    
 B E G I N  
 D E C L A R E   @ S Q L   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 D E C L A R E   @ C O N D I T I O N   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 S E T   @ S Q L   =   ' S E L E C T              
             E S A . S I T E _ I D     A S   E S A _ S I T E _ I D ,  
             ( S E L E C T   S I T E 1 . D E S C R I P T I O N   F R O M   E C O M M _ S I T E   S I T E 1   W H E R E   S I T E 1 . I D   =   E S A . S I T E _ I D )   A S   S I T E 1 _ D E S C R I P T I O N ,                                      
             A A . A C C E S S _ D E S C R   A S   A A _ A C C E S S _ D E S C R ,  
             ( I S N U L L ( E S F . F E E , 0 ) )   A S   E S F _ F e e ,                
             C A S E  
             W H E N   L O O K U P . C A T E G O R Y   =   ' ' R E C U R R I N G _ S U B S C R I P T I O N ' '  
 	 	 T H E N   C A S E   E U A . A C T I V E  
 	 	 	   W H E N     ' ' Y ' '    
 	 	 	 	 T H E N   ' ' N ' '  
 	 	 	   E L S E  
 	 	 	 	 ' ' Y ' '  
 	 	 	   E N D 	  
 	     E L S E   ' ' N ' '  
             E N D                            
               A S   P a y m e n t P e n d i n g ,  
             E U A . L A S T _ B I L L I N G _ D A T E   A S   E U A _ L a s t B i l l i n g D a t e ,  
             E U A . N E X T _ B I L L I N G _ D A T E   A S   E U A _ N e x t B i l l i n g D a t e ,  
             E U A . I D   A S   E U A _ A C C O U N T I D ,  
             A U A . I D   A S   A U A _ U S E R A C C E S S I D ,  
             A A . I D   A S   A A _ A C C E S S I D ,  
             L O O K U P . C A T E G O R Y   A S   L O O K U P _ C A T E G O R Y ,  
             E U A . M A R K _ F O R _ C A N C E L L A T I O N   A S   E U A _ M A R K _ F O R _ C A N C E L L A T I O N ,  
             E U A . P A Y _ P A L _ I D   A S   E U A _ P A Y _ P A L _ I D ,  
             I S N U L L ( E U A . D A T E _ T I M E _ M O D , A U A . D A T E _ T I M E _ M O D )   A S   I S N U L L _ D A T E _ T I M E _ M O D ,  
             I S N U L L ( E U A . D A T E _ T I M E _ C R E A T E D , A U A . D A T E _ T I M E _ C R E A T E D )   A S   I S N U L L _ D A T E _ T I M E _ C R E A T E D ,  
             I S N U L L ( E U A . M O D _ U S E R _ I D , A U A . M O D _ U S E R _ I D )   A S   I S N U L L _ M O D _ U S E R _ I D ,  
             A U A . A C T I V E   A S   A U A _ A C T I V E ,  
             A U A . C O M M E N T S   A S   A U A _ C O M M E N T S ,  
             A U A . I S _ A C C E S S _ O V E R R I D D E N   A S   A U A _ I S _ A C C E S S _ O V E R R I D D E N ,  
             A A . I S _ A U T H O R I Z A T I O N _ R E Q U I R E D   A S   A A _ I S _ A U T H O R I Z A T I O N _ R E Q U I R E D ,  
             A U A . I S _ A U T H O R I Z E D   A S   A U A _ I S _ A U T H O R I Z E D ,  
             I S N U L L ( E U A . C R E A T E D _ B Y , A U A . C R E A T E D _ B Y )   A S   I S N U L L _ C R E A T E D _ B Y                
 F R O M  
 	     A U T H _ U S E R S   A U  
 	     I N N E R   J O I N   A U T H _ U S E R S _ A C C E S S   A U A   O N   A U A . U S E R _ I D   =   A U . I D  
             I N N E R   J O I N   A U T H _ A C C E S S   A A   O N   A U A . A C C E S S _ I D   =   A A . I D  
             L E F T   O U T E R   J O I N   E C O M M _ U S E R S _ A C C O U N T   E U A   O N   E U A . U S E R _ A C C E S S _ I D   =   A U A . I D  
             I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   E S A   O N   E S A . A C C E S S _ I D   =   A A . I D  
             I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   E S A . S I T E _ I D   =   S I T E . I D  
             I N N E R   J O I N   E C O M M _ N O D E   N O D E   O N   N O D E . I D   =   S I T E . N O D E _ I D  
             I N N E R   J O I N   E C O M M _ S U B S C R I P T I O N F E E   E S F   O N   E S F . S I T E A C C E S S _ I D   =   E S A . I D  
             I N N E R   J O I N   C O D E L O O K U P   L O O K U P   O N   L O O K U P . I D   =   E S F . S U B S C R I P T I O N _ T Y P _ I D   W H E R E   ( 1 = 1 ) '  
 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   ' A N D   A A . A C T I V E   =   ' ' Y ' '   A N D   E S A . A C T I V E   =   ' ' Y ' '   A N D   E S F . A C T I V E   =   ' ' Y ' '   A N D   L O O K U P . A C T I V E   =   ' ' Y ' '   '  
 I F   ( @ U S E R N A M E   I S   N O T   N U L L   A N D   @ U S E R N A M E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   A U . E M A I L _ I D   =   ' ' '   +     @ U S E R N A M E   +   ' ' ' '  
 I F   ( @ R E G I S T E R E D N O D E   I S   N O T   N U L L   A N D   @ R E G I S T E R E D N O D E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   N O D E . N A M E   =   ' ' '   +     @ R E G I S T E R E D N O D E   +   ' ' ' '  
 I F   ( @ C U R R E N T S I T E   I S   N O T   N U L L   A N D   @ C U R R E N T S I T E   < >   ' ' )  
 	 S E T   @ C O N D I T I O N   =   @ C O N D I T I O N   +   '   A N D   S I T E . N A M E   =   ' ' '   +     @ C U R R E N T S I T E   +   ' ' ' '  
 S E T   @ S Q L   =   @ S Q L   +   @ C O N D I T I O N    
 E x e c u t e   S P _ E X E C U T E S Q L     @ S Q L  
 - - p r i n t   @ s q l  
 E N D  
 G O  
 