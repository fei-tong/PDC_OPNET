MIL_3_Tfile_Hdr_ 145A 140A modeler 9 4C8C2A72 51B3D5C0 55 wpd FeiTong 0 0 none none 0 0 none D86DCF1B AD2D 0 0 0 0 0 0 1e80 8                                                                                                                                                                                                                                                                                                                                                                                                   ЋЭg      @  y  }  	и  	м  /Ш  Њк  Њо  Њт  Њц  Њђ  Ћ%  Ћ)  /М      Send GM Timer   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ             Start Schedule Timer   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ             Sleep Factor    џџџџџџџ    џџџџ   	      џџџџ         џџџџ          џџџџ         2      џџџџ      5      џџџџ      8      џџџџ      11      џџџџ      14      џџџџ      17      џџџџ         Must larger than 1.   GTo keep the same duty cycle as S-MAC(5%), Sleep Factor should be set 38ЅZ                Must       be       larger       than       1.   CW   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ                
Contention       Window   durRTS   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ                duration       for       sending       RTS   durCTS   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ                duration       for       sending       CTS   durDATA   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ                duration       for       sending       DATA   durACK   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ                duration       for       sending       ACK   DIFS   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ             SIFS   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ             Start Grade Timer   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ             Debug   џџџџџџџ   џџџџ           џџџџ          џџџџ          џџџџ           ЅZ             	Retx File   џџџџџџџ   џџџџ       џџџџ      џџџџ      џџџџ           ЅZ             Sink Num    џџџџџџџ    џџџџ           џџџџ          џџџџ          џџџџ           ЅZ                    begsim intrpt         
   џџџџ   
   doc file            	nd_module      endsim intrpt         
   џџџџ   
   failure intrpts            disabled      intrpt interval         дВI­%У}џџџџ      priority              џџџџ      recovery intrpts            disabled      super priority             џџџџ          U   Objid	\process_id;       Objid	\node_id;       int	\node_address;       int	\grade;       double	\send_gm_timer;       double	\start_schedule_timer;       int	\sleep_factor;       Evhandle	\send_gm_event;       /* Contention Window */   double	\CW;       double	\DIFS;       double	\SIFS;       double	\durRTS;       double	\durCTS;       double	\durDATA;       double	\durACK;       double	\durSleep;       double	\durActive_half;       Evhandle	\wait_RTS_event;       Boolean	\transceiver_state;       Objid	\rx_id;       double	\waking_time;       Evhandle	\send_RTS_event;       double	\second_contending_time;       Evhandle	\wait_CTS_event;       Evhandle	\wait_ACK_event;       int	\next_hop_1;       int	\next_hop_2;       Evhandle	\send_CTS_event;       Evhandle	\wait_DATA_event;       double	\record_time;       int	\node_type;       double	\start_grade_timer;       double	\all_sleeped_time;       double	\all_active_time;       double	\all_tx_time;       double	\all_rx_time;       Objid	\tx_id;       Objid	\tx_channel_objid;       double	\data_rate;       Boolean	\debug;       List *	\data_id_list;       int	\range;          Packet* pk_TV=NULL;   int pk_type;   double time;   int dest_TV;   int grade_TV;   int hop_num_TV;   int pk_size;   //File   	FILE *in;   char temp_file_name[300];   //char message[100];   int data_id;           DataID * id_TV;   Q   //Define node type   #define sink 	1   #define sensor 	2       //Define packet type   #define grade_pk  1   #define rts_pk    2   #define cts_pk    3   #define ack_pk    4   #define data_pk   5       //Define queue type   #define grade_queue		0   #define data_queue		1       //Define stream in-out NO.   #define SRC_STRM 		1   #define RCV_STRM 		0   #define SEND_STRM 		0   #define DISCARD_STRM 	1       //Define node state   /*   #define initial			0   #define waking			1   &#define awake			2//go to sending state   #define sleeping		3   #define asleep			4   */       5//Define self-interrupt code and transition condition    #define START_GRADE_CODE				1000   #define SEND_GM_CODE					6000   ##define START_SCHEDULE_CODE				7000    #define TO_WAKE_UP_CODE					8000   &#define WAKING_TO_SEND_RTS_CODE			9000   #define SEND_RTS_CODE					10000    #define SEND_DATA_CODE					20000   #define SEND_CTS_CODE					30000   #define SEND_ACK_CODE					40000   '#define SLEEP_FROM_SECOND_CODE 			50000   %#define SLEEP_FROM_FIRST_CODE			60000       B#define END	        		    	(op_intrpt_type() == OPC_INTRPT_ENDSIM)   `#define FROM_LOWER					((op_intrpt_type() == OPC_INTRPT_STRM) && (op_intrpt_strm() == RCV_STRM))   `#define FROM_UPPER					((op_intrpt_type() == OPC_INTRPT_STRM) && (op_intrpt_strm() == SRC_STRM))   i#define START_GRADE					((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == START_GRADE_CODE))   n#define SEND_GM                 	((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SEND_GM_CODE))       n#define START_SCHEDULE				((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == START_SCHEDULE_CODE))   V#define WAKING_TO_WAIT_RTS			(START_SCHEDULE && grade>=0 && grade%(sleep_factor+2)==0)   W#define CONTEND_TO_SEND_RTS			(START_SCHEDULE && grade>=0 && grade%(sleep_factor+2)==1)   Q#define GO_TO_SLEEP					(START_SCHEDULE && grade>=0 && grade%(sleep_factor+2)>=2)       f#define WAKING_UP					((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == TO_WAKE_UP_CODE))   u#define WAKING_TO_SEND_RTS			((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == WAKING_TO_SEND_RTS_CODE))   c#define SEND_RTS					((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SEND_RTS_CODE))   e#define SEND_DATA					((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SEND_DATA_CODE))   c#define SEND_CTS					((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SEND_CTS_CODE))   c#define SEND_ACK					((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SEND_ACK_CODE))   s#define SLEEP_FROM_SECOND			((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SLEEP_FROM_SECOND_CODE))   q#define SLEEP_FROM_FIRST			((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SLEEP_FROM_FIRST_CODE))   W#define CHECK_CHANNEL				((op_intrpt_type() == OPC_INTRPT_STAT) && op_intrpt_stat()==0)       typedef struct   {   	int st_data_id;   }DataID;       //function prototype   %static Boolean data_id_exist(int id);   'static void grade_pk_proc(Packet * pk);   %static void upper_data_pk_proc(void);   static void power_stat(void);   static void record_grade(void);       *int retx=0; //the number of retransmission       $double avg_energy_consumption = 0.0;   double avg_duty_cycle=0.0;   int data_nums_1=0;   И       //Deal with grade pk   static void   grade_pk_proc(Packet * pk)   {   //var   "	int grade_in_pk;//,sink_id_in_pk;   //in   	FIN(grade_pk_proc(pk));   //body   (	op_pk_nfd_get(pk,"Grade",&grade_in_pk);   .	//op_pk_nfd_get(pk,"Sink ID",&sink_id_in_pk);   	   	if(grade<0)   	{   		grade = grade_in_pk;   		//sink_id = sink_id_in_pk;   		   		++grade_in_pk;   (		op_pk_nfd_set(pk,"Grade",grade_in_pk);   		   (		//cancel the previous event if pending    		if(op_ev_valid(send_gm_event))   		{   			op_ev_cancel(send_gm_event);   		}   '		//at the same time, clear grade_queue   -		if(op_subq_empty(grade_queue) == OPC_FALSE)   		{   			op_subq_flush(grade_queue);   		}   		   3		op_subq_pk_insert (grade_queue,pk,OPC_QPOS_TAIL);   		if(node_address%2==0)   		{	   q			send_gm_event = op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(send_gm_timer)+0.5, SEND_GM_CODE);   		}else{   q			send_gm_event = op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(send_gm_timer)+0.1, SEND_GM_CODE);   		}   		   		FOUT;   	}   	   	if(grade_in_pk < grade)   	{   		grade = grade_in_pk;    		//if(sink_id != sink_id_in_pk)   		//{   		//	sink_id = sink_id_in_pk;   		//}   			   		++grade_in_pk;   (		op_pk_nfd_set(pk,"Grade",grade_in_pk);   		   (		//cancel the previous event if pending    		if(op_ev_valid(send_gm_event))   		{   			op_ev_cancel(send_gm_event);   		}   '		//at the same time, clear grade_queue   -		if(op_subq_empty(grade_queue) == OPC_FALSE)   		{   			op_subq_flush(grade_queue);   		}   		   3		op_subq_pk_insert (grade_queue,pk,OPC_QPOS_TAIL);   n		//send_gm_event = op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(send_gm_timer), SEND_GM_CODE);   		if(node_address%2==0)   		{	   q			send_gm_event = op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(send_gm_timer)+0.5, SEND_GM_CODE);   		}else{   q			send_gm_event = op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(send_gm_timer)+0.1, SEND_GM_CODE);   		}   		   		FOUT;   	}   	   	op_pk_destroy(pk);   	   //out   	FOUT;   }        //Received DATA from upper layer   static void    upper_data_pk_proc(void)   {   //var   	Packet* upper_pk;   //in   	FIN(upper_data_pk_proc());   //body    	upper_pk = op_pk_get(SRC_STRM);   (	op_pk_nfd_set(upper_pk,"Type",data_pk);   ,	op_pk_nfd_set(upper_pk,"Src",node_address);   '	op_pk_nfd_set(upper_pk,"Grade",grade);   	   7	op_subq_pk_insert (data_queue,upper_pk,OPC_QPOS_TAIL);   
	if(debug)   L		printf("Have inserted the received DATA from \"gsrc\" into DATA queue\n");   //out   	FOUT;   }       )//In "end" state, proceed power statistic   static void   power_stat(void)   {   //var   
	FILE *in;   	char temp_file_name[300];   	int nodes_num,sink_num;   //in   	FIN(power_stat(void));   //vody   A	op_ima_obj_attr_get(node_id,"Power Record File",temp_file_name);   (	if(strcmp(temp_file_name,"disable")!=0)   	{	   		avg_energy_consumption += all_sleeped_time*0.05+(all_active_time-(all_tx_time+all_rx_time))*0.45+(all_tx_time+all_rx_time)*0.5;   G		avg_duty_cycle += all_active_time/(all_sleeped_time+all_active_time);   7		nodes_num = op_topo_object_count (OPC_OBJTYPE_NDMOB);   8		op_ima_obj_attr_get(process_id, "Sink Num",&sink_num);   )		if(node_address == nodes_num-sink_num){   #			in = fopen(temp_file_name,"at");   	   ы			//fprintf(in,"%d %f %f %f\r\n",node_address,all_sleeped_time*0.05+(all_active_time-(all_tx_time+all_rx_time))*0.45+(all_tx_time+all_rx_time)*0.5,all_active_time/(all_sleeped_time+all_active_time),(all_sleeped_time+all_active_time));   			   		   			fprintf(in,"%d %f %f %d\r\n",node_address,avg_energy_consumption/(nodes_num*(all_sleeped_time+all_active_time)),(avg_duty_cycle/nodes_num)*100,nodes_num);   		   			fclose(in);   		}   	}	   //out   	FOUT;   }       static void record_grade(void)   {   //var   	FILE *file_in;   	char file_name[300];   //in   	FIN(record_grade(void));   //body   <	op_ima_obj_attr_get(node_id,"Grade Record File",file_name);   	   !	file_in = fopen(file_name,"at");   	fprintf(file_in,"%d	%d\r\n",\   		node_address,grade);   	fclose(file_in);   	   *	if(node_type==sink && node_address == -1)   	{   8		op_ima_obj_attr_get(process_id,"Retx File",file_name);   "		file_in = fopen(file_name,"at");   "		fprintf(file_in,"%d	%d	%f\r\n",\   5		retx,data_nums_1,(double)retx/(double)data_nums_1);   		fclose(file_in);   	}   //out   	FOUT;   }       $static Boolean data_id_exist(int id)   {   //var   	int i,list_size;   	DataID* ID;   	Boolean flag=OPC_FALSE;   //in   	FIN(data_id_exist(int id));   //body   *	list_size=op_prg_list_size(data_id_list);   	for(i=0;i<list_size;i++){   2		ID=(DataID *)op_prg_list_access(data_id_list,i);   		if(ID->st_data_id==id){   			flag=OPC_TRUE;   				break;   		}   	}   //out   	FRET(flag);   }                                                      
   init   
       J   c   // Obtain related ID   process_id = op_id_self();   &node_id = op_topo_parent(process_id);   7rx_id = op_id_from_name(node_id,OPC_OBJTYPE_RARX,"rx");   mtx_id = op_id_from_name(node_id,OPC_OBJTYPE_RATX,"tx");//the name of receiver radio in node layer called "tx"       $//obtain tx channel of compound type   ?op_ima_obj_attr_get_objid (tx_id, "channel",&tx_channel_objid);       Ktx_channel_objid = op_topo_child (tx_channel_objid, OPC_OBJTYPE_RATXCH, 0);       0op_ima_obj_attr_get(process_id, "Debug",&debug);       =op_ima_obj_attr_get(tx_channel_objid,"data rate",&data_rate);       debug =OPC_TRUE;       	if(debug)   $	printf("data_rate=%f\n",data_rate);       (pk_TV = op_pk_create_fmt("MAC_DATA_PK");   $pk_size=op_pk_total_size_get(pk_TV);   durDATA=(pk_size+10)/data_rate;   op_pk_destroy(pk_TV);   	if(debug)    	printf("durDATA=%f\n",durDATA);       'pk_TV = op_pk_create_fmt("MAC_RTS_PK");   $pk_size=op_pk_total_size_get(pk_TV);   durRTS=(pk_size+10)/data_rate;   op_pk_destroy(pk_TV);   	if(debug)   	printf("durRTS=%f\n",durRTS);       'pk_TV = op_pk_create_fmt("MAC_CTS_PK");   $pk_size=op_pk_total_size_get(pk_TV);   durCTS=(pk_size+10)/data_rate;   op_pk_destroy(pk_TV);   	if(debug)   	printf("durCTS=%f\n",durCTS);       'pk_TV = op_pk_create_fmt("MAC_ACK_PK");   $pk_size=op_pk_total_size_get(pk_TV);   durACK=(pk_size+10)/data_rate;   op_pk_destroy(pk_TV);   	if(debug)   	printf("durACK=%f\n",durACK);       //obtain parameter   Nop_ima_obj_attr_get(process_id, "Start Grade Timer", &start_grade_timer);		//1   Hop_ima_obj_attr_get(process_id, "Send GM Timer", &send_gm_timer);				//2   Sop_ima_obj_attr_get(process_id, "Start Schedule Timer", &start_schedule_timer);	//3   Gop_ima_obj_attr_get(process_id, "Sleep Factor", &sleep_factor);					//4   7op_ima_obj_attr_get(process_id, "CW",&CW);										//5   ?//op_ima_obj_attr_get(process_id, "durRTS",&durRTS);								//6   ?//op_ima_obj_attr_get(process_id, "durCTS",&durCTS);								//7   @//op_ima_obj_attr_get(process_id, "durDATA",&durDATA);							//8   ?//op_ima_obj_attr_get(process_id, "durACK",&durACK);								//9   ;op_ima_obj_attr_get(process_id, "DIFS",&DIFS);									//10   ;op_ima_obj_attr_get(process_id, "SIFS",&SIFS);									//11           7op_ima_obj_attr_get(node_id, "user id", &node_address);   5op_ima_obj_attr_get(node_id, "Node Type",&node_type);       @//op_ima_obj_attr_get(process_id, "Communication Range",&range);   <//op_ima_obj_attr_set(node_id, "Communication Range",range);       8op_ima_obj_attr_get(rx_id, "state", &transceiver_state);       grade = -1;   //sink_id = -1;       all_sleeped_time = 0;   all_active_time = 0;   all_tx_time = 0;   all_rx_time = 0;       "data_id_list=op_prg_list_create();       //data_nums=0;       M//durActive contains two parts: durReceive & durSedn, and durReceive==durSend   AdurActive_half = 2*CW+durRTS+durCTS+durDATA+durACK+2*DIFS+2*SIFS;   )durSleep = sleep_factor * durActive_half;   if(node_type == sink)   {   	if(node_address==-1){   N		op_intrpt_schedule_self(op_sim_time() + start_grade_timer,START_GRADE_CODE);   	}else{   R		op_intrpt_schedule_self(op_sim_time() + start_grade_timer+1.0,START_GRADE_CODE);   	}   }	       Sop_intrpt_schedule_self(op_sim_time() + start_schedule_timer, START_SCHEDULE_CODE);       <//op_ima_obj_attr_get (process_id, "subqueue", &subq_objid);   A//num_subqs = op_topo_child_count (subq_objid, OPC_OBJTYPE_SUBQ);   &//printf("згЖгСаИіЪ§:%d\n",num_subqs);   J       
      /*   @op_ima_obj_attr_get(node_id,"Grade Record File",temp_file_name);   remove(temp_file_name);   7op_ima_obj_attr_get(node_id,"Log File",temp_file_name);   remove(temp_file_name);   */   if(node_type == sink)   {   8	op_ima_obj_attr_get(node_id,"Log File",temp_file_name);   !	in = fopen(temp_file_name,"at");   	   l	fprintf(in,"Begin:\r\ndurActive_half: %f, durSleep: %f. cycle time: (%d+2)*%f=%f.(in \"gmac->init\")\r\n",\   W		durActive_half,durSleep,sleep_factor,durActive_half,(sleep_factor+2)*durActive_half);   "	fprintf(in,"duty cycle:%f.\r\n",\   1			durActive_half*2/(durActive_half*2+durSleep));   	fclose(in);   }   /*   'if(strcmp(temp_file_name,"disable")!=0)   {	   5	printf("Node:%d, ДЫНкЕуПЩВњЩњМЧТМ.\n",node_address);   !	in = fopen(temp_file_name,"at");   ;	fprintf(in,"Simulation_time		Average_power_consumed\r\n");   	fclose(in);   }   */   
       
   џџџџ   
          pr_state                    
   idle   
       
      if(END)   {   /*   A	op_ima_obj_attr_get(node_id,"Grade Record File",temp_file_name);   	   !	in = fopen(temp_file_name,"at");   *	fprintf(in,"НкЕуЃК%d, ЦфМЖБ№ЮЊЃК%d\r\n",\   		node_address,grade);   	fclose(in);   */   	record_grade();   	   !	op_prg_list_free (data_id_list);    	op_prg_mem_free (data_id_list);   }        //Received DATA from upper layer   if(FROM_UPPER)   {   
	if(debug)   G		printf("In \"idle\" state: received DATA which is from \"gsrc\".\n");   	upper_data_pk_proc();   }   
       J          if(node_type!=sink)   		grade=1;       J           џџџџ             pr_state          v          
   GM proc   
       
      pk_TV = op_pk_get(RCV_STRM);   %op_pk_nfd_get(pk_TV,"Type",&pk_type);   if(pk_type == grade_pk)   {   	grade_pk_proc(pk_TV);   }   else   {   	op_pk_destroy(pk_TV);   q	op_sim_end("Waiting Grade Message Err: Are you kidding me?","I'm waiting Grade Message","Not you","ЧызаЯИМьВщ");       }   
                     
   џџџџ   
          pr_state                     
   send gm   
       
   	   +if(op_subq_empty(grade_queue) == OPC_FALSE)   {   7	pk_TV = op_subq_pk_remove(grade_queue, OPC_QPOS_HEAD);   	op_pk_send(pk_TV,SEND_STRM);   }   else   {   G	op_sim_end("Err: grade queue is empty, simulation is over!","","","");   }   
                     
   џџџџ   
          pr_state      	  v            
   sleeping   
       
   ]   @if(op_intrpt_code() == START_SCHEDULE_CODE)// from "GO_TO_SLEEP"   {	    	if(grade % (sleep_factor+2)>=2)   	{   @		time = (sleep_factor+2-grade%(sleep_factor+2))*durActive_half;   E		//time = durSleep - ((grade%(sleep_factor+2))-3)*durActive_half;			   	}   	else   	{   H		op_sim_end("ЗТецГіДэ","grade%(sleep_factor+2)ВЛДѓгк3Лђ0","ЧыЗДЫМ","");   	}   	/*   8	op_ima_obj_attr_get(node_id,"Log File",temp_file_name);   !	in = fopen(temp_file_name,"at");   y	fprintf(in,"Node:%d, Grade:%d, Grade%%(%d+2): %d, time:%f, enter into \"sleeping\"state, been \"asleep\" for: %f.\r\n",\   V		node_address,grade,sleep_factor,grade%(sleep_factor+2),op_sim_time(),durSleep-time);   	fclose(in);   	*/   /	//set timer,when wake up, go to "waking" state   @	op_intrpt_schedule_self(op_sim_time() + time, TO_WAKE_UP_CODE);   
	if(debug)   ;		printf("Node:%d, Grade:%d, time:%f,in sleeping period.\n\   			Initial to sleeping.\n\   (			After %f seconds, go to wake up.\n",\   *			node_address,grade,op_sim_time(),time);   	   	//time statistic   	record_time = op_sim_time();   }   else   Fif(op_intrpt_code() == SLEEP_FROM_FIRST_CODE)//sleep from first period   {   *	//time = CW+durCTS+durDATA+durACK+3*SIFS;   5	time = waking_time + durActive_half - op_sim_time();   		   0	//when wake up, go to "second contention" state   H	op_intrpt_schedule_self(op_sim_time() + time, WAKING_TO_SEND_RTS_CODE);   
	if(debug)   ;		printf("Node:%d, Grade:%d, time:%f,in sleeping period.\n\   (			To sleeping from the first period.\n\   .			After %f seconds, go to second period.\n",\   *			node_address,grade,op_sim_time(),time);   	   	//time statistic   ?	all_active_time = all_active_time+(op_sim_time()-record_time);   	record_time = op_sim_time();   }   else   Hif(op_intrpt_code() == SLEEP_FROM_SECOND_CODE)//sleep from second period   {   	   K	time = second_contending_time + durActive_half + durSleep - op_sim_time();   	   %	//when wake up, go to "waking" state   @	op_intrpt_schedule_self(op_sim_time() + time, TO_WAKE_UP_CODE);   
	if(debug)   ;		printf("Node:%d, Grade:%d, time:%f,in sleeping period.\n\   %			To sleeping from second period.\n\   2			After %f seconds, go to \"wakeing\" state.\n",\   *			node_address,grade,op_sim_time(),time);   	   	//time statistic   ?	all_active_time = all_active_time+(op_sim_time()-record_time);   	record_time = op_sim_time();   }        //Received DATA from upper layer   if(FROM_UPPER)   {   
	if(debug)   K		printf("In \"sleeping\" state: received DATA which is from \"gsrc\".\n");   	upper_data_pk_proc();   }       $if(FROM_LOWER && !transceiver_state)   {	   $	op_pk_destroy(op_pk_get(RCV_STRM));   
	if(debug)   K		printf("Node:%d, time:%f. Node is sleeping, destroy the received pk.\n",\   			node_address,op_sim_time());   }   if(END)   {   C	all_sleeped_time = all_sleeped_time + (op_sim_time()-record_time);   	power_stat();   	record_grade();   	   !	op_prg_list_free (data_id_list);    	op_prg_mem_free (data_id_list);   }   //close transceiver   transceiver_state = OPC_FALSE;   7op_ima_obj_attr_set(rx_id, "state", transceiver_state);   
       
       
           џџџџ             pr_state      
  v   в          
   waking   
       
   !       //Log record   if(WAKING_TO_WAIT_RTS)   {   	/*   8	op_ima_obj_attr_get(node_id,"Log File",temp_file_name);   !	in = fopen(temp_file_name,"at");   Z	fprintf(in,"Node:%d, Grade:%d, Grade%%4: %d, time:%f, enter into \"waking\" state.\r\n",\   -		node_address,grade,grade%4, op_sim_time());   	fclose(in);   	*/   	record_time = op_sim_time();   }	           //enable transceiver   transceiver_state = OPC_TRUE;   7op_ima_obj_attr_set(rx_id, "state", transceiver_state);       waking_time = op_sim_time();       time = CW+DIFS+durRTS;   Vwait_RTS_event = op_intrpt_schedule_self(op_sim_time() + time, SLEEP_FROM_FIRST_CODE);       	if(debug)   U	printf("Node:%d, Grade:%d, time:%f, entered into first period (\"waking\" state).\n\   	    Waiting RTS.\n\   0		If no RTS, after %f seconds, go to sleep.\n",\   )		node_address,grade,op_sim_time(),time);       //time statistic   Dall_sleeped_time = all_sleeped_time + (op_sim_time() - record_time);   record_time = op_sim_time();   
                     
   џџџџ   
          pr_state        v  :          
   second contention   
       
   5       //Log record   if(CONTEND_TO_SEND_RTS)   {   	/*   8	op_ima_obj_attr_get(node_id,"Log File",temp_file_name);   !	in = fopen(temp_file_name,"at");   e	fprintf(in,"Node:%d, Grade:%d, Grade%%4: %d, time:%f, enter into \"second contention\" state.\r\n",\   ,		node_address,grade,grade%4,op_sim_time());   	fclose(in);   	*/   	record_time = op_sim_time();   }           /*   1. check data_queue   5   if(Y) open transceiver, contending for sending RTS      if(N) go to sleep   */       //enable transceiver   transceiver_state = OPC_TRUE;   7op_ima_obj_attr_set(rx_id, "state", transceiver_state);           'second_contending_time = op_sim_time();   Cif(op_subq_empty(data_queue) == OPC_FALSE)//data queue is not empty   {   1	time = op_dist_uniform(CW*1000.0)/1000.0 + DIFS;   L	send_RTS_event = op_intrpt_schedule_self(op_sim_time()+time,SEND_RTS_CODE);   	   
	if(debug)   :		printf("Node:%d, Grade:%d, time:%f, in second period.\n\   6			data_queue is not empty, Contending to send RTS.\n\   			Waiting to send RTS.\n",\   %			node_address,grade,op_sim_time());   N	//sprintf(message,"Contend to send RTS, op_dist_uniform(CW)=%f\n",time-DIFS);   	//op_sim_message("",message);   }   &else//data queue is empty, go to sleep   {   ?	op_intrpt_schedule_self(op_sim_time(),SLEEP_FROM_SECOND_CODE);   
	if(debug)   :		printf("Node:%d, Grade:%d, time:%f, in second period.\n\   			data_queue is empty.\n\    			Go to sleep immediately.\n",\   %			node_address,grade,op_sim_time());   }       //time statistic   Ball_sleeped_time = all_sleeped_time + (op_sim_time()-record_time);   record_time = op_sim_time();   
                     
   џџџџ   
          pr_state        ю  В          
   wait CTS   
       
      
//send RTS   if(pk_TV!=NULL)   {   	op_pk_destroy(pk_TV);   }       'pk_TV = op_pk_create_fmt("MAC_RTS_PK");   %op_pk_nfd_set(pk_TV, "Type", rts_pk);   )op_pk_nfd_set(pk_TV,"Src", node_address);   #op_pk_nfd_set(pk_TV,"Grade",grade);       op_pk_send(pk_TV, SEND_STRM);       //time statistic   #all_tx_time = all_tx_time + durRTS;       2//set timer for waiting CTS from lower grade nodes   time = durRTS+CW+DIFS+durCTS;   Vwait_CTS_event = op_intrpt_schedule_self(op_sim_time() + time,SLEEP_FROM_SECOND_CODE);   	if(debug)   9	printf("Node:%d, Grade:%d, time:%f, in second period.\n\   		Have sent RTS.\n\   		Waiting to receive CTS.\n\   0		If no CTS, after %f seconds, go to sleep.\n",\   )		node_address,grade,op_sim_time(),time);   
                     
   џџџџ   
          pr_state        *            
   first   
       
       //Received DATA from upper layer   if(FROM_UPPER)   {   
	if(debug)   H		printf("In \"first\" state: received DATA which is from \"gsrc\".\n");   	upper_data_pk_proc();   }       if(END)   {   ?	all_active_time = all_active_time+(op_sim_time()-record_time);   	power_stat();   	record_grade();   	   !	op_prg_list_free (data_id_list);    	op_prg_mem_free (data_id_list);   }   
                         џџџџ             pr_state        *  ў          
   second   
       
       //Received DATA from upper layer   if(FROM_UPPER)   {   
	if(debug)   I		printf("In \"second\" state: received DATA which is from \"gsrc\".\n");   	upper_data_pk_proc();   }   if(END)   {   A	all_active_time = all_active_time + (op_sim_time()-record_time);   	power_stat();   	record_grade();   		   !	op_prg_list_free (data_id_list);    	op_prg_mem_free (data_id_list);   }   
                         џџџџ             pr_state        f  В          
   RCV(2)   
       
   W   if(pk_TV!=NULL)   {   	op_pk_destroy(pk_TV);   }       pk_TV = op_pk_get(RCV_STRM);       $pk_size=op_pk_total_size_get(pk_TV);   time=(pk_size+10)/data_rate;   //time statistic   #//all_rx_time = all_rx_time + time;   	if(debug)   Ђ	printf("For sending data, Node:%d, Grade:%d, time:%f.\nReceived a packet, size: %d.\nReceive Duration is: %f.\n",	node_address,grade,op_sim_time(),pk_size,time);       %op_pk_nfd_get(pk_TV,"Type",&pk_type);       if(pk_type == rts_pk)   {   	//time statistic   $	all_rx_time = all_rx_time + durRTS;   	   E	//RTS listening during contending to send RTS("uniform(CW)+durDIFS")    	if(op_ev_valid(send_RTS_event))   	{   		op_ev_cancel(send_RTS_event);   @		op_intrpt_schedule_self(op_sim_time(),SLEEP_FROM_SECOND_CODE);   		if(debug)   ;			printf("Node:%d, Grade:%d, time:%f, in second period.\n\   B				Failure to send RTS, because received RTS from other nodes.\n\   !				Go to sleep immediately.\n",\   &				node_address,grade,op_sim_time());   	}   }       if(pk_type == cts_pk)   {   	//time statistic   $	all_rx_time = all_rx_time + durCTS;   	   (	op_pk_nfd_get(pk_TV,"Grade",&grade_TV);   &	op_pk_nfd_get(pk_TV,"Dest",&dest_TV);   3	if(grade == grade_TV+1 && dest_TV == node_address)   	{   @		if(op_ev_valid(wait_CTS_event))//the first time to receive CTS   		{    			op_ev_cancel(wait_CTS_event);   *			op_pk_nfd_get(pk_TV,"Src",&next_hop_2);   			    			//wait SIFS time to send DATA   			time = SIFS;   >			op_intrpt_schedule_self(op_sim_time()+time,SEND_DATA_CODE);   			if(debug)   <				printf("Node:%d, Grade:%d, time:%f, in second period.\n\   "					Successfully received CTS.\n\   					Waiting to send DATA.\n",\   '					node_address,grade,op_sim_time());   		}   	}   }       if(pk_type == ack_pk)   {   	//time statistic   $	all_rx_time = all_rx_time + durACK;   	   &	op_pk_nfd_get(pk_TV,"Dest",&dest_TV);   	if(node_address == dest_TV)   	{   !		if(op_ev_valid(wait_ACK_event))   		{    			op_ev_cancel(wait_ACK_event);   			   <			//Data has been sent correctly, remove it from temp_queue   ?			op_pk_destroy(op_subq_pk_remove(data_queue, OPC_QPOS_HEAD));   
			retx--;   4			//recieved ACK correctly, go to sleep immediately   A			op_intrpt_schedule_self(op_sim_time(),SLEEP_FROM_SECOND_CODE);   			if(debug)   <				printf("Node:%d, Grade:%d, time:%f, in second period.\n\   "					Successfully received ACK.\n\   "					Go to sleep immediately.\n",\   '					node_address,grade,op_sim_time());   		}   	}   }       op_pk_destroy(pk_TV);   
                     
   џџџџ   
          pr_state        о  v          
   	send data   
       
      //send DATA   if(pk_TV!=NULL)   {   	op_pk_destroy(pk_TV);   }       //obtain DATA from data_queue   Apk_TV = op_pk_copy(op_subq_pk_access(data_queue, OPC_QPOS_HEAD));   gop_pk_creation_time_set (pk_TV,op_pk_creation_time_get (op_subq_pk_access(data_queue, OPC_QPOS_HEAD)));   	   1op_pk_nfd_set(pk_TV,"Previous Hop",node_address);   +op_pk_nfd_set(pk_TV,"Next Hop",next_hop_2);       op_pk_send(pk_TV,SEND_STRM);   retx++;       //time statistic   $all_tx_time = all_tx_time + durDATA;       1//set timer for waiting ACK from lower grade node   time = durDATA + SIFS + durACK;   Vwait_ACK_event = op_intrpt_schedule_self(op_sim_time() + time,SLEEP_FROM_SECOND_CODE);   	if(debug)   9	printf("Node:%d, Grade:%d, time:%f, in second period.\n\   !		Have sent DATA, waiting ACK.\n\   0		If no ACK, after %f seconds, go to sleep.\n",\   )		node_address,grade,op_sim_time(),time);   
                     
   џџџџ   
          pr_state        ю   Z          
   RCV(1)   
       
      if(pk_TV!=NULL)   {   	op_pk_destroy(pk_TV);   }       pk_TV = op_pk_get(RCV_STRM);       $pk_size=op_pk_total_size_get(pk_TV);   time=(pk_size+10)/data_rate;   //time statistic   #//all_rx_time = all_rx_time + time;   	if(debug)   Є	printf("For receiving data, Node:%d, Grade:%d, time:%f.\nReceived a packet, size: %d.\nReceive Duration is: %f.\n",	node_address,grade,op_sim_time(),pk_size,time);       %op_pk_nfd_get(pk_TV,"Type",&pk_type);       if(pk_type == rts_pk)   {   	//time statistic   $	all_rx_time = all_rx_time + durRTS;       	//wait for RTS   (	op_pk_nfd_get(pk_TV,"Grade",&grade_TV);   	if(grade_TV == grade+1)   	{   @		if(op_ev_valid(wait_RTS_event))//the first time to receive RTS   		{    			op_ev_cancel(wait_RTS_event);   *			op_pk_nfd_get(pk_TV,"Src",&next_hop_1);   			   			//prepare to send CTS   3			time = op_dist_uniform(CW*1000.0)/1000.0 + DIFS;   N			send_CTS_event = op_intrpt_schedule_self(op_sim_time()+time,SEND_CTS_CODE);   			if(debug)   ;				printf("Node:%d, Grade:%d, time:%f, in first period.\n\   "					Successfully received RTS.\n\   !				    Waiting to send CTS.\n",\   '					node_address,grade,op_sim_time());   P			//sprintf(message,"Contend to send CTS, op_dist_uniform(CW)=%f\n",time-DIFS);    			//op_sim_message("",message);   		}   	}   	op_pk_destroy(pk_TV);   }   else   if(pk_type == cts_pk)   {   	//time statistic   $	all_rx_time = all_rx_time + durCTS;   	   B	//CTS listening during contending to send CTS("uniform(CW)+DIFS")    	if(op_ev_valid(send_CTS_event))   	{   		op_ev_cancel(send_CTS_event);   ?		op_intrpt_schedule_self(op_sim_time(),SLEEP_FROM_FIRST_CODE);   		if(debug)   :			printf("Node:%d, Grade:%d, time:%f, in first period.\n\   B				Failure to send CTS, because received CTS from other nodes.\n\   !				Go to sleep immediately.\n",\   &				node_address,grade,op_sim_time());   	}   	op_pk_destroy(pk_TV);   }   else   if(pk_type == data_pk)   {   	//time statistic   %	all_rx_time = all_rx_time + durDATA;   	   *	op_pk_nfd_get(pk_TV,"Next Hop",&dest_TV);   	if(dest_TV == node_address)   	{   "		if(op_ev_valid(wait_DATA_event))   		{   !			op_ev_cancel(wait_DATA_event);   3			op_pk_nfd_get(pk_TV,"Previous Hop",&next_hop_1);   			   /			op_pk_nfd_get(pk_TV,"Hop Num", &hop_num_TV);   			hop_num_TV++;   -			op_pk_nfd_set(pk_TV,"Hop Num",hop_num_TV);   			   			if(node_type == sink)   			{   ,				op_pk_nfd_get(pk_TV,"Data No",&data_id);   				    				if(!data_id_exist(data_id)){   6					id_TV=(DataID *)op_prg_mem_alloc(sizeof(DataID));   					id_TV->st_data_id=data_id;   =					op_prg_list_insert(data_id_list,id_TV,OPC_LISTPOS_TAIL);   					data_nums_1++;   				}   				   #				op_pk_send(pk_TV,DISCARD_STRM);   				if(debug)   -					printf("Data has arrived at sink!!!\n");   			}else   			{   ,				//insert the DATA packet into data_queue   7				op_subq_pk_insert (data_queue,pk_TV,OPC_QPOS_TAIL);   			}   		   			//wait SIFS time to send ACK   			time = SIFS;   =			op_intrpt_schedule_self(op_sim_time()+time,SEND_ACK_CODE);   			if(debug)   ;				printf("Node:%d, Grade:%d, time:%f, in first period.\n\   #					Successfully received DATA.\n\   					Waiting to reply ACK.\n",\   '					node_address,grade,op_sim_time());   		}else   		{   			op_pk_destroy(pk_TV);   		}   	}else   	{   		op_pk_destroy(pk_TV);   	}   }   else   //if(pk_type != data_pk)   {	   
	if(debug)   9		printf("Node:%d, Grade:%d, time:%f, in first period.\n\   C			The received pk is not RTS, CTS, or DATA. The pk type is: %d.\n\   			Destroy this pk.\n",\   -			node_address,grade,op_sim_time(),pk_type);   		   	op_pk_destroy(pk_TV);   }	   
                     
   џџџџ   
          pr_state        f   Z          
   	wait DATA   
       
      
//send CTS   if(pk_TV!=NULL)   {   	op_pk_destroy(pk_TV);   }       'pk_TV = op_pk_create_fmt("MAC_CTS_PK");   $op_pk_nfd_set(pk_TV,"Type", cts_pk);   (op_pk_nfd_set(pk_TV,"Src",node_address);   'op_pk_nfd_set(pk_TV,"Dest",next_hop_1);   #op_pk_nfd_set(pk_TV,"Grade",grade);       op_pk_send(pk_TV, SEND_STRM);       //time statistic   #all_tx_time = all_tx_time + durCTS;       2//set timer for waiting DATA from upper grade node   time = durCTS + SIFS +durDATA;   Vwait_DATA_event = op_intrpt_schedule_self(op_sim_time() + time,SLEEP_FROM_FIRST_CODE);   	if(debug)   8	printf("Node:%d, Grade:%d, time:%f, in first period.\n\   		Have sent CTS.\n\   		Wating to receive Data.\n\   2		If no data, after %f secondes, go to sleep.\n",\   )		node_address,grade,op_sim_time(),time);   
                     
   џџџџ   
          pr_state        о             
   send ACK   
       
      
//send ACK   if(pk_TV!=NULL)   {   	op_pk_destroy(pk_TV);   }       'pk_TV = op_pk_create_fmt("MAC_ACK_PK");   #op_pk_nfd_set(pk_TV,"Type",ack_pk);   (op_pk_nfd_set(pk_TV,"Src",node_address);   'op_pk_nfd_set(pk_TV,"Dest",next_hop_1);   #op_pk_nfd_set(pk_TV,"Grade",grade);       op_pk_send(pk_TV,SEND_STRM);       //time statistic   #all_tx_time = all_tx_time + durACK;       Fop_intrpt_schedule_self(op_sim_time() + durACK,SLEEP_FROM_FIRST_CODE);   	if(debug)   8	printf("Node:%d, Grade:%d, time:%f, in first period.\n\   		Have replied ACK.\n\   /		Go to sleep after finishing sending ACK.\n",\   $		node_address,grade,op_sim_time());   
                     
   џџџџ   
          pr_state        о            
   carrier sense(1)   
       J      	if(debug)   {   _	printf("Node:%d, time:%f. In first period.\nНјШы statwire жаЖЯ\n",node_address,op_sim_time());   ]	printf("down: the received snr=%E.intrpt_code=%d\n",op_stat_local_read(0),op_intrpt_code());   }   if(op_ev_valid(send_CTS_event))   {   	op_ev_cancel(send_CTS_event);   >	op_intrpt_schedule_self(op_sim_time(),SLEEP_FROM_FIRST_CODE);   
	if(debug)   S		printf("Channel is busy, cancel \"send_CTS_event\", go to sleep immediately.\n");   	   }		       J                     
   џџџџ   
          pr_state        о  ў          
   carrier sense(2)   
       J      	if(debug)   L	printf("Node:%d, time:%f. In second period.\n",node_address,op_sim_time());   	if(debug)   {    	printf("НјШы statwire жаЖЯ\n");   ]	printf("down: the received snr=%E.intrpt_code=%d\n",op_stat_local_read(0),op_intrpt_code());   }           if(op_ev_valid(send_RTS_event))   {   	op_ev_cancel(send_RTS_event);   ?	op_intrpt_schedule_self(op_sim_time(),SLEEP_FROM_SECOND_CODE);   
	if(debug)   S		printf("Channel is busy, cancel \"send_RTS_event\", go to sleep immediately.\n");   }   J                     
   џџџџ   
          pr_state          в   в          
   start grade   
       
   
   &//Sink will execute the following code   
grade = 0;   //sink_id = node_address;       )pk_TV = op_pk_create_fmt("MAC_GRADE_PK");   'op_pk_nfd_set(pk_TV, "Type", grade_pk);   +//op_pk_nfd_set(pk_TV, "Sink ID", sink_id);   'op_pk_nfd_set(pk_TV, "Grade", grade+1);       op_pk_send(pk_TV, SEND_STRM);   
                     
   џџџџ   
          pr_state          $                    ­    z            
   tr_1   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition                D          а  :  e  ;          
   tr_28   
       
   CONTEND_TO_SEND_RTS   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition             	    |          `            
   tr_32   
       
   GO_TO_SLEEP   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      "      
     У       {  і   б  g   б          
   tr_34   
       
   WAKING_TO_WAIT_RTS   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition      %   	   
  "       y  q  B  J  B    h   ж          
   tr_37   
       
   	WAKING_UP   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition      (   	     1  ф     i    A  Л  A    d  '          
   tr_40   
       
   WAKING_TO_SEND_RTS   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition      8      	  Э  L                     
   tr_56   
       
   SLEEP_FROM_FIRST   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      9   
     в   №        в              
   tr_57   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      ;        ж         <  (            
   tr_59   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      <        §  [     -  ќ  ъ  Д          
   tr_60   
       
   SEND_RTS   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      =      	  Щ  н     *  љ  }            
   tr_61   
       
   SLEEP_FROM_SECOND   
       
џџџџ   
       
    џџџџ   
       
   џџџџ   
                 
   pr_transition   
   B        ^  x     >  ј  c            
   tr_66   
       
   FROM_LOWER && transceiver_state   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      G        J  X     Z    ;            
   tr_71   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      H          @     @    Ъ  {          
   tr_72   
       
   	SEND_DATA   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition      I          6     Ц  o  D  ў          
   tr_73   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      J        ђ        (   ї  ѕ   `          
   tr_74   
       
   FROM_LOWER && transceiver_state   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      K           А     ь   g     ј          
   tr_75   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      L        W   Е     =   §  i   u          
   tr_76   
       
   SEND_CTS   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      M        H   В     ^   l  /   ј          
   tr_77   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      O           е     <    з             
   tr_79   
       
   SEND_ACK   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      P           в     Ь     <            
   tr_80   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      Y          [     ў    ,            
   tr_89   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      Z        +  G     $      =  L  =  .  "          
   tr_90   
       
   default   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition      [   	   	  v  Р     p    U  З    З              
   tr_91   
       
   default   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition      \        /  Ъ     *  ь    г  S  г  7  ь          
   tr_92   
       
   default   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition      ]               D  
  Ю  	          
   tr_93   
       
   CHECK_CHANNEL   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      ^               У    A            
   tr_94   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      _          ь     A  ё  Ы  ѓ          
   tr_95   
       
   CHECK_CHANNEL   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      `          ќ     Р  џ  C  њ          
   tr_96   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      a         $  2     p  }   е   ц          
   tr_97   
       
   START_GRADE   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      b         2  *      ч   с  z  s          
   tr_98   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      c        F  Ё     n    <    U  Џ  p            
   tr_99   
       
   default   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition      d                 n     Ў          
   tr_100   
       
   SEND_GM   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      e                  Ў    k          
   tr_101   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      f          џ     ~    ~  Z          
   tr_102   
       
   FROM_LOWER && transceiver_state   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      g          §       [              
   tr_103   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      !   l                              
2010-05-18       Fusion of Routing and Mac        