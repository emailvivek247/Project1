/ * * * * * *   O b j e c t :     S t o r e d P r o c e d u r e   [ d b o ] . [ S P _ G E T C H E C K D E T A I L S _ R P T ]         S c r i p t   D a t e :   0 8 / 1 4 / 2 0 1 2   1 3 : 5 7 : 0 2   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   P R O C E D U R E   [ d b o ] . [ S P _ G E T C H E C K D E T A I L S _ R P T ]   ( @ S I T E _ I D   I N T ,   @ F R O M _ D A T E   V A R C H A R ( 2 0 ) ,   @ T O _ D A T E   V A R C H A R ( 2 0 ) ,   @ P A Y M E N T _ T Y P E   V A R C H A R ( 2 0 ) ,   @ M O D _ U S E R _ I D   V A R C H A R ( 5 0 ) ,   @ M A C H I N E N A M E   V A R C H A R ( 5 0 ) )  
 A S  
 B E G I N  
 S E T   N O C O U N T   O N  
 	 D E C L A R E    
 	 @ T O T A L C H A R G E A M T   f l o a t ,  
 	 @ T O T A L R E F U N D A M T   f l o a t ,  
 	 @ T X _ A M O U N T P A Y A B L E   f l o a t ,  
 	 @ C H A R G E T R A N S   I N T ,    
 	 @ R E F U N D T R A N S   I N T ,  
 	 @ T O T A L T R A N S A C T I O N S   I N T ,  
 	 @ N E W C H E C K N U M   I N T ,  
 	 @ B A N K _ I D   I N T ,  
 	 @ M E S S A G E   V A R C H A R ( 2 0 0 0 ) ,  
 	 @ V A L I D T I M E S T A M P   D A T E T I M E ,  
 	 @ C H E C K H O L D P E R I O D   I N T  
 	  
 	 D E C L A R E   @ C H E C K S _ A V A I L A B L E   A S   C H A R ( 1 )   =   ' N '  
 	  
 	 S E T   @ M E S S A G E   =   ' '  
 	 S E T   @ C H E C K H O L D P E R I O D   =   ( S E L E C T   T O P   1   C H E C K _ H O L D _ P E R I O D   F R O M   E C O M M _ S I T E   W H E R E   I D   =   @ S I T E _ I D )  
 	 S E T   @ V A L I D T I M E S T A M P   =   D A T E A D D ( H H ,   0   -   @ C H E C K H O L D P E R I O D ,   G E T D A T E ( ) )  
 	  
 	 S E T   @ C H E C K S _ A V A I L A B L E   =   ( I S N U L L ( ( S E L E C T   ' Y '   F R O M   E C O M M _ B A N K _ D E T A I L S   W H E R E   S I T E _ I D   =   @ S I T E _ I D   A N D   L A S T _ I S S U E D _ C H E C K _ N U M   <   E N D _ C H E C K _ N U M ) ,   ' N ' ) )  
 	 I F   ( @ C H E C K S _ A V A I L A B L E   =   ' N ' )    
 	 B E G I N  
 	 	 S E T   @ M E S S A G E   =   ' T h e   c h e c k   s e q u e n c e   a s s i g n e d   t o   y o u   r e a c h e d   i t s   l i m i t .   P l e a s e   c o n t a c t   t h e   a d m i n i s t r a t o r   t o   r e s e t   y o u r   c h e c k   s e q u e n c e .   Y o u   m a y   s t a r t   g e n e r a t i n g   t h e   c h e c k s   o n c e   t h e   r e s e t   i t   d o n e . '  
 	 E N D  
 	 I F   ( @ P A Y M E N T _ T Y P E   =   ' R E C U R R I N G ' )  
 	 B E G I N  
 	 	 S E T   @ T O T A L R E F U N D A M T   =   i s n u l l ( ( S E L E C T   S U M ( C A S T (   ( ( T R A N S . T X _ A M O U N T   +     ( ( ( T R A N S . T X _ A M O U N T   *   T R A N S . T R A N _ F E E _ P E R C E N T A G E )   / 1 0 0 )   +   T R A N S . T R A N _ F E E _ F L A T ) )   *   T R A N S . C L I E N T _ S H A R E )   A S   D E C ( 1 0 , 2 ) ) )   F R O M   E C O M M _ R E C U R _ T X _ H I S T _ I N F O   T R A N S  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   A U T H _ A C C E S S   A C C E S S   O N   A C C E S S . I D   =   T R A N S . A C C E S S _ I D  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   S I T E A C C E S S   O N   S I T E A C C E S S . A C C E S S _ I D   =   A C C E S S . I D  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   S I T E A C C E S S . S I T E _ I D  
 	 	 	 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D 	  
 	 	 	 	 	 	 	 	 	 A N D   T R A N S . T X _ T Y P E   I N   ( ' R E F U N D ' )   A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '    
 	 	 	 	 	 	 	 	 	 A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P ) , 0 )  
 	 	 S E T   @ R E F U N D T R A N S   =   i s n u l l ( ( S E L E C T   C O U N T ( * )   F R O M   E C O M M _ R E C U R _ T X _ H I S T _ I N F O   T R A N S  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   A U T H _ A C C E S S   A C C E S S   O N   A C C E S S . I D   =   T R A N S . A C C E S S _ I D  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   S I T E A C C E S S   O N   S I T E A C C E S S . A C C E S S _ I D   =   A C C E S S . I D  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   S I T E A C C E S S . S I T E _ I D  
 	 	 	 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D  
 	 	 	 	 	 	 	 	 	 A N D   T X _ T Y P E   I N   ( ' R E F U N D ' ) A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P ) , 0 )  
 	 	 S E T   @ T O T A L C H A R G E A M T   =   i s n u l l ( ( S E L E C T   S U M ( C A S T (   ( ( T R A N S . T X _ A M O U N T   -     ( ( ( T R A N S . T X _ A M O U N T   *   T R A N S . T R A N _ F E E _ P E R C E N T A G E )   / 1 0 0 )   +   T R A N S . T R A N _ F E E _ F L A T ) )   *   T R A N S . C L I E N T _ S H A R E )   A S   D E C ( 1 0 , 2 ) ) )   F R O M   E C O M M _ R E C U R _ T X _ H I S T _ I N F O   T R A N S  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   A U T H _ A C C E S S   A C C E S S   O N   A C C E S S . I D   =   T R A N S . A C C E S S _ I D  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   S I T E A C C E S S   O N   S I T E A C C E S S . A C C E S S _ I D   =   A C C E S S . I D  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   S I T E A C C E S S . S I T E _ I D  
 	 	 	 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D  
 	 	 	 	 	 	 	 	 	 A N D   T X _ T Y P E   I N   ( ' C H A R G E ' )   A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P ) , 0 )  
 	 	 S E T   @ C H A R G E T R A N S   =   i s n u l l ( ( S E L E C T   C O U N T ( * )   F R O M   E C O M M _ R E C U R _ T X _ H I S T _ I N F O   T R A N S  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   A U T H _ A C C E S S   A C C E S S   O N   A C C E S S . I D   =   T R A N S . A C C E S S _ I D  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   S I T E A C C E S S   O N   S I T E A C C E S S . A C C E S S _ I D   =   A C C E S S . I D  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   S I T E A C C E S S . S I T E _ I D  
 	 	 	 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D  
 	 	 	 	 	 	 	 	 	 A N D   T X _ T Y P E   =   ' C H A R G E '   A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P ) , 0 )  
  
 	 	 S E T   @ T X _ A M O U N T P A Y A B L E   =   @ T O T A L C H A R G E A M T   -   @ T O T A L R E F U N D A M T  
 	 	 S E T   @ T O T A L T R A N S A C T I O N S   =   @ C H A R G E T R A N S   +   @ R E F U N D T R A N S 	  
 	 	  
 	 	 I F   ( @ T X _ A M O U N T P A Y A B L E   >   0   A N D   @ C H E C K S _ A V A I L A B L E   =   ' Y ' )  
 	 	 B E G I N  
 	 	 	 U P D A T E   E C O M M _ B A N K _ D E T A I L S   S E T   L A S T _ I S S U E D _ C H E C K _ N U M   =   L A S T _ I S S U E D _ C H E C K _ N U M   +   1 ,   D A T E _ T I M E _ M O D   =   G E T D A T E ( ) ,   M O D _ U S E R _ I D   =   @ M O D _ U S E R _ I D   W H E R E   S I T E _ I D   =   @ S I T E _ I D  
 	 	 	 S E T   @ N E W C H E C K N U M   =   ( S E L E C T   T O P   1   L A S T _ I S S U E D _ C H E C K _ N U M   F R O M   E C O M M _ B A N K _ D E T A I L S   W H E R E   S I T E _ I D   =   @ S I T E _ I D )  
 	 	 	 S E T   @ B A N K _ I D   =   ( S E L E C T   T O P   1   I D   F R O M   E C O M M _ B A N K _ D E T A I L S   W H E R E   S I T E _ I D   =   @ S I T E _ I D )  
 	 	 	 U P D A T E   T R A N S   S E T   T R A N S . S E T T L E M E N T _ S T A T U S   =   ' S E T T L E D ' ,   T R A N S . C H E C K N U M   =   @ N E W C H E C K N U M ,   D A T E _ T I M E _ M O D   =   G E T D A T E ( ) ,   M O D _ U S E R _ I D   =   @ M O D _ U S E R _ I D     F R O M   E C O M M _ R E C U R _ T X _ H I S T _ I N F O   T R A N S  
 	 	 	 	 	 	 I N N E R   J O I N   A U T H _ A C C E S S   A C C E S S   O N   A C C E S S . I D   =   T R A N S . A C C E S S _ I D  
 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E _ A C C E S S   S I T E A C C E S S   O N   S I T E A C C E S S . A C C E S S _ I D   =   A C C E S S . I D  
 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   S I T E A C C E S S . S I T E _ I D  
 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D   A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '    
 	 	 	 	 	 	 A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E     A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P  
 	 	 	 I N S E R T   I N T O   E C O M M _ C H E C K _ H I S T   ( S I T E _ I D ,   C H E C K N U M ,   P A Y M E N T _ T Y P E ,   T O T A L _ T R A N S A C T I O N S ,   A M O U N T ,   B A N K _ I D ,   I S _ V O I D E D ,   D A T E _ T I M E _ M O D ,   D A T E _ T I M E _ C R E A T E D ,   M O D _ U S E R _ I D ,   M A C H I N E N A M E ,   A C T I V E ,   C O M M E N T S ,   C R E A T E D _ B Y )  
 	 	 	 	 	 V A L U E S   ( @ S I T E _ I D ,   @ N E W C H E C K N U M ,   @ P A Y M E N T _ T Y P E ,   @ T O T A L T R A N S A C T I O N S ,   @ T X _ A M O U N T P A Y A B L E ,   @ B A N K _ I D ,   ' N ' ,   G E T D A T E ( ) ,   G E T D A T E ( ) ,   @ M O D _ U S E R _ I D ,   @ M A C H I N E N A M E ,   ' Y ' ,   ' F R O M :   '   +   @ F R O M _ D A T E   +   '   T O :   '   +   @ T O _ D A T E ,   @ M O D _ U S E R _ I D ) 	 	 	  
 	 	 E N D 	 	  
 	 	 I F   ( @ T X _ A M O U N T P A Y A B L E   < =   0   A N D   @ C H E C K S _ A V A I L A B L E   =   ' Y ' )  
 	 	 B E G I N  
 	 	 	 S E T   @ M E S S A G E   =   ' C h e c k   i s   n o t   a v a i l a b l e   i f   a m o u n t   p a y a b l e   i s   z e r o   o r   n e g a t i v e .   N e g a t i v e   A m o u n t   i n d i c a t e s   m o r e   r e f u n d s   a r e   p r o c e s s e d   t h a n   c h a r g e d   d u r i n g   t h e   s e l e c t e d   t i m e   p e r i o d .   P l e a s e   s e l e c t   a   l a r g e r   t i m e   p e r i o d   a n d   t r y   a g a i n . ' 	  
 	 	 E N D  
 	 	 S E L E C T     D I S T I N C T    
 	 	 E B . I D   A S   A C C O U N T I D ,  
 	 	 E B . S I T E _ I D ,    
 	 	 S I T E . N A M E   A S   S I T E _ N A M E ,  
 	 	 ( E B . F R O M _ F N A M E   +   '   '   +   E B . F R O M _ M I N I T I A L   +   '   '   +   E B . F R O M _ L N A M E )   A S   F R O M N A M E ,  
 	 	 E B . F R O M _ A D D R L I N E 1   A S   F R O M A D D R E S S L 1 ,  
 	 	 E B . F R O M _ A D D R L I N E 2   A S   F R O M A D D R E S S L 2 ,  
 	 	 E B . F R O M _ C I T Y   A S   F R O M C I T Y ,  
 	 	 E B . F R O M _ S T A T E   A S   F R O M S T A T E ,  
 	 	 E B . F R O M _ Z I P C O D E   A S   F R O M Z I P C O D E ,  
 	 	 E B . F R O M _ P H O N E N U M ,    
 	 	 E B . B A N K _ N A M E   A S   B A N K N A M E ,  
 	 	 E B . B A N K _ A D D R L I N E 1   A S   B A N K A D D R E S S L 1 ,  
 	 	 E B . B A N K _ A D D R L I N E 2   A S   B A N K A D D R E S S L 2 ,  
 	 	 E B . B A N K _ C I T Y   A S   B A N K C I T Y ,  
 	 	 E B . B A N K _ S T A T E   A S   B A N K S T A T E ,  
 	 	 E B . B A N K _ Z I P C O D E   A S   B A N K Z I P C O D E , 	  
 	 	 S I T E . N A M E _ O N _ C H E C K   A S   O R D E R O F ,  
 	 	 E B . B A N K _ C O D E   A S   B A N K C O D E ,    
 	 	 E B . R O U T I N G _ N U M   A S   R O U T I N G N U M ,  
 	 	 E B . A C C O U N T _ N U M   A S   A C C O U N T N U M ,  
 	 	 C A S E    
 	 	 	 W H E N   @ T X _ A M O U N T P A Y A B L E   >   0   T H E N  
 	 	 	 	 E B . L A S T _ I S S U E D _ C H E C K _ N U M    
 	 	 	 E L S E  
 	 	 	 	 0  
 	 	 E N D 	 A S   C H E C K N U M ,  
 	 	 @ T O T A L T R A N S A C T I O N S   A S   T O T A L T R A N S A C T I O N S ,  
 	 	 C A S T ( @ T X _ A M O U N T P A Y A B L E   A S   D E C ( 1 0 , 2 ) ) A S   T X _ A M O U N T P A Y A B L E ,  
 	 	 D B O . F _ N U M B E R T O T E X T ( @ T X _ A M O U N T P A Y A B L E )   A S   T E X T T X _ A M O U N T ,  
 	 	 @ M E S S A G E   A S   M E S S A G E ,  
 	 	 @ V A L I D T I M E S T A M P   A S   V A L I D T I M E S T A M P  
 	 	 F R O M   E C O M M _ B A N K _ D E T A I L S   E B    
 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   E B . S I T E _ I D  
 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D   A N D   E B . A C T I V E   =   ' Y '  
 	 E N D  
 	 E L S E   I F   ( @ P A Y M E N T _ T Y P E   =   ' W E B ' )  
 	 B E G I N  
 	 	 S E T   @ T O T A L R E F U N D A M T   =   i s n u l l ( ( S E L E C T   S U M ( A M O U N T )   F R O M   E C O M M _ W E B P A Y _ T X   T R A N S  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ M E R C H A N T I N F O   M E R C H A N T   O N   M E R C H A N T . I D   =   T R A N S . M E R C H A N T _ I D  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T R A N S . S I T E _ I D  
 	 	 	 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D 	  
 	 	 	 	 	 	 	 	 	 A N D   T X _ T Y P E   I N   ( ' R E F U N D ' )   A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '    
 	 	 	 	 	 	 	 	 	 A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P ) , 0 )  
 	 	 S E T   @ R E F U N D T R A N S   =   i s n u l l ( ( S E L E C T   C O U N T ( * )   F R O M   E C O M M _ W E B P A Y _ T X   T R A N S  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ M E R C H A N T I N F O   M E R C H A N T   O N   M E R C H A N T . I D   =   T R A N S . M E R C H A N T _ I D  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T R A N S . S I T E _ I D  
 	 	 	 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D  
 	 	 	 	 	 	 	 	 	 A N D   T X _ T Y P E   I N   ( ' R E F U N D ' ) A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P ) , 0 )  
 	 	 S E T   @ T O T A L C H A R G E A M T   =   i s n u l l ( ( S E L E C T   S U M ( T X _ A M O U N T )   F R O M   E C O M M _ W E B P A Y _ T X   T R A N S  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ M E R C H A N T I N F O   M E R C H A N T   O N   M E R C H A N T . I D   =   T R A N S . M E R C H A N T _ I D  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T R A N S . S I T E _ I D  
 	 	 	 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D  
 	 	 	 	 	 	 	 	 	 A N D   T X _ T Y P E   I N   ( ' C H A R G E ' )   A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P ) ,   0 . 0 0 )  
 	 	 S E T   @ C H A R G E T R A N S   =   i s n u l l ( ( S E L E C T   C O U N T ( * )   F R O M   E C O M M _ W E B P A Y _ T X   T R A N S  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ M E R C H A N T I N F O   M E R C H A N T   O N   M E R C H A N T . I D   =   T R A N S . M E R C H A N T _ I D  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T R A N S . S I T E _ I D  
 	 	 	 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D  
 	 	 	 	 	 	 	 	 	 A N D   T X _ T Y P E   =   ' C H A R G E '   A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P ) , 0 )  
 	 	  
 	 	 S E T   @ T X _ A M O U N T P A Y A B L E   =   @ T O T A L C H A R G E A M T   -   @ T O T A L R E F U N D A M T  
 	 	 S E T   @ T O T A L T R A N S A C T I O N S   =   @ C H A R G E T R A N S   +   @ R E F U N D T R A N S  
 	 	 I F   ( @ T X _ A M O U N T P A Y A B L E   >   0   A N D   @ C H E C K S _ A V A I L A B L E   =   ' Y ' )  
 	 	 B E G I N  
 	 	 	 U P D A T E   E C O M M _ B A N K _ D E T A I L S   S E T   L A S T _ I S S U E D _ C H E C K _ N U M   =   L A S T _ I S S U E D _ C H E C K _ N U M   +   1 ,   D A T E _ T I M E _ M O D   =   G E T D A T E ( ) ,   M O D _ U S E R _ I D   =   @ M O D _ U S E R _ I D   W H E R E   S I T E _ I D   =   @ S I T E _ I D  
 	 	 	 S E T   @ N E W C H E C K N U M   =   ( S E L E C T   T O P   1   L A S T _ I S S U E D _ C H E C K _ N U M   F R O M   E C O M M _ B A N K _ D E T A I L S   W H E R E   S I T E _ I D   =   @ S I T E _ I D )  
 	 	 	 S E T   @ B A N K _ I D   =   ( S E L E C T   T O P   1   I D   F R O M   E C O M M _ B A N K _ D E T A I L S   W H E R E   S I T E _ I D   =   @ S I T E _ I D )  
 	 	 	 U P D A T E   T R A N S   S E T   T R A N S . S E T T L E M E N T _ S T A T U S   =   ' S E T T L E D ' ,   T R A N S . C H E C K N U M   =   @ N E W C H E C K N U M ,   D A T E _ T I M E _ M O D   =   G E T D A T E ( ) ,   M O D _ U S E R _ I D   =   @ M O D _ U S E R _ I D   F R O M   E C O M M _ W E B P A Y _ T X   T R A N S  
 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ M E R C H A N T I N F O   M E R C H A N T   O N   M E R C H A N T . I D   =   T R A N S . M E R C H A N T _ I D  
 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T R A N S . S I T E _ I D  
 	 	 	 	 	   W H E R E   T R A N S . S I T E _ I D   =   @ S I T E _ I D   A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '    
 	 	 	 	 	 	 	 	 	 A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P  
 	 	 	 I N S E R T   I N T O   E C O M M _ C H E C K _ H I S T   ( S I T E _ I D ,   C H E C K N U M ,   P A Y M E N T _ T Y P E ,   T O T A L _ T R A N S A C T I O N S ,   A M O U N T ,   B A N K _ I D ,   I S _ V O I D E D ,   D A T E _ T I M E _ M O D ,   D A T E _ T I M E _ C R E A T E D ,   M O D _ U S E R _ I D ,   M A C H I N E N A M E ,   A C T I V E ,   C O M M E N T S ,   C R E A T E D _ B Y )  
 	 	 	 	 	 V A L U E S   ( @ S I T E _ I D ,   @ N E W C H E C K N U M ,   @ P A Y M E N T _ T Y P E ,   @ T O T A L T R A N S A C T I O N S ,   @ T X _ A M O U N T P A Y A B L E ,   @ B A N K _ I D ,   ' N ' ,   G E T D A T E ( ) ,   G E T D A T E ( ) ,   @ M O D _ U S E R _ I D ,   @ M A C H I N E N A M E ,   ' Y ' ,   ' F R O M :   '   +   @ F R O M _ D A T E   +   '   T O :   '   +   @ T O _ D A T E ,   @ M O D _ U S E R _ I D ) 	 	 	  
 	 	 E N D 	  
 	 	 I F   ( @ T X _ A M O U N T P A Y A B L E   < =   0   A N D   @ C H E C K S _ A V A I L A B L E   =   ' Y ' )  
 	 	 B E G I N  
 	 	 	 S E T   @ M E S S A G E   =   ' C h e c k   i s   n o t   a v a i l a b l e   i f   a m o u n t   p a y a b l e   i s   z e r o   o r   n e g a t i v e .   N e g a t i v e   A m o u n t   i n d i c a t e s   m o r e   r e f u n d s   a r e   p r o c e s s e d   t h a n   c h a r g e d   d u r i n g   t h e   s e l e c t e d   t i m e   p e r i o d .   P l e a s e   s e l e c t   a   l a r g e r   t i m e   p e r i o d   a n d   t r y   a g a i n . ' 	  
 	 	 E N D  
 	 	 S E L E C T     D I S T I N C T    
 	 	 E B . I D   A S   A C C O U N T I D ,    
 	 	 E B . S I T E _ I D ,    
 	 	 S I T E . N A M E   A S   S I T E _ N A M E ,  
 	 	 ( E B . F R O M _ F N A M E   +   '   '   +   E B . F R O M _ M I N I T I A L   +   '   '   +   E B . F R O M _ L N A M E )   A S   F R O M N A M E ,  
 	 	 E B . F R O M _ A D D R L I N E 1   A S   F R O M A D D R E S S L 1 ,  
 	 	 E B . F R O M _ A D D R L I N E 2   A S   F R O M A D D R E S S L 2 ,  
 	 	 E B . F R O M _ C I T Y   A S   F R O M C I T Y ,  
 	 	 E B . F R O M _ S T A T E   A S   F R O M S T A T E ,  
 	 	 E B . F R O M _ Z I P C O D E   A S   F R O M Z I P C O D E ,  
 	 	 E B . F R O M _ P H O N E N U M ,    
 	 	 E B . B A N K _ N A M E   A S   B A N K N A M E ,  
 	 	 E B . B A N K _ A D D R L I N E 1   A S   B A N K A D D R E S S L 1 ,  
 	 	 E B . B A N K _ A D D R L I N E 2   A S   B A N K A D D R E S S L 2 ,  
 	 	 E B . B A N K _ C I T Y   A S   B A N K C I T Y ,  
 	 	 E B . B A N K _ S T A T E   A S   B A N K S T A T E ,  
 	 	 E B . B A N K _ Z I P C O D E   A S   B A N K Z I P C O D E , 	  
 	 	 S I T E . N A M E _ O N _ C H E C K   A S   O R D E R O F ,  
 	 	 E B . B A N K _ C O D E   A S   B A N K C O D E ,    
 	 	 E B . R O U T I N G _ N U M   A S   R O U T I N G N U M ,  
 	 	 E B . A C C O U N T _ N U M   A S   A C C O U N T N U M ,  
 	 	 C A S E    
 	 	 	 W H E N   @ T X _ A M O U N T P A Y A B L E   >   0   T H E N  
 	 	 	 	 E B . L A S T _ I S S U E D _ C H E C K _ N U M    
 	 	 	 E L S E  
 	 	 	 	 0  
 	 	 E N D 	 A S   C H E C K N U M ,  
 	 	 @ T O T A L T R A N S A C T I O N S   A S   T O T A L T R A N S A C T I O N S ,  
 	 	 C A S T ( @ T X _ A M O U N T P A Y A B L E   A S   D E C ( 1 0 , 2 ) ) A S   T X _ A M O U N T P A Y A B L E ,  
 	 	 D B O . F _ N U M B E R T O T E X T ( @ T X _ A M O U N T P A Y A B L E )   A S   T E X T T X _ A M O U N T ,  
 	 	 @ M E S S A G E   A S   M E S S A G E ,  
 	 	 @ V A L I D T I M E S T A M P   A S   V A L I D T I M E S T A M P  
 	 	 F R O M   E C O M M _ B A N K _ D E T A I L S   E B    
 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   E B . S I T E _ I D  
 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D   A N D   E B . A C T I V E   =   ' Y ' 	  
 	 E N D  
 	 E L S E   I F   ( @ P A Y M E N T _ T Y P E   =   ' O T C ' )  
 	 B E G I N  
 	 	 S E T   @ T O T A L R E F U N D A M T   =   i s n u l l ( ( S E L E C T   S U M ( A M O U N T )   F R O M   E C O M M _ O T C _ T X   T R A N S  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T R A N S . S I T E _ I D  
 	 	 	 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D 	  
 	 	 	 	 	 	 	 	 	 A N D   T X _ T Y P E   I N   ( ' R E F U N D ' )   A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '    
 	 	 	 	 	 	 	 	 	 A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P ) , 0 )  
 	 	 S E T   @ R E F U N D T R A N S   =   i s n u l l ( ( S E L E C T   C O U N T ( * )   F R O M   E C O M M _ O T C _ T X   T R A N S  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T R A N S . S I T E _ I D  
 	 	 	 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D  
 	 	 	 	 	 	 	 	 	 A N D   T X _ T Y P E   I N   ( ' R E F U N D ' ) A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P ) , 0 )  
 	 	 S E T   @ T O T A L C H A R G E A M T   =   i s n u l l ( ( S E L E C T   S U M ( A M O U N T )   F R O M   E C O M M _ O T C _ T X   T R A N S  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T R A N S . S I T E _ I D  
 	 	 	 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D  
 	 	 	 	 	 	 	 	 	 A N D   T X _ T Y P E   I N   ( ' C H A R G E ' )   A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P ) , 0 )  
 	 	 S E T   @ C H A R G E T R A N S   =   i s n u l l ( ( S E L E C T   C O U N T ( * )   F R O M   E C O M M _ O T C _ T X   T R A N S  
 	 	 	 	 	 	 	 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   T R A N S . S I T E _ I D  
 	 	 	 	 	 	 	 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D  
 	 	 	 	 	 	 	 	 	 A N D   T X _ T Y P E   =   ' C H A R G E '   A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P ) , 0 )  
 	 	  
 	 	 S E T   @ T X _ A M O U N T P A Y A B L E   =   @ T O T A L C H A R G E A M T   -   @ T O T A L R E F U N D A M T  
 	 	 S E T   @ T O T A L T R A N S A C T I O N S   =   @ C H A R G E T R A N S   +   @ R E F U N D T R A N S  
 	 	 I F   ( @ T X _ A M O U N T P A Y A B L E   >   0   A N D   @ C H E C K S _ A V A I L A B L E   =   ' Y ' )  
 	  
 	 	 B E G I N 	 	 	  
 	 	 	 U P D A T E   E C O M M _ B A N K _ D E T A I L S   S E T   L A S T _ I S S U E D _ C H E C K _ N U M   =   L A S T _ I S S U E D _ C H E C K _ N U M   +   1 ,   D A T E _ T I M E _ M O D   =   G E T D A T E ( ) ,   M O D _ U S E R _ I D   =   @ M O D _ U S E R _ I D   W H E R E   S I T E _ I D   =   @ S I T E _ I D  
 	 	 	 S E T   @ N E W C H E C K N U M   =   ( S E L E C T   T O P   1   L A S T _ I S S U E D _ C H E C K _ N U M   F R O M   E C O M M _ B A N K _ D E T A I L S   W H E R E   S I T E _ I D   =   @ S I T E _ I D )  
 	 	 	 S E T   @ B A N K _ I D   =   ( S E L E C T   T O P   1   I D   F R O M   E C O M M _ B A N K _ D E T A I L S   W H E R E   S I T E _ I D   =   @ S I T E _ I D )  
 	 	 	 U P D A T E   E C O M M _ O T C _ T X   S E T   S E T T L E M E N T _ S T A T U S   =   ' S E T T L E D ' ,   C H E C K N U M   =   @ N E W C H E C K N U M ,   D A T E _ T I M E _ M O D   =   G E T D A T E ( ) ,   M O D _ U S E R _ I D   =   @ M O D _ U S E R _ I D     W H E R E   S I T E _ I D   =   @ S I T E _ I D   A N D   S E T T L E M E N T _ S T A T U S   =   ' U N S E T T L E D '    
 	 	 	 	 	 	 	 	 	 A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   > =   @ F R O M _ D A T E   A N D   c o n v e r t ( D A T E ,   T X _ D A T E ,   1 0 1 )   < =   @ T O _ D A T E   A N D   T X _ D A T E   < =   @ V A L I D T I M E S T A M P  
 	 	 	 I N S E R T   I N T O   E C O M M _ C H E C K _ H I S T   ( S I T E _ I D ,   C H E C K N U M ,   P A Y M E N T _ T Y P E ,   T O T A L _ T R A N S A C T I O N S ,   A M O U N T ,   B A N K _ I D ,   I S _ V O I D E D ,   D A T E _ T I M E _ M O D ,   D A T E _ T I M E _ C R E A T E D ,   M O D _ U S E R _ I D ,   M A C H I N E N A M E ,   A C T I V E ,   C O M M E N T S ,   C R E A T E D _ B Y )  
 	 	 	 	 	 V A L U E S   ( @ S I T E _ I D ,   @ N E W C H E C K N U M ,   @ P A Y M E N T _ T Y P E ,   @ T O T A L T R A N S A C T I O N S ,   @ T X _ A M O U N T P A Y A B L E ,   @ B A N K _ I D ,   ' N ' ,   G E T D A T E ( ) ,   G E T D A T E ( ) ,   @ M O D _ U S E R _ I D ,   @ M A C H I N E N A M E ,   ' Y ' ,   ' F R O M :   '   +   @ F R O M _ D A T E   +   '   T O :   '   +   @ T O _ D A T E ,   @ M O D _ U S E R _ I D ) 	 	 	  
 	 	 E N D 	  
 	 	 I F   ( @ T X _ A M O U N T P A Y A B L E   < =   0   A N D   @ C H E C K S _ A V A I L A B L E   =   ' Y ' )  
 	 	 B E G I N  
 	 	 	 S E T   @ M E S S A G E   =   ' C h e c k   i s   n o t   a v a i l a b l e   i f   a m o u n t   p a y a b l e   i s   z e r o   o r   n e g a t i v e .   N e g a t i v e   A m o u n t   i n d i c a t e s   m o r e   r e f u n d s   a r e   p r o c e s s e d   t h a n   c h a r g e d   d u r i n g   t h e   s e l e c t e d   t i m e   p e r i o d .   P l e a s e   s e l e c t   a   l a r g e r   t i m e   p e r i o d   a n d   t r y   a g a i n . ' 	  
 	 	 E N D  
 	 	 S E L E C T     D I S T I N C T    
 	 	 E B . I D   A S   A C C O U N T I D ,    
 	 	 E B . S I T E _ I D ,    
 	 	 S I T E . N A M E   A S   S I T E _ N A M E ,  
 	 	 ( E B . F R O M _ F N A M E   +   '   '   +   E B . F R O M _ M I N I T I A L   +   '   '   +   E B . F R O M _ L N A M E )   A S   F R O M N A M E ,  
 	 	 E B . F R O M _ A D D R L I N E 1   A S   F R O M A D D R E S S L 1 ,  
 	 	 E B . F R O M _ A D D R L I N E 2   A S   F R O M A D D R E S S L 2 ,  
 	 	 E B . F R O M _ C I T Y   A S   F R O M C I T Y ,  
 	 	 E B . F R O M _ S T A T E   A S   F R O M S T A T E ,  
 	 	 E B . F R O M _ Z I P C O D E   A S   F R O M Z I P C O D E ,  
 	 	 E B . F R O M _ P H O N E N U M ,    
 	 	 E B . B A N K _ N A M E   A S   B A N K N A M E ,  
 	 	 E B . B A N K _ A D D R L I N E 1   A S   B A N K A D D R E S S L 1 ,  
 	 	 E B . B A N K _ A D D R L I N E 2   A S   B A N K A D D R E S S L 2 ,  
 	 	 E B . B A N K _ C I T Y   A S   B A N K C I T Y ,  
 	 	 E B . B A N K _ S T A T E   A S   B A N K S T A T E ,  
 	 	 E B . B A N K _ Z I P C O D E   A S   B A N K Z I P C O D E , 	  
 	 	 S I T E . N A M E _ O N _ C H E C K   A S   O R D E R O F ,  
 	 	 E B . B A N K _ C O D E   A S   B A N K C O D E ,    
 	 	 E B . R O U T I N G _ N U M   A S   R O U T I N G N U M ,  
 	 	 E B . A C C O U N T _ N U M   A S   A C C O U N T N U M ,  
 	 	 C A S E    
 	 	 	 W H E N   @ T X _ A M O U N T P A Y A B L E   >   0   T H E N  
 	 	 	 	 E B . L A S T _ I S S U E D _ C H E C K _ N U M    
 	 	 	 E L S E  
 	 	 	 	 0  
 	 	 E N D 	 A S   C H E C K N U M , 	 	 	 	  
 	 	 @ T O T A L T R A N S A C T I O N S   A S   T O T A L T R A N S A C T I O N S ,  
 	 	 C A S T ( @ T X _ A M O U N T P A Y A B L E   A S   D E C ( 1 0 , 2 ) ) A S   T X _ A M O U N T P A Y A B L E ,  
 	 	 D B O . F _ N U M B E R T O T E X T ( @ T X _ A M O U N T P A Y A B L E )   A S   T E X T T X _ A M O U N T ,  
 	 	 @ M E S S A G E   A S   M E S S A G E ,  
 	 	 @ V A L I D T I M E S T A M P   A S   V A L I D T I M E S T A M P  
 	 	 F R O M   E C O M M _ B A N K _ D E T A I L S   E B    
 	 	 I N N E R   J O I N   E C O M M _ S I T E   S I T E   O N   S I T E . I D   =   E B . S I T E _ I D  
 	 	 W H E R E   S I T E . I D   =   @ S I T E _ I D   A N D   E B . A C T I V E   =   ' Y '  
 	 E N D  
 E N D  
 G O  
 