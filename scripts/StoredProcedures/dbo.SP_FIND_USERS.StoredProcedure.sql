/ * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ F I N D _ U S E R S ]         S c r i p t   D a t e :   0 8 / 1 4 / 2 0 1 2   1 3 : 5 7 : 0 0   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   P R O C E D U R E     [ d b o ] . [ S P _ F I N D _ U S E R S ]    
 	 @ F I R S T N A M E   V A R C H A R ( 5 0 ) ,   @ L A S T N A M E   V A R C H A R ( 5 0 ) ,   @ U S E R N A M E   V A R C H A R ( 5 0 ) ,   @ S I T E I D   I N T 	  
 A S  
 S e t   N o C o u n t   O N  
 S E L E C T   @ F I R S T N A M E   =   ' ' ' ' +   ' % '   +   R T R I M ( L T R I M ( @ F I R S T N A M E ) )   +   ' % '   +   ' ' ' ' ;  
 S E L E C T   @ L A S T N A M E   =     ' ' ' ' +   ' % '   +   R T R I M ( L T R I M ( @ L A S T N A M E ) )   +   ' % '   +   ' ' ' ' ;  
 S E L E C T   @ U S E R N A M E   =   ' ' ' ' +   R T R I M ( L T R I M ( @ U S E R N A M E ) )   +   ' ' ' ' ;  
 D E C L A R E   @ S Q L   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
 D E C L A R E   @ F I E L D S   N V A R C H A R ( 4 0 0 0 ) =   ' ' ;  
 D E C L A R E   @ J O I N S   N V A R C H A R ( 4 0 0 0 ) =   ' ' ;  
 D E C L A R E   @ C O N D I T I O N S   N V A R C H A R ( 4 0 0 0 )   =   ' ' ;  
  
 S E T   @ S Q L   =   '   D I S T I N C T   U S E R S . I D   A S   U S E R S _ I D  
   , U S E R S . E M A I L _ I D   A S   U S E R S _ E M A I L _ I D    
   , U S E R S . F I R S T _ N A M E   A S   U S E R S _ F I R S T _ N A M E  
   , U S E R S . L A S T _ N A M E   A S   U S E R S _ L A S T _ N A M E    
   , U S E R S . A C T I V E   A S   U S E R S _ A C T I V E  
   , U S E R S . A C C O U N T _ N O N L O C K E D   A S   U S E R S _ A C C O U N T _ N O N L O C K E D  
   , I S C A R D A V A I L A B L E   =    
 	 C A S E   W H E N   C C . A C C O U N T N U M B E R   I S   N O T   N U L L   T H E N   ' ' Y ' '  
 	 	 E L S E   ' ' N ' '  
 	 E N D  
   , I S C A R D A C T I V E   =   C C . A C T I V E 	    
   , C C . A C C O U N T N U M B E R   A S   C C _ A C C O U N T N U M B E R    
   , ' ' Y ' '   A S   F I E L D 1  
   , ' ' Y ' '   A S   F I E L D 2  
   , U S E R S . L A S T _ L O G I N _ T I M E   A S   U S E R S _ L A S T _ L O G I N _ T I M E  
   , U S E R S . D A T E _ T I M E _ C R E A T E D   A S   U S E R S _ D A T E _ T I M E _ C R E A T E D  
   , U S E R S . R E G I S T E R E D _ N O D E   A S   U S E R S _ R E G I S T E R E D _ N O D E  
 F R O M  
             A U T H _ U S E R S   U S E R S  
             L E F T   O U T E R   J O I N   E C O M M _ C C I N F O   C C   O N   U S E R S . I D   =   C C . U S E R _ I D  
             I N N E R   J O I N   A U T H _ U S E R S _ A C C E S S   U S E R A C C E S S   O N   U S E R A C C E S S . U S E R _ I D   =   U S E R S . I D  
             I N N E R   J O I N   A U T H _ A C C E S S   A C C E S S   O N   A C C E S S . I D   =   U S E R A C C E S S . A C C E S S _ I D   '  
 I F   @ F I R S T N A M E   I S   N O T   N U L L    
 	 S E T   @ C O N D I T I O N S   =   @ C O N D I T I O N S   +   '   A N D   U S E R S . F I R S T _ N A M E   L I K E   '   +   @ F I R S T N A M E    
 I F   @ L A S T N A M E   I S   N O T   N U L L  
 B E G I N  
 	 S E T   @ C O N D I T I O N S   =   @ C O N D I T I O N S   +   '   A N D   U S E R S . L A S T _ N A M E   L I K E   '   +   @ L A S T N A M E  
 E N D 	 	  
 I F   @ U S E R N A M E   I S   N O T   N U L L  
 B E G I N  
 	 S E T   @ C O N D I T I O N S   =   @ C O N D I T I O N S   +   '   A N D   U S E R S . E M A I L _ I D   =   '   +   @ U S E R N A M E  
 E N D  
 I F   @ S I T E I D   I S   N O T   N U L L  
 B E G I N 	  
 	 S E T   @ C O N D I T I O N S   =   @ C O N D I T I O N S   +   '   A N D   S I T E . I D   = '   +   C O N V E R T ( v a r c h a r ,   @ S I T E I D )    
 	 S E T   @ J O I N S   =   '   I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   S I T E A C C E S S   O N   S I T E A C C E S S . A C C E S S _ I D   =   A C C E S S . I D  
             I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   S I T E A C C E S S . S I T E _ I D   '  
 E N D  
 S E T   @ S Q L   =   ' S E L E C T   '   +   @ S Q L   +   @ J O I N S   +   '   w h e r e   ( 1 = 1 )   A N D   A C C E S S . A C C E S S _ O R D E R   I S   N O T   N U L L   '   +   @ C O N D I T I O N S   +   ' O R D E R   B Y   U S E R S . D A T E _ T I M E _ C R E A T E D   D E S C '  
 E x e c u t e   S P _ E X E C U T E S Q L     @ S Q L  
 G O  
 