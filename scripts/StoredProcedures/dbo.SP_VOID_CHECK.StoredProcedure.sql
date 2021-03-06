/ * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ V O I D _ C H E C K ]         S c r i p t   D a t e :   0 8 / 1 4 / 2 0 1 2   1 3 : 5 7 : 0 3   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   P R O C E D U R E     [ d b o ] . [ S P _ V O I D _ C H E C K ]   ( @ C H E C K N U M   I N T ,   @ C O M M E N T S   V A R C H A R ( 2 5 0 ) )  
 A S  
 B E G I N  
 D E C L A R E    
 	 @ S I T E I D   I N T ,  
 	 @ P A Y M E N T T Y P E   V A R C H A R ( 2 0 ) ,  
 	 @ I S V O I D E D   C H A R ( 1 )  
 	  
 	 S E L E C T   T O P   1   @ S I T E I D   =   S I T E _ I D ,   @ P A Y M E N T T Y P E   =   P A Y M E N T _ T Y P E ,   @ I S V O I D E D   =   I S _ V O I D E D   F R O M   E C O M M _ C H E C K _ H I S T   W H E R E     C H E C K N U M   =   @ C H E C K N U M  
  
 	 I F   ( @ P A Y M E N T T Y P E   =   ' R E C U R R I N G '   A N D   @ I S V O I D E D   =   ' N ' )  
 	 B E G I N  
 	 	 U P D A T E   E C O M M _ C H E C K _ H I S T   S E T   I S _ V O I D E D   =   ' Y ' ,   C O M M E N T S   =   C O M M E N T S   +   '   |   '   +   @ C O M M E N T S   W H E R E   S I T E _ I D   =   @ S I T E I D   A N D   C H E C K N U M   =   @ C H E C K N U M  
 	 	 U P D A T E   T R A N S   S E T   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D ' ,   C H E C K N U M   =   N U L L   F R O M   E C O M M _ R E C U R _ T X _ H I S T _ I N F O   T R A N S    
 	 	 	 I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   S I T E A C C E S S   O N   S I T E A C C E S S . A C C E S S _ I D   =   T R A N S . A C C E S S _ I D  
 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   S I T E A C C E S S . S I T E _ I D  
 	 	 	 I N N E R   J O I N   A U T H _ A C C E S S   A C C E S S   O N   A C C E S S . I D   =   S I T E A C C E S S . A C C E S S _ I D  
 	 	 	 W H E R E   C H E C K N U M   =   @ C H E C K N U M   A N D   S I T E . I D   =   @ S I T E I D 	 	 	  
 	 	 S E L E C T   ' Y '   A S   S T A T U S 	  
 	 E N D  
 	 E L S E   I F   ( @ P A Y M E N T T Y P E   =   ' W E B '   A N D   @ I S V O I D E D   =   ' N ' )  
 	 B E G I N  
 	 	 U P D A T E   E C O M M _ C H E C K _ H I S T   S E T   I S _ V O I D E D   =   ' Y ' ,   C O M M E N T S   =   C O M M E N T S   +   '   |   '   +   @ C O M M E N T S   W H E R E   S I T E _ I D   =   @ S I T E I D   A N D   C H E C K N U M   =   @ C H E C K N U M  
 	 	 U P D A T E   T R A N S   S E T   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D ' ,   C H E C K N U M   =   N U L L   F R O M   E C O M M _ W E B P A Y _ T X   T R A N S    
 	 	 	 I N N E R   J O I N   E C O M M _ M E R C H A N T I N F O   M E R C H A N T   O N   M E R C H A N T . I D   =   T R A N S . M E R C H A N T _ I D  
 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T R A N S . S I T E _ I D  
 	 	 	 W H E R E   C H E C K N U M   =   @ C H E C K N U M   A N D   S I T E . I D   =   @ S I T E I D  
 	 	 S E L E C T   ' Y '   A S   S T A T U S  
 	 E N D  
 	 E L S E   I F   ( @ P A Y M E N T T Y P E   =   ' O T C '   A N D   @ I S V O I D E D   =   ' N ' )  
 	 B E G I N  
 	 	 U P D A T E   E C O M M _ C H E C K _ H I S T   S E T   I S _ V O I D E D   =   ' Y ' ,   C O M M E N T S   =   C O M M E N T S   +   '   |   '   +   @ C O M M E N T S   W H E R E   S I T E _ I D   =   @ S I T E I D   A N D   C H E C K N U M   =   @ C H E C K N U M  
 	 	 U P D A T E   T R A N S   S E T   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D ' ,   C H E C K N U M   =   N U L L   F R O M   E C O M M _ O T C _ T X   T R A N S    
 	 	 	 W H E R E   C H E C K N U M   =   @ C H E C K N U M   A N D   S I T E _ I D   =   @ S I T E I D  
 	 	 S E L E C T   ' Y '   A S   S T A T U S  
 	 E N D  
 	 E L S E  
 	 	 S E L E C T   ' N '   A S   S T A T U S  
 E N D  
 G O  
 