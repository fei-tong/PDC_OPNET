MIL_3_Tfile_Hdr_ 145A 140A modeler 9 51C3951E 535EBA8D 2D wpd FeiTong 0 0 none none 0 0 none 3228F461 2A30 0 0 0 0 0 0 1e80 8                                                                                                                                                                                                                                                                                                                                                                                                   Ф═gЅ      @  Њ  Ќ  _  c  g  &  &  '  (  ($  ((  (,  [      	Send DATA                                                                       ЦZ             
Start Time                                                                                   ЦZ             Traffic Load                                infinity(-1)                                     infinity(-1)                 0(Remote or No traffic)                 1(test)                20                40      (          60      <          80      P          100      d           ЦZ             Debug                                                                       ЦZ             Packet Arrival Rate                                                                                     ;lambda --- The packet arrival rate in poisson distribution.ЦZ                 	   begsim intrpt         
          
   doc file            	nd_module      endsim intrpt         
          
   failure intrpts            disabled      intrpt interval         н▓IГ%ћ├}          priority          
          
   recovery intrpts            disabled      subqueue                     count          
          
      list   	      
          
      super priority                           "   Objid	\process_id;       Objid	\node_id;       double	\start_time;       Boolean	\send_DATA;       int	\node_address;       int	\traffic_load;       Boolean	\infinity;       int	\node_type;       int	\self_pk_num;       Boolean	\debug;       double	\arrival_rate;       Stathandle	\traffic_sent_hndl;       Stathandle	\packets_sent_hndl;       %Stathandle	\global_packets_sent_hndl;       Boolean	\the_start;       int	\grade;       double	\steady_time;          //File   	FILE *in;   char temp_file_name[300];       Ici* iciptr_TV;   double sim_time;      #define SEND_STRM 0   //Define node type   #define sink 	1   #define sensor 	2       B#define END	        		    	(op_intrpt_type() == OPC_INTRPT_ENDSIM)       //Define remote-interrupt code    5#define REMOTE_STAT_CODE				500	/*remote statistics*/           .//Self-interrupt code and transition condition   #define SEND_DATA_S_CODE		100   h#define SEND_DATA_S				((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SEND_DATA_S_CODE))   0//Remote-interrupt code and transition condition   #define SEND_DATA_R_CODE		200   j#define SEND_DATA_R				((op_intrpt_type() == OPC_INTRPT_REMOTE) && (op_intrpt_code() == SEND_DATA_R_CODE))       int pk_num=0;   //function prototype   'static void create_and_send_DATA(void);   int data_num=0;      //create DATA pk   static void    create_and_send_DATA(void)   {   //var   	Packet * pk_DATA;   //in   	FIN(create_and_send_DATA());   //body   	if(the_start != OPC_TRUE){   		data_num++;   ,		pk_DATA = op_pk_create_fmt("MAC_DATA_PK");   %		op_pk_nfd_set(pk_DATA,"Hop Num",0);   5		op_pk_nfd_set(pk_DATA,"Create Time",op_sim_time());   ,		op_pk_nfd_set(pk_DATA,"Data No",data_num);   D		op_pk_nfd_set(pk_DATA,"Steady Flag",0); //initiate the Steady Flag   "		if(op_sim_time() > steady_time){   *			op_pk_nfd_set(pk_DATA,"Steady Flag",1);   		}   		    		op_pk_send(pk_DATA,SEND_STRM);   &		//op_sim_message("sent data!!!","");   	}   	   //out   	FOUT;   }                                          ќ            
   init   
       
   (   // Obtain related ID   process_id = op_id_self();   &node_id = op_topo_parent(process_id);       8op_ima_obj_attr_get(process_id, "Send DATA",&send_DATA);   :op_ima_obj_attr_get(process_id, "Start Time",&start_time);   8//op_ima_obj_attr_get(process_id, "Interval",&interval);   >op_ima_obj_attr_get(process_id, "Traffic Load",&traffic_load);   0op_ima_obj_attr_get(process_id, "Debug",&debug);   Dop_ima_obj_attr_get(process_id,"Packet Arrival Rate",&arrival_rate);       7op_ima_obj_attr_get(node_id, "user id", &node_address);   5op_ima_obj_attr_get(node_id, "Node Type",&node_type);   9op_ima_obj_attr_get(node_id, "Steady Time",&steady_time);       Lthe_start = OPC_FALSE;//No packet is generated during the first interruption       if(traffic_load<0)   {   	infinity = OPC_TRUE;   }else   {   	infinity = OPC_FALSE;   }           if(send_DATA&&traffic_load<0)   {   F	op_intrpt_schedule_self(op_sim_time() + start_time,SEND_DATA_S_CODE);   }   if(send_DATA&&traffic_load>0)   {   F	op_intrpt_schedule_self(op_sim_time() + start_time,SEND_DATA_S_CODE);   	--traffic_load;   }   mtraffic_sent_hndl = op_stat_reg ("Generator.Traffic Sent (packets/sec)",OPC_STAT_INDEX_NONE, OPC_STAT_LOCAL);   ipackets_sent_hndl = op_stat_reg ("Generator.Packets Sent (packets)",OPC_STAT_INDEX_NONE, OPC_STAT_LOCAL);   qglobal_packets_sent_hndl = op_stat_reg ("Generator.Packets Sent (packets)",OPC_STAT_INDEX_NONE, OPC_STAT_GLOBAL);   //pk_num=0;   self_pk_num=0;   
                     
          
          pr_state        J            
   idle   
       
      ,op_ima_obj_attr_get(node_id,"grade",&grade);   
                     
           
          pr_state        J   Z          
   send DATA S   
       
      create_and_send_DATA();   the_start=OPC_FALSE;   	pk_num++;   self_pk_num++;       'op_stat_write (traffic_sent_hndl, 1.0);   'op_stat_write (traffic_sent_hndl, 0.0);   8op_stat_write (packets_sent_hndl, (double) self_pk_num);   9op_stat_write (global_packets_sent_hndl, (double)pk_num);       sim_time = op_sim_time();   //if(sim_time<=12200){    	if(!infinity && traffic_load>0)   	{   B		//▓┤╦╔ио▓╝║═оИ╩§ио▓╝х─╣п¤хБ║хйхО╩К1/arrive_rate╗╣╩Кarrive_rate?    `		op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(1/arrival_rate),SEND_DATA_S_CODE);   		--traffic_load;   	}	   	if(infinity)   	{   `		op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(1/arrival_rate),SEND_DATA_S_CODE);   	}       
	if(debug)   t		printf("Node: %d. In \"gsrc\",time:%f,\nHave created DATA and sent it to \"gmac\".\n",node_address,op_sim_time());   //}   
                     
          
          pr_state        J  ┬          
   send DATA R   
       
   	   create_and_send_DATA();   the_start=OPC_FALSE;   	pk_num++;   self_pk_num++;       	if(debug)   3printf("In \"gsrc\",Remote Interruption,time:%f,\n\   1		Have created DATA and sent it to \"gmac\".\n",\   		op_sim_time());   
                     
          
          pr_state        ■            
   end   
       J   2   if(send_DATA)   {   /	if(op_ima_obj_attr_exists(node_id,"Log File"))   	{	   9		op_ima_obj_attr_get(node_id,"Log File",temp_file_name);   "		in = fopen(temp_file_name,"at");   ї		fprintf(in,"End1: Node %d sent %d packets.\nAll soruces totally sent %d packets. (in \"gsrc->end\")\r\n",node_address,self_pk_num,pk_num);   C		//fprintf(in,"The sending interval is %f seconds.\r\n",interval);   9		fprintf(in,"Simulation time: %f s.\r\n",op_sim_time());   		fprintf(in,"End.\r\n\r\n");   		fclose(in);   	}   }else       %if(traffic_load==0 && self_pk_num!=0)   {       /	if(op_ima_obj_attr_exists(node_id,"Log File"))   	{	   .		op_ima_obj_attr_get(node_id,"grade",&grade);       9		op_ima_obj_attr_get(node_id,"Log File",temp_file_name);   "		in = fopen(temp_file_name,"at");   ъ		fprintf(in,"End2: Node %d in grade %d sent %d packets.\nAll sources totally sent %d packets.(in \"gsrc->end\").\r\n",node_address,grade,self_pk_num,pk_num);   7		//fprintf(in,"иб░Ч╝СИЗ╬фБ║%f seconds.\r\n",interval);   9		fprintf(in,"Simulation time: %f s.\r\n",op_sim_time());   		fprintf(in,"End.\r\n\r\n");   		fclose(in);   	}   }       B/****************************************************************/   B/*create ICI for statistic purpose; then set remote interruption*/       if(self_pk_num!=0){   (	//printf("self_pk_num=%d",self_pk_num);   *	iciptr_TV = op_ici_create("src_pkt_ici");   >	op_ici_attr_set_int32(iciptr_TV, "sent pkt num",self_pk_num);   5	op_ici_attr_set_int32(iciptr_TV, "src grade",grade);   	op_ici_install (iciptr_TV);   b	op_intrpt_force_remote (REMOTE_STAT_CODE,op_id_from_name(node_id,OPC_OBJTYPE_PROC,"statistics"));   	op_ici_install (OPC_NIL);    	   *	iciptr_TV = op_ici_create("src_pkt_ici");   >	op_ici_attr_set_int32(iciptr_TV, "sent pkt num",self_pk_num);   5	op_ici_attr_set_int32(iciptr_TV, "src grade",grade);   	op_ici_install (iciptr_TV);   d	op_intrpt_force_remote (REMOTE_STAT_CODE,op_id_from_name(node_id,OPC_OBJTYPE_PROC,"collect data"));   	op_ici_install (OPC_NIL);    }   J                                          pr_state                        Э        г    D            
   tr_0   
                                   
           
                                     pr_transition              P   │     Q   t  Q   Ы          
   tr_2   
                                   
           
                                     pr_transition                 ┤     F   ш  G   v          
   tr_3   
       
   SEND_DATA_S   
                     
           
                                     pr_transition                i     E  %  D  Д          
   tr_4   
       
   SEND_DATA_R   
                     
           
                                     pr_transition              T  g     S  Ф  T  #          
   tr_5   
                                   
           
                                     pr_transition              Ф       [    Щ            
   tr_6   
       
   END   
                     
           
                                     pr_transition                   Traffic Sent (packets/sec)          (Total number of packets per second that    &are generated and sent to lower layer    by this source.    	Generator   bucket/default total/sum_time   linear        н▓IГ%ћ├}   Packets Sent (packets)          Total number of packets sent   	Generator   bucket/default total/max value   linear        н▓IГ%ћ├}      Packets Sent (packets)          &total packets sent by all source nodes   	Generator   bucket/default total/max value   linear        н▓IГ%ћ├}                        