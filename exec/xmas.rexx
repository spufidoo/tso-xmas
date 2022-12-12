/* REXX */                                                                      
  /*+---------------------------------------+                                   
    |  Xmas - Ken MacKenzie - October 1999  |                                   
    |  A bit of festive fun written as a    |                                   
    |  parting gift.                        |                                   
    +---------------------------------------+*/                                 
  Call Initialise                                                               
  Call Set_Up                                                                   
  Call Process                                                                  
  Exit                                                                          
Set_Up:                                                                         
  /*+--------------------------------+                                          
    |  Sets up the Christmas Tree    |                                          
    |  The tree is hardcoded within  |                                          
    |  this routine and the          |                                          
    |  the sourceline() function is  |                                          
    |  used to extract it.           |                                          
    |  The "MyLine" and "Set_Data"   |                                          
    |  routines are called to        |                                          
    |  achieve this.                 |                                          
    +--------------------------------+*/                                        
                  /*       |  If you add any lines here, you will */            
  Call MyLine     /* x     |  have to change the "x = result + 4" */            
  x = result + 4  /* x+1   |  line to reflect the top of the tree.*/            
  Call Set_Data x /* x+2   |                                      */            
/*                /* x+4   |                                      */            
                                       #                                        
                                      ###                                       
                                    #######                                     
                                   #########                                    
                                   #########                                    
     Merry Christmas!            #############                                  
                                ###############                                 
                                ###############                                 
                              ###################                               
                             #####################                              
                             #####################                              
                           #########################                            
                          ###########################          Press ENTER to   
                          ###########################             continue..    
                        ###############################                         
                       #################################                        
                     #####################################                      
                    #######################################                     
                                      RRR                                       
  U   U  UUUUU  UUUU   UUUU   U   U   RRR   U   U  U   U   UUU    UUUU          
  UU UU  U      U   U  U   U   U U    RRR    U U   UU UU  U   U  U              
  U U U  UUU    UUUU   UUUU     U     RRR     U    U U U  UUUUU   UUU           
  U   U  U      U   U  U   U    U     RRR    U U   U   U  U   U      U          
  U   U  UUUUU  U   U  U   U    U     RRR   U   U  U   U  U   U  UUUU           
*/                                                                              
  Return                                                                        
MyLine:                                                                         
  /*+--------------------------------+                                          
    |  Simply returns to its caller  |                                          
    |  the line number from which    |                                          
    |  it was called                 |                                          
    +--------------------------------+*/                                        
  Return sigl                                                                   
Set_Data:                                                                       
  /*+---------------------------------------+                                   
    |  This routine does most of the work   |                                   
    |  by reading through the source lines  |                                   
    |  which make up the tree.  From line   |                                   
    |  19 onwards, we have the trunk and    |                                   
    |  the "Merry Xmas" banner - these      |                                   
    |  lines are treated differently.       |                                   
    |                                       |                                   
    |  TREE:                                |                                   
    |  The process is: for each line, read  |                                   
    |  each character.  If it's not blank,  |                                   
    |  change the shadow character.         |                                   
    |  Occasionally, we change it to        |                                   
    |  blinking but, mostly, it is set to   |                                   
    |  green.  We can't get two flashers    |                                   
    |  together.  The flashing is           |                                   
    |  controlled by obtaining a random     |                                   
    |  number from 1 to 7.  If it's 1, we   |                                   
    |  flash!                               |                                   
    |                                       |                                   
    |  TRUNK & BANNER:                      |                                   
    |  Each character is picked up and we   |                                   
    |  change the shadow to the character   |                                   
    |  All these characters equate to       |                                   
    |  reverse video.  See the panel for    |                                   
    |  more information.                    |                                   
    +---------------------------------------+*/                                 
  Arg x                                                                         
  y = x + 23                                                                    
  j = 0                                                                         
  Do i = x To y                                                                 
    j = j + 1                                                                   
    d.j = Sourceline(i)                                                         
    ll = Length(d.j)                                                            
    s.j = Copies(' ', ll)                                                       
    Do k = 1 To ll                                                              
      If Substr(d.j, k, 1) ^= ' ' Then                                          
        If j <= 18 & substr(d.j,k,1) = '#' then                                 
          Do                                                                    
            If random_before Then                                               
              Do                                                                
                z = 9                                                           
                random_before = 0                                               
              End                                                               
            Else                                                                
              Do                                                                
                z = Random(1,7)                                                 
                random_before = 1                                               
              End                                                               
            If z = 1 Then                                                       
              Do                                                                
                p = 8                                                           
                q = 14                                                          
                dchar = '!'                                                     
              End                                                               
            Else                                                                
              Do                                                                
                p = 2                                                           
                dchar = '#'                                                     
                q = 2                                                           
              End                                                               
            x = Random(p, q)                                                    
            char = Substr(abc, x, 1)                                            
            s.j = Overlay(char, s.j, k)                                         
            d.j = Overlay(dchar, d.j, k)                                        
          End                                                                   
        Else                                                                    
          Do                                                                    
            char = Substr(d.j, k, 1)                                            
            if j <= 18 then do                                                  
               d.j = Overlay(substr(d.j,k,1), d.j, k)                           
               s.j = Overlay('F',s.j, k)                                        
            end                                                                 
            else do                                                             
               d.j = Overlay(' ', d.j, k)                                       
               s.j = Overlay(char, s.j, k)                                      
            end                                                                 
          End                                                                   
                                                                                
    End                                                                         
  End                                                                           
  Return                                                                        
Process:                                                                        
  /*+------------------------------------------------+                          
    |  Picks up the lines which make up the display  |                          
    |  and the shadow and creates the full data and  |                          
    |  shadow, then displays the panel.              |                          
    +------------------------------------------------+*/                        
  data   =                                                                      
  shadow =                                                                      
  Do i = 1 To 24                                                                
    data   =   data || Centre(d.i,w)                                            
    shadow = shadow || Centre(s.i,w)                                            
  End                                                                           
  Address ISPEXEC                                                               
  "DISPLAY PANEL(XMAS) CURSOR(DATA) CSRPOS(1890)"                               
  Return                                                                        
Initialise:                                                                     
  /*+-------------------------------------+                                     
    |  Initialises a few bits and pieces  |                                     
    +-------------------------------------+*/                                   
  w = 79                                                                        
  abc    = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'                                         
  random_before = 0                                                             
  Return
