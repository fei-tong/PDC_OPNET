MIL_3_Tfile_Hdr_ 145A 94B modeler 40 4BF9E846 550841F9 5E wpd FeiTong 0 0 none none 0 0 none 5BAC6A96 1314 0 0 0 0 0 0 1e80 8                                                                                                                                                                                                                                                                                                                                                                                                                ����             0x0             NONE                                 2   x              
   Type   
                        integer             signed, big endian          
   4   
       
   2   
          set             NONE             *����          J   1   J             n   x              
   Src   
                        integer             signed, big endian          
   16   
       ����             set             NONE             *����          J   2   J             n   �              
   Previous Hop   
                        integer             signed, big endian          
   16   
       ����             set             NONE             *����          J   3   J             n   �              
   Next Hop   
                        integer             signed, big endian          
   16   
       ����             set             NONE             *����          J   4   J             n   �              
   Grade   
                        integer             signed, big endian          
   8   
       
   -1   
          set             NONE             *����          J   5   J             �   �              
   Hop Num   
                        integer             signed, big endian          
   8   
       ����             set             NONE             *����          J   6   J             n   �              
   Data Num   
                        integer             signed, big endian          
   16   
       ����             set             NONE             *����          J   7   J                    pk_field      n                
   Data No   
                        integer             signed, big endian          
   16   
       ����             set             NONE             *����          J   8   J                    pk_field                     
   Steady Flag   
       
      �After the steady time set in the node attribute: Steady Time, set this flag to indicate that this is the data after the system becomes steady.   
          integer             signed, big endian          
   8   
       
   -1   
          set             NONE             *����          J   9   J            ^                
   
Exp Cycles   
       
      :This field is used to determine the packet sending order.    The main idea is   A1. Define an abstract for each packet: Experienced Cycles: ExpCyc   T2. After state T, the node will increase the ExpCyc of each packet in its queue by 1   �3. All packets in a node's queue are sorted by ExpCyc in descending order. The packet with the highest ExpCyc is at the head of the queue.   24. Add a field called "Exp Cycles" in MAC_DATA_PK.   
          integer             signed, big endian          
   16   
       
   0   
          set             NONE             *����          J   10   J                    pk_field      n  ,              
   field_0   
                        integer             signed, big endian          J   122   J       ����             set             NONE             *����          J   11   J             n  h              
   Create Time   
       
       
       
   floating point   
       
   
big endian   
       
   60   
       
����   
       
   set   
       
   NONE   
       
   *����   
       J   12   J             n  �              
   Receiving Time   
       
      �This is not the true time that the packet is created, but the created time plus the waiting time for the start of the first T state.   � So we want to ignore such waiting time, to compare with the analytic result for which it�s difficult to calculate this waiting time.   
       
   floating point   
       
   
big endian   
       
   60   
       ����             set             NONE             *����          J   13   J                    pk_field      n  �              J   Queueing Time   J                     J   floating point   J       J   
big endian   J       J   64   J       ����             set             NONE             *����          J   14   J                    pk_field   