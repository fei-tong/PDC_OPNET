MIL_3_Tfile_Hdr_ 145A 140A modeler 9 50F8D210 514616B0 142 fei-PC fei 0 0 none none 0 0 none E7BDA60F DE2E 0 0 0 0 0 0 1e80 8                                                                                                                                                                                                                                                                                                                                                                                                   ЋЭg      @  н  с  	<  
,  Cє  лл  лп  лу  лч  лѓ  м&  м*  Cш      Start Schedule Timer   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ             Start Grade Timer   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ             Send GM Timer   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ             M    џџџџџџџ    џџџџ           џџџџ          џџџџ          џџџџ           ЅZ             COEF_A    џџџџџџџ    џџџџ           џџџџ          џџџџ          џџџџ           ЅZ                the       
coeffcient       of       	parameter       a   C    џџџџџџџ    џџџџ           џџџџ          џџџџ          џџџџ           ЅZ                Xn+1=(aXn+c)       mod       m   A   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ                sender       wakeup       advance       time   durDATA   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ                duration       for       sending       DATA   	durBEACON   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ                duration       for       sending       BEACON   CW   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ                
Contention       Window   DIFS   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ             SIFS   џџџџџџџ   џџџџ               џџџџ              џџџџ              џџџџ           ЅZ             Debug   џџџџџџџ   џџџџ           џџџџ          џџџџ          џџџџ           ЅZ             	Retx File   џџџџџџџ   џџџџ       џџџџ      џџџџ      џџџџ           ЅZ             Sink Num    џџџџџџџ    џџџџ           џџџџ          џџџџ          џџџџ           ЅZ                    begsim intrpt         
   џџџџ   
   doc file            	nd_module      endsim intrpt         
   џџџџ   
   failure intrpts            disabled      intrpt interval         дВI­%У}џџџџ      priority          
    џџџџ   
   recovery intrpts            disabled      super priority         
   џџџџ   
          priority      priorityџџџџ    џџџџ           џџџџ          џџџџ          џџџџ                        super priority      super priorityџџџџ   џџџџ           џџџџ          џџџџ          џџџџ                     h   Boolean	\Q_empty;       Boolean	\transceiver_state;       
double	\A;       double	\all_active_time;       double	\all_rx_time;       double	\all_sleeped_time;       double	\all_tx_time;       /* Contention Window */   double	\CW;       double	\durBEACON;       double	\durDATA;       double	\record_time;       L/* record the time when the node wakes up for receiving by sending Beacon */   double	\RWaking_time;       double	\send_gm_timer;       double	\start_grade_timer;       double	\start_schedule_timer;       %/* Virtual Waking time of receiver */   double	\VRWaking_time;       Evhandle	\goto_SLEEP_event;       Evhandle	\send_gm_event;       #/* virtual wake to receive event */   #Evhandle	\virtual_to_receive_event;       Evhandle	\wait_DATA_event;        Evhandle	\wake_to_receive_event;       Evhandle	\wake_to_send_event;       int	\ack_next_hop;       int	\c;       0/* the coefficient of parameter "a", e.g., 20 */   int	\coef_a;       int	\grade;       int	\m;       int	\data_next_hop;       int	\node_address;       int	\node_type;       /* Xn */   int	\randState;       List *	\prediction_state_list;       List *	\routing_table_list;       Objid	\node_id;       Objid	\process_id;       Objid	\rx_id;       Evhandle	\send_DATA_event;       Evhandle	\wait_ACK_event;       double	\DIFS;       double	\SIFS;       double	\wakeinterval;       Boolean	\debug;       Evhandle	\send_BEACON_event;       Evhandle	\send_ACK_event;       Objid	\tx_id;       Objid	\tx_channel_objid;       double	\data_rate;       List *	\data_id_list;       int	\range;          Packet* pk_TV=NULL;   Packet* pk_ack_TV=NULL;   int pk_type;   double time;   int dest_TV;   int psFlag_TV;   int grade_TV;   int hop_num_TV;   double CW_TV;   int cur_seed_TV;   double creat_time_TV;   double RWaking_time_TV;   int pk_size;   //File   	FILE *in;   char temp_file_name[300];   //char message[100];   int data_id;       DataID * id_TV;   n   //Define node type   #define sink 	1   #define sensor 	2       //Define packet type   #define grade_pk  1   //#define rts_pk    2   //#define cts_pk    3   //#define ack_pk    4   #define data_pk     5   #define beacon_pk   9       //Define queue type   #define grade_queue		0   #define data_queue		1   #define ack_queue		2       //Define stream in-out NO.   #define SRC_STRM 		1   #define RCV_STRM 		0   #define SEND_STRM 		0   #define DISCARD_STRM 	1       ///Define Prediction State Flag embedded in DATA   #define Request			1   #define noRequest		2       //Define node state   /*   #define initial			0   #define waking			1   &#define awake			2//go to sending state   #define sleeping		3   #define asleep			4   */       5//Define self-interrupt code and transition condition    #define START_GRADE_CODE				1000   #define SEND_GM_CODE					6000   ##define START_SCHEDULE_CODE				7000   %#define WAKING_TO_RECEIVE_CODE			8000   $#define WAKING_TO_SEND_CODE		 		9000   $#define WAIT_DATA_EVENT_CODE			10000    #define SEND_DATA_CODE					20000   #define SEND_ACK_CODE					30000   $#define RECOMPUTE_SEED_CODE				40000   '#define SLEEP_FROM_RECEIVE_CODE 		50000   $#define SLEEP_FROM_SEND_CODE			60000   !#define SEND_BEACON_CODE				70000       B#define END	        		    	(op_intrpt_type() == OPC_INTRPT_ENDSIM)   `#define FROM_LOWER					((op_intrpt_type() == OPC_INTRPT_STRM) && (op_intrpt_strm() == RCV_STRM))   `#define FROM_UPPER					((op_intrpt_type() == OPC_INTRPT_STRM) && (op_intrpt_strm() == SRC_STRM))   i#define START_GRADE					((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == START_GRADE_CODE))   n#define SEND_GM                 	((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SEND_GM_CODE))       n#define START_SCHEDULE				((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == START_SCHEDULE_CODE))   X//#define WAKING_TO_WAIT_RTS			(START_SCHEDULE && grade>=0 && grade%(sleep_factor+2)==0)   Y//#define CONTEND_TO_SEND_RTS			(START_SCHEDULE && grade>=0 && grade%(sleep_factor+2)==1)   S//#define GO_TO_SLEEP					(START_SCHEDULE && grade>=0 && grade%(sleep_factor+2)>=2)       s#define WAKING_TO_RECEIVE			((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == WAKING_TO_RECEIVE_CODE))   n#define WAKING_TO_SEND				((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == WAKING_TO_SEND_CODE))   j#define NO_DATA						((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == WAIT_DATA_EVENT_CODE))   n#define RECOMPUTE_SEED				((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == RECOMPUTE_SEED_CODE))   i#define SEND_BEACON					((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SEND_BEACON_CODE))   e#define SEND_DATA					((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SEND_DATA_CODE))   e//#define SEND_CTS					((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SEND_CTS_CODE))   c#define SEND_ACK					((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SEND_ACK_CODE))   u#define SLEEP_FROM_RECEIVE			((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SLEEP_FROM_RECEIVE_CODE))   p#define SLEEP_FROM_SEND				((op_intrpt_type() == OPC_INTRPT_SELF) && (op_intrpt_code() == SLEEP_FROM_SEND_CODE))   @#define CHECK_CHANNEL				((op_intrpt_type() == OPC_INTRPT_STAT))       typedef struct   {   	int rt_next_hop;   	int rt_grade;   }RoutingTable;       typedef struct   {   	int ps_id;//node address of R   "	int ps_rs;//randState[R], 2 bytes   *	double ps_td;//timeDifference[R], 4 bytes   A	double ps_next_wt;//last wakeup time: nextWakeupTime[R], 4 bytes   	double ps_lastupdate;//denotes the time S received the prediction state from R, which is used to compute Td, the prediction error caused by clock drift   }PredictionState;       typedef struct   {   	int st_data_id;   }DataID;           //function prototype   %static Boolean data_id_exist(int id);   'static void grade_pk_proc(Packet * pk);   static int RandNum(int,int);   +static PredictionState * find_R_in_ps(int);   %static void upper_data_pk_proc(void);   static void power_stat(void);   static void record_grade(void);   (static double compute_wakeup_time(void);       *int retx=0; //the number of retransmission   int data_nums_1 = 0;   $double avg_energy_consumption = 0.0;   double avg_duty_cycle=0.0;       //int data_nums = 0;  ;   6void update_routing_table(int node_hop,int node_grade)   {   	RoutingTable *rt;   8	FIN(update_routing_table(int node_hop,int node_grade));   	   =	rt = (RoutingTable *)op_prg_mem_alloc(sizeof(RoutingTable));   	rt->rt_next_hop = node_hop;   	rt->rt_grade = node_grade;   <	op_prg_list_insert(routing_table_list,rt,OPC_LISTPOS_TAIL);   	   	FOUT;   }       //Deal with grade pk   static void   grade_pk_proc(Packet * pk)   {   //var   *	int pre_hop,grade_in_pk;//,sink_id_in_pk;   //in   	FIN(grade_pk_proc(pk));   //body   (	op_pk_nfd_get(pk,"Grade",&grade_in_pk);   +	op_pk_nfd_get(pk,"Previous Hop",&pre_hop);   .	//op_pk_nfd_get(pk,"Sink ID",&sink_id_in_pk);   	   	if(grade<0)   	{   		grade = grade_in_pk;   		//sink_id = sink_id_in_pk;   		   .		update_routing_table(pre_hop,grade_in_pk-1);   		   		++grade_in_pk;   (		op_pk_nfd_set(pk,"Grade",grade_in_pk);   0		op_pk_nfd_set(pk,"Previous Hop",node_address);   		   (		//cancel the previous event if pending    		if(op_ev_valid(send_gm_event))   		{   			op_ev_cancel(send_gm_event);   		}   '		//at the same time, clear grade_queue   -		if(op_subq_empty(grade_queue) == OPC_FALSE)   		{   			op_subq_flush(grade_queue);   		}   		   3		op_subq_pk_insert (grade_queue,pk,OPC_QPOS_TAIL);   n		//send_gm_event = op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(send_gm_timer), SEND_GM_CODE);   		if(node_address%2==0)   		{	   q			send_gm_event = op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(send_gm_timer)+0.5, SEND_GM_CODE);   		}else{   q			send_gm_event = op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(send_gm_timer)+0.1, SEND_GM_CODE);   		}   		   		FOUT;   	}   	   	if(grade_in_pk < grade)   	{   		grade = grade_in_pk;    		//if(sink_id != sink_id_in_pk)   		//{   		//	sink_id = sink_id_in_pk;   		//}   '		op_prg_list_free(routing_table_list);   .		update_routing_table(pre_hop,grade_in_pk-1);   		   		++grade_in_pk;   (		op_pk_nfd_set(pk,"Grade",grade_in_pk);   0		op_pk_nfd_set(pk,"Previous Hop",node_address);   		   (		//cancel the previous event if pending    		if(op_ev_valid(send_gm_event))   		{   			op_ev_cancel(send_gm_event);   		}   '		//at the same time, clear grade_queue   -		if(op_subq_empty(grade_queue) == OPC_FALSE)   		{   			op_subq_flush(grade_queue);   		}   		   3		op_subq_pk_insert (grade_queue,pk,OPC_QPOS_TAIL);   n		//send_gm_event = op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(send_gm_timer), SEND_GM_CODE);   		if(node_address%2==0)   		{	   q			send_gm_event = op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(send_gm_timer)+0.5, SEND_GM_CODE);   		}else{   q			send_gm_event = op_intrpt_schedule_self(op_sim_time() + op_dist_exponential(send_gm_timer)+0.1, SEND_GM_CODE);   		}   		   		FOUT;   	}   	   	if(grade_in_pk == grade)   	{   0		update_routing_table(pre_hop,grade_in_pk-1);		   	}   	   	op_pk_destroy(pk);   	   //out   	FOUT;   }       Cstatic double compute_wakeup_time(void)//Compute Sender Wakeup Time   {   //var    	PredictionState * func_ps=NULL;   	double curTime;   	int i,ps_size;   //in    	FIN(compute_wakeup_time(void));   //body   1	ps_size=op_prg_list_size(prediction_state_list);   	if(ps_size>0)   	{   ?		i = op_dist_outcome(op_dist_load("uniform_int",0,ps_size-1));   8		func_ps = op_prg_list_access(prediction_state_list,i);   		   !		//compute the current time of R   @		curTime=op_sim_time();//-func_ps->ps_td;//curTime[R]=localTime   		   F		//if next wakeup time of S for sending to R has been computed before   !		if(func_ps->ps_next_wt>curTime)   		{   %			FRET(func_ps->ps_next_wt-curTime);   		}   		   &		while(func_ps->ps_next_wt<=curTime){   9			func_ps->ps_rs=RandNum(func_ps->ps_rs,func_ps->ps_id);   .			func_ps->ps_next_wt+=func_ps->ps_rs/1000.0;   		}   		   $		if(func_ps->ps_next_wt>(curTime)){   '			FRET(func_ps->ps_next_wt-(curTime));   		}else{   			FRET(0.0);   		}   	}   //out   !	FRET(0.0);//wakeup now to wait R   }       D//find R(R_id) in prediction state table to get its prediction state   /static PredictionState * find_R_in_ps(int R_id)   {   //var    	PredictionState * func_ps=NULL;   	int i,ps_size;   //in   	FIN(find_R_in_ps(int));   //body   1	ps_size=op_prg_list_size(prediction_state_list);   	for(i=0;i<ps_size;i++)   	{   I		func_ps=(PredictionState *)op_prg_list_access(prediction_state_list,i);   		if(func_ps->ps_id==R_id)   				break;   	}   //out   	FRET(func_ps);   }        //Received DATA from upper layer   static void    upper_data_pk_proc(void)   {   //var   	Packet* upper_pk;   //in   	FIN(upper_data_pk_proc());   //body    	upper_pk = op_pk_get(SRC_STRM);   (	op_pk_nfd_set(upper_pk,"Type",data_pk);   ,	op_pk_nfd_set(upper_pk,"Src",node_address);   1	op_pk_nfd_set(upper_pk,"Grade",grade);//for test   	   7	op_subq_pk_insert (data_queue,upper_pk,OPC_QPOS_TAIL);   	   
	if(debug)   K	printf("Have inserted the received DATA from \"gsrc\" into DATA queue\n");   //out   	FOUT;   }       )//In "end" state, proceed power statistic   static void   power_stat(void)   {   //var   
	FILE *in;   	char temp_file_name[300];   	int nodes_num,sink_num;   //in   	FIN(power_stat(void));   //vody   A	op_ima_obj_attr_get(node_id,"Power Record File",temp_file_name);   (	if(strcmp(temp_file_name,"disable")!=0)   	{	   		avg_energy_consumption += all_sleeped_time*0.05+(all_active_time-(all_tx_time+all_rx_time))*0.45+(all_tx_time+all_rx_time)*0.5;   G		avg_duty_cycle += all_active_time/(all_sleeped_time+all_active_time);   7		nodes_num = op_topo_object_count (OPC_OBJTYPE_NDMOB);   8		op_ima_obj_attr_get(process_id, "Sink Num",&sink_num);   )		if(node_address == nodes_num-sink_num){   #			in = fopen(temp_file_name,"at");   	   ы			//fprintf(in,"%d %f %f %f\r\n",node_address,all_sleeped_time*0.05+(all_active_time-(all_tx_time+all_rx_time))*0.45+(all_tx_time+all_rx_time)*0.5,all_active_time/(all_sleeped_time+all_active_time),(all_sleeped_time+all_active_time));   			   			fprintf(in,"%d %f %f %d\r\n",node_address,avg_energy_consumption/(nodes_num*(all_sleeped_time+all_active_time)),(avg_duty_cycle/nodes_num)*100,nodes_num);   		   			fclose(in);   		}   	}	   //out   	FOUT;   }               ?static int RandNum(int rs,int id)//rs: randState[R],id: node ID   {   //var   	int func_rs;   //in   	FIN(RandNum(int,int));   //body   "	func_rs=((id*coef_a+1)*rs+c) % m;   /	while(func_rs<500 || func_rs>1500)//(500~1500)   	{   (		func_rs=((id*coef_a+1)*func_rs+c) % m;   	}   //out   	FRET(func_rs);   }       static void record_grade(void)   {   //var   	//int i,rt_size;   	//RoutingTable* rt;   	FILE *file_in;   	char file_name[300];   //in   	FIN(record_grade(void));   //body   <	op_ima_obj_attr_get(node_id,"Grade Record File",file_name);   	   !	file_in = fopen(file_name,"at");   	fprintf(file_in,"%d	%d\r\n",\   		node_address,grade);   	/*   0	rt_size = op_prg_list_size(routing_table_list);   	for(i=0;i<rt_size;i++)   	{   @		rt = (RoutingTable *)op_prg_list_access(routing_table_list,i);   -		fprintf(file_in,"    %d, МЖБ№ЪЧ:%d. \r\n",\   "			rt->rt_next_hop, rt->rt_grade);   	}   	fprintf(file_in,"\r\n");   	*/   	fclose(file_in);   	   (	if(node_type==sink && node_address==-1)   	{   8		op_ima_obj_attr_get(process_id,"Retx File",file_name);   "		file_in = fopen(file_name,"at");   "		fprintf(file_in,"%d	%d %f\r\n",\   5		retx,data_nums_1,(double)retx/(double)data_nums_1);   		fclose(file_in);   	}   //out   	FOUT;   }       int rt_pos_find_next()   {   	RoutingTable* rt;   	int i,rt_size;   	       FIN(rt_find_next());   	   0	rt_size = op_prg_list_size(routing_table_list);   	if(rt_size>0)   	{   ?		i = op_dist_outcome(op_dist_load("uniform_int",0,rt_size-1));   0		rt = op_prg_list_access(routing_table_list,i);   		FRET(rt->rt_next_hop);   	}   
	FRET(-1);   }       $static Boolean data_id_exist(int id)   {   //var   	int i,list_size;   	DataID* ID;   	Boolean flag=OPC_FALSE;   //in   	FIN(data_id_exist(int id));   //body   *	list_size=op_prg_list_size(data_id_list);   	for(i=0;i<list_size;i++){   2		ID=(DataID *)op_prg_list_access(data_id_list,i);   		if(ID->st_data_id==id){   			flag=OPC_TRUE;   				break;   		}   	}   //out   	FRET(flag);   }                                          Z            
   init   
       J   \   // Obtain related ID   process_id = op_id_self();   &node_id = op_topo_parent(process_id);   mrx_id = op_id_from_name(node_id,OPC_OBJTYPE_RARX,"rx");//the name of receiver radio in node layer called "rx"   ntx_id = op_id_from_name(node_id,OPC_OBJTYPE_RATX ,"tx");//the name of receiver radio in node layer called "tx"       $//obtain tx channel of compound type   ?op_ima_obj_attr_get_objid (tx_id, "channel",&tx_channel_objid);       Ktx_channel_objid = op_topo_child (tx_channel_objid, OPC_OBJTYPE_RATXCH, 0);   =op_ima_obj_attr_get(tx_channel_objid,"data rate",&data_rate);       0op_ima_obj_attr_get(process_id, "Debug",&debug);       	if(debug)   $	printf("data_rate=%f\n",data_rate);       *pk_TV = op_pk_create_fmt("MAC_BEACON_PK");   $pk_size=op_pk_total_size_get(pk_TV);   !durBEACON=(pk_size+10)/data_rate;   op_pk_destroy(pk_TV);   	if(debug)   $	printf("durBEACON=%f\n",durBEACON);       (pk_TV = op_pk_create_fmt("MAC_DATA_PK");   $pk_size=op_pk_total_size_get(pk_TV);   durDATA=(pk_size+10)/data_rate;   op_pk_destroy(pk_TV);   	if(debug)    	printf("durDATA=%f\n",durDATA);       //obtain parameter   Nop_ima_obj_attr_get(process_id, "Start Grade Timer", &start_grade_timer);		//1   Hop_ima_obj_attr_get(process_id, "Send GM Timer", &send_gm_timer);				//2   Sop_ima_obj_attr_get(process_id, "Start Schedule Timer", &start_schedule_timer);	//3   6//op_ima_obj_attr_get(process_id, "durDATA",&durDATA);   ://op_ima_obj_attr_get(process_id, "durBEACON",&durBEACON);   2op_ima_obj_attr_get(process_id, "COEF_A",&coef_a);   (op_ima_obj_attr_get(process_id, "C",&c);   (op_ima_obj_attr_get(process_id, "M",&m);   (op_ima_obj_attr_get(process_id, "A",&A);           I//op_ima_obj_attr_get(process_id, "Sleep Factor", &sleep_factor);					//4   9//op_ima_obj_attr_get(process_id, "CW",&CW);										//5   ?//op_ima_obj_attr_get(process_id, "durRTS",&durRTS);								//6   ?//op_ima_obj_attr_get(process_id, "durCTS",&durCTS);								//7   @//op_ima_obj_attr_get(process_id, "durDATA",&durDATA);							//8   ?//op_ima_obj_attr_get(process_id, "durACK",&durACK);								//9   ;op_ima_obj_attr_get(process_id, "DIFS",&DIFS);									//10   ;op_ima_obj_attr_get(process_id, "SIFS",&SIFS);									//11       7op_ima_obj_attr_get(node_id, "user id", &node_address);   5op_ima_obj_attr_get(node_id, "Node Type",&node_type);       @//op_ima_obj_attr_get(process_id, "Communication Range",&range);   <//op_ima_obj_attr_set(node_id, "Communication Range",range);       8op_ima_obj_attr_get(rx_id, "state", &transceiver_state);           +prediction_state_list=op_prg_list_create();   (routing_table_list=op_prg_list_create();   "data_id_list=op_prg_list_create();       grade = -1;   //sink_id = -1;       all_sleeped_time = 0;   all_active_time = 0;   all_tx_time = 0;   all_rx_time = 0;       //data_nums=0;   M//durActive contains two parts: durReceive & durSedn, and durReceive==durSend   C//durActive_half = 2*CW+durRTS+durCTS+durDATA+durACK+2*DIFS+2*SIFS;   +//durSleep = sleep_factor * durActive_half;   if(node_type == sink)   {   	if(node_address==-1)   	{   N		op_intrpt_schedule_self(op_sim_time() + start_grade_timer,START_GRADE_CODE);   	}else{   S		op_intrpt_schedule_self(op_sim_time() + start_grade_timer+1.0, START_GRADE_CODE);   	}   }	       Sop_intrpt_schedule_self(op_sim_time() + start_schedule_timer, START_SCHEDULE_CODE);       <//op_ima_obj_attr_get (process_id, "subqueue", &subq_objid);   A//num_subqs = op_topo_child_count (subq_objid, OPC_OBJTYPE_SUBQ);   &//printf("згЖгСаИіЪ§:%d\n",num_subqs);   J       
      /*   @op_ima_obj_attr_get(node_id,"Grade Record File",temp_file_name);   remove(temp_file_name);   7op_ima_obj_attr_get(node_id,"Log File",temp_file_name);   remove(temp_file_name);   */   if(node_type == sink)   {   8	op_ima_obj_attr_get(node_id,"Log File",temp_file_name);   !	in = fopen(temp_file_name,"at");   	   n	//fprintf(in,"Begin:\r\ndurActive_half: %f, durSleep: %f. cycle time: (%d+2)*%f=%f.(in \"gmac->init\")\r\n",\   Y	//	durActive_half,durSleep,sleep_factor,durActive_half,(sleep_factor+2)*durActive_half);   $	//fprintf(in,"duty cycle:%f.\r\n",\   3	//		durActive_half*2/(durActive_half*2+durSleep));   	fclose(in);   }   /*   'if(strcmp(temp_file_name,"disable")!=0)   {	   5	printf("Node:%d, ДЫНкЕуПЩВњЩњМЧТМ.\n",node_address);   !	in = fopen(temp_file_name,"at");   ;	fprintf(in,"Simulation_time		Average_power_consumed\r\n");   	fclose(in);   }   */   
       
   џџџџ   
          pr_state        J            
   idle_0   
       
       //Received DATA from upper layer   if(FROM_UPPER)   {   
	if(debug)   X	printf("Node:%d, time:%f. In \"idle\" state: received DATA which is from \"gsrc\".\n",\   			node_address,op_sim_time());   	upper_data_pk_proc();   }       if(END)   {   	record_grade();   	//time statistic   	//op_prg_list_free (NAV_list);   	//op_prg_mem_free (NAV_list);   	   '	op_prg_list_free (routing_table_list);   &	op_prg_mem_free (routing_table_list);   	   *	op_prg_list_free (prediction_state_list);   )	op_prg_mem_free (prediction_state_list);   	   !	op_prg_list_free (data_id_list);    	op_prg_mem_free (data_id_list);   }   
       
      !if(START_SCHEDULE) //start PW_MAC   {   A	randState=op_dist_outcome(op_dist_load("uniform_int",500,1500));    	wakeinterval= randState/1000.0;   	record_time = op_sim_time();   	   D	if(op_subq_empty(data_queue) == OPC_FALSE)//data queue is not empty   	{   		Q_empty=OPC_FALSE;   ?		VRWaking_time=op_sim_time();//virtual Waking time of receiver   e		virtual_to_receive_event=op_intrpt_schedule_self(op_sim_time() + wakeinterval,RECOMPUTE_SEED_CODE);   		   		if(debug)   т			printf("Node:%d, Grade:%d, time:%f,in idle_0. Data queue is not empty.\nGoing to SWaking From START_SCHEDULE && ! Q_empty.\nSet virtual_to_receive_event (wakeinterval=%f).\n", node_address,grade,op_sim_time(),wakeinterval);   	}   '	else//data queue is empty, go to sleep   	{   		Q_empty=OPC_TRUE;   		RWaking_time=op_sim_time();   i	    wake_to_receive_event=op_intrpt_schedule_self(op_sim_time() + wakeinterval, WAKING_TO_RECEIVE_CODE);   		   		if(debug)    		printf("Node:%d, Grade:%d, time:%f,in idle_0. Data queue is empty.\nGoing to sleeping From START_SCHEDULE && Q_empty.\nAfter %f seconds, wake to receive.\n",\   2			node_address,grade,op_sim_time(),wakeinterval);   	}   	   }   
           џџџџ             pr_state            в          
   start grade   
       
      &//Sink will execute the following code   
grade = 0;   //sink_id = node_address;       )pk_TV = op_pk_create_fmt("MAC_GRADE_PK");   'op_pk_nfd_set(pk_TV, "Type", grade_pk);   +//op_pk_nfd_set(pk_TV, "Sink ID", sink_id);   'op_pk_nfd_set(pk_TV, "Grade", grade+1);   1op_pk_nfd_set(pk_TV,"Previous Hop",node_address);       op_pk_send(pk_TV, SEND_STRM);   
                     
   џџџџ   
          pr_state        J  v          
   GM proc   
       
      pk_TV = op_pk_get(RCV_STRM);   %op_pk_nfd_get(pk_TV,"Type",&pk_type);   if(pk_type == grade_pk)   {   	grade_pk_proc(pk_TV);   }   else   {   	op_pk_destroy(pk_TV);   g	op_sim_end("Waiting Grade Message Err: Are you kidding me?","I'm waiting Grade Message","Not you","");       }   
                     
   џџџџ   
          pr_state        J             
   send gm   
       
   	   +if(op_subq_empty(grade_queue) == OPC_FALSE)   {   7	pk_TV = op_subq_pk_remove(grade_queue, OPC_QPOS_HEAD);   	op_pk_send(pk_TV,SEND_STRM);   }   else   {   E	op_sim_end("Err: ack queue is empty, simulation is over!","","","");   }   
                     
   џџџџ   
          pr_state        v            
   sleeping   
       
   Ѓ   //close transceiver   transceiver_state = OPC_FALSE;   7op_ima_obj_attr_set(rx_id, "state", transceiver_state);       2if(START_SCHEDULE && Q_empty)//data queue is empty   {   $	CW=0;//initialize Contention Window   C	//randState=op_dist_outcome(op_dist_load("uniform_int",500,1500));   "	//wakeinterval= randState/1000.0;   g	//wake_to_receive_event=op_intrpt_schedule_self(op_sim_time() + wakeinterval, WAKING_TO_RECEIVE_CODE);   <	//printf("Node:%d, Grade:%d, time:%f,in sleeping period.\n\   ;	//		Initial to sleeping From START_SCHEDULE && Q_empty.\n\   ,	//		After %f seconds, wake to receive.\n",\   4	//		node_address,grade,op_sim_time(),wakeinterval);   }else   	   )if(SLEEP_FROM_RECEIVE){//check data queue    	wakeinterval= randState/1000.0;   .	time=RWaking_time+wakeinterval-op_sim_time();   	   /	if(op_ev_valid(wake_to_receive_event)){//error   r		    op_sim_end("ЗТецГіДэ","In sleeping state (SLEEP_FROM_RECEIVE):","ЧыЗДЫМ","wake_to_receive_event гІЮЊЮоаЇ!");   )			op_ev_cancel(wake_to_receive_event);		   	}   ]	wake_to_receive_event=op_intrpt_schedule_self(op_sim_time() + time, WAKING_TO_RECEIVE_CODE);   	   
	if(debug)   		printf("Node:%d, Grade:%d, time:%f,in sleeping period.\nTo sleeping from RECEIVE.\nCheck data queue.\n",node_address,grade,op_sim_time());   	//check data queue   E	if(op_subq_empty(data_queue) == OPC_FALSE){//data queue is not empty   	   >		op_ev_cancel(wake_to_receive_event);//won't be as a receiver    		//still need to calculate seed   !		wakeinterval= randState/1000.0;   /		time=RWaking_time+wakeinterval-op_sim_time();   		VRWaking_time=RWaking_time;   ]		virtual_to_receive_event=op_intrpt_schedule_self(op_sim_time() + time,RECOMPUTE_SEED_CODE);   			   		time=compute_wakeup_time();   		if(time-A<0){   
			time=0;   		}else{   			time=time-A;   		}   X		wake_to_send_event=op_intrpt_schedule_self(op_sim_time() + time, WAKING_TO_SEND_CODE);   		   		if(debug)   			printf("Data queue is not empty. Set virtual_to_receive_event.\nAfter %f seconds, wake to send (time:%f).\n",time,op_sim_time()+time);   	}else{//data queue is empty   		if(debug)   			printf("Data queue is empty. Set wake_to_receive_event. \nAfter %f seconds, wake to receive (time:%f).\n",time,op_sim_time()+time);   	}   	   	//time statistic   ?	all_active_time = all_active_time+(op_sim_time()-record_time);   	record_time = op_sim_time();   	   }else   if(SLEEP_FROM_SEND){   	//check data queue   E	if(op_subq_empty(data_queue) == OPC_FALSE){//data queue is not empty   		time=compute_wakeup_time();   		if(time-A<0){   
			time=0;   		}else{   			time=time-A;   		}   X		wake_to_send_event=op_intrpt_schedule_self(op_sim_time() + time, WAKING_TO_SEND_CODE);   		   		if(debug)   к			printf("Node:%d, Grade:%d, time:%f,in sleeping period.\nTo sleeping from SEND. Data Queue is still not empty.\nAfter %f seconds, wake to send (time: %f).\n",node_address,grade,op_sim_time(),time,op_sim_time()+time);   		   5	}else{//data queue is empty, wakeup to as a receiver   ,		if(op_ev_valid(virtual_to_receive_event)){   *			op_ev_cancel(virtual_to_receive_event);   "			wakeinterval= randState/1000.0;   1			time=VRWaking_time+wakeinterval-op_sim_time();   			RWaking_time=VRWaking_time;   			   _			wake_to_receive_event=op_intrpt_schedule_self(op_sim_time() + time, WAKING_TO_RECEIVE_CODE);   			   			if(debug)   			printf("Node:%d, Grade:%d, time:%f,in sleeping period.\nTo sleeping from SEND. Data Queue is empty.\nAfter %f seconds, wake to receive.\n",\   +				node_address,grade,op_sim_time(),time);   		}else{   p			op_sim_end("ЗТецГіДэ","In sleeping state (SLEEP_FROM_SEND): virtual_to_receive_event вьГЃЪЇаЇ!","ЧыЗДЫМ","");   		}   	}   	   	//time statistic   ?	all_active_time = all_active_time+(op_sim_time()-record_time);   	record_time = op_sim_time();   }            //Received DATA from upper layer   if(FROM_UPPER)   {   
	if(debug)   	printf("1--Node: %d,Grade:%d. time=%f. In \"sleeping\" state (FROM_UPPER): received DATA which is from \"gsrc\".\n",node_address,grade,op_sim_time());   	upper_data_pk_proc();   	   	//will wake up to receive   G	if(op_ev_valid(wake_to_receive_event))//cancel WAKING_TO_RECEIVE event   	{   &		op_ev_cancel(wake_to_receive_event);    		//still need to calculate seed   !		wakeinterval= randState/1000.0;   1		time = RWaking_time+wakeinterval-op_sim_time();   		VRWaking_time=RWaking_time;   ]		virtual_to_receive_event=op_intrpt_schedule_self(op_sim_time() + time,RECOMPUTE_SEED_CODE);   		if(debug)   Х			printf("2--randState=%d, cancel wake_to_receive_event.\nSet virtual_to_receive_event.\n After time=%f seconds, set next virtual_to_receive_event (time: %f)\n",randState,time,op_sim_time()+time);   		   '		if(!op_ev_valid(wake_to_send_event)){   			    			time = compute_wakeup_time();   			if(time-A<0){   				time=0;   				}else{   				time=time-A;   			}   			   Y			wake_to_send_event=op_intrpt_schedule_self(op_sim_time() + time, WAKING_TO_SEND_CODE);   			if(debug)   				printf("3--Set wake_to_send_event.\n After time=%f seconds, go to RWakint state to send data(time: %f)\n",time,op_sim_time()+time);       			   		}else{   			op_sim_end("ЗТецГіДэ","In sleeping state (FROM_UPPER):","ЧыЗДЫМ","wake_to_receive_event КЭ wake_to_send_eventВЛПЩФмЭЌЪБгааЇ!");   		}   ,	}else if(!op_ev_valid(wake_to_send_event)){   		   		op_sim_end("ЗТецГіДэ","In sleeping state (FROM_UPPER):","ЧыЗДЫМ","wake_to_receive_eventвбО­ЮоаЇЃЌФЧУДwake_to_send_eventгІИУЮЊгааЇ!");   	}   	   }       $if(FROM_LOWER && !transceiver_state)   {   $	op_pk_destroy(op_pk_get(RCV_STRM));   	   
	if(debug)   J	printf("Node:%d, time:%f. Node is sleeping, destroy the received pk.\n",\   			node_address,op_sim_time());   }   if(END)   {       	//time statistic   C	all_sleeped_time = all_sleeped_time + (op_sim_time()-record_time);   	power_stat();   	record_grade();   	   '	op_prg_list_free (routing_table_list);   &	op_prg_mem_free (routing_table_list);   	   *	op_prg_list_free (prediction_state_list);   )	op_prg_mem_free (prediction_state_list);   	   !	op_prg_list_free (data_id_list);    	op_prg_mem_free (data_id_list);   }   
                         џџџџ             pr_state        ў            
   SWaking   
       
      //enable transceiver   
if(debug){   	if(START_SCHEDULE)   ф		printf("Node:%d, Grade:%d, time:%f,in SWaking state from idle_0.\nFor sending data since data queue is not empty.\nAfter open transceiver, go to idle1 for waiting for Beacon.\n",	node_address,grade,op_sim_time(),wakeinterval);   	else if(WAKING_TO_SEND)   ц		printf("Node:%d, Grade:%d, time:%f,in SWaking state from sleeping.\nFor sending data since data queue is not empty.\nAfter open transceiver, go to idle1 for waiting for Beacon.\n",	node_address,grade,op_sim_time(),wakeinterval);   }   transceiver_state = OPC_TRUE;   7op_ima_obj_attr_set(rx_id, "state", transceiver_state);       //time statistic   Dall_sleeped_time = all_sleeped_time + (op_sim_time() - record_time);   record_time = op_sim_time();   
                     
   џџџџ   
          pr_state        v             
   idle1   
       
       //Received DATA from upper layer   if(FROM_UPPER)   {   
	if(debug)   		printf("Node:%d, Grade:%d, time:%f,In \"idle1\" state: received DATA which is from \"gsrc\".\n",node_address,grade,op_sim_time());       	upper_data_pk_proc();   }       if(END)   {       	//time statistic   ?	all_active_time = all_active_time+(op_sim_time()-record_time);   	power_stat();   	record_grade();   	   '	op_prg_list_free (routing_table_list);   &	op_prg_mem_free (routing_table_list);   	   *	op_prg_list_free (prediction_state_list);   )	op_prg_mem_free (prediction_state_list);   	   !	op_prg_list_free (data_id_list);    	op_prg_mem_free (data_id_list);   }   
                         џџџџ             pr_state      	  ў  ў          
   RWaking   
       
      //enable transceiver   transceiver_state = OPC_TRUE;   7op_ima_obj_attr_set(rx_id, "state", transceiver_state);   RWaking_time=op_sim_time();       ///the node is awake in the current duty cycle.    //compute the current interval   *randState=RandNum(randState,node_address);   wakeinterval=randState/1000.0;   _goto_SLEEP_event=op_intrpt_schedule_self(op_sim_time() + wakeinterval,SLEEP_FROM_RECEIVE_CODE);               
time=SIFS;   Qsend_BEACON_event = op_intrpt_schedule_self(op_sim_time()+time,SEND_BEACON_CODE);       	if(debug)   Й	printf("Node:%d, Grade:%d, time:%f,Waking to receive. Waiting SIFS to send Beacon First.\nThe current wakeup interval is %f seconds.\n", node_address,grade,op_sim_time(),wakeinterval);       //time statistic   Ball_sleeped_time = all_sleeped_time + (op_sim_time()-record_time);   record_time = op_sim_time();   
                     
   џџџџ   
          pr_state      
  v  v          
   idle2   
       
       //Received DATA from upper layer   if(FROM_UPPER)   {   
	if(debug)   		printf("Node:%d, Grade:%d, time:%f, In \"idle2\" state: received DATA which is from \"gsrc\".\n",node_address, grade, op_sim_time());   	upper_data_pk_proc();   }       if(END)   {       	//time statistic   A	all_active_time = all_active_time + (op_sim_time()-record_time);   	power_stat();   	record_grade();   	   '	op_prg_list_free (routing_table_list);   &	op_prg_mem_free (routing_table_list);   	   *	op_prg_list_free (prediction_state_list);   )	op_prg_mem_free (prediction_state_list);   	   !	op_prg_list_free (data_id_list);    	op_prg_mem_free (data_id_list);   }   
                         џџџџ             pr_state        ў  ю          
   NO_DATA   
       
      ,//op_ima_obj_attr_get(process_id, "CW",&CW);       !//First cancel previous set timer   "if(op_ev_valid(goto_SLEEP_event)){    	op_ev_cancel(goto_SLEEP_event);   
	if(debug)   		printf("1--Node:%d, Grade:%d, time:%f,in NO_DATA state from idle2.\nCancel goto_SLEEP_event.\n",node_address,grade,op_sim_time());   }   	if(debug)   	printf("2--Node:%d, Grade:%d, time:%f,in NO_DATA state from idle2.\nGo to sleep immediately.\n",node_address,grade,op_sim_time());   //Then go to sleep right now   Eop_intrpt_schedule_self(op_sim_time() + 0.0,SLEEP_FROM_RECEIVE_CODE);   
                     
   џџџџ   
          pr_state        ю  ю          
   RcvData   
       
      if(pk_TV!=NULL)   {   	op_pk_destroy(pk_TV);   }       pk_TV = op_pk_get(RCV_STRM);       $pk_size=op_pk_total_size_get(pk_TV);   time=(pk_size+10)/data_rate;   //time statistic   !all_rx_time = all_rx_time + time;       	if(debug)   Ё	printf("At The Receiver, Node:%d, Grade:%d, time:%f.\nReceived a packet, size: %d.\nReceive Duration is: %f.\n",	node_address,grade,op_sim_time(),pk_size,time);       %op_pk_nfd_get(pk_TV,"Type",&pk_type);       <//will cancel wait_data_event here if receiving desired DATA   ///and reply with ACK: also a BEACON immediately   //Then go to sleep   //write now       .if(pk_type == data_pk){//receive a data packet   *	op_pk_nfd_get(pk_TV,"Next Hop",&dest_TV);   K	if(dest_TV == node_address){//the data is the desired one for the receiver   #		if(op_ev_valid(wait_DATA_event)){   !			op_ev_cancel(wait_DATA_event);   5			op_pk_nfd_get(pk_TV,"Previous Hop",&ack_next_hop);   			   /			op_pk_nfd_get(pk_TV,"Hop Num", &hop_num_TV);   			hop_num_TV++;   -			op_pk_nfd_set(pk_TV,"Hop Num",hop_num_TV);   .			op_pk_nfd_get(pk_TV,"PS Flag", &psFlag_TV);   			   			//for test   +			op_pk_nfd_get(pk_TV,"Grade", &grade_TV);   			if(grade_TV!=grade+1){   6				printf("grade_TV=%d, grade=%d.\n",grade_TV,grade);   Q				op_sim_end("ЗТецГіДэ","the received data is from a lower grade","ЧыЗДЫМ","");   			}   &			op_pk_nfd_set(pk_TV,"Grade",grade);   			   			if(node_type == sink){   ,				op_pk_nfd_get(pk_TV,"Data No",&data_id);    				if(!data_id_exist(data_id)){   6					id_TV=(DataID *)op_prg_mem_alloc(sizeof(DataID));   					id_TV->st_data_id=data_id;   =					op_prg_list_insert(data_id_list,id_TV,OPC_LISTPOS_TAIL);   					data_nums_1++;   				}   #				op_pk_send(pk_TV,DISCARD_STRM);   .				//printf("Data has arrived at sink!!!\n");   				}else{   ,				//insert the DATA packet into data_queue   7				op_subq_pk_insert (data_queue,pk_TV,OPC_QPOS_TAIL);   			}   			   &			//reply a BEACON as ACK immediately   			//send BEACON   			//printf("test1!!!\n");   			if(pk_ack_TV!=NULL){   				op_pk_destroy(pk_ack_TV);   			}   			//printf("test2!!!\n");   			if(debug)   				printf("The Receiver, Node:%d, Grade:%d, time:%f.\nSuccessfully received DATA.\nReply ACK Beacon after SIFS time.\n",	node_address,grade,op_sim_time());   			   1			pk_ack_TV = op_pk_create_fmt("MAC_BEACON_PK");   /			op_pk_nfd_set(pk_ack_TV, "Type", beacon_pk);   0			op_pk_nfd_set(pk_ack_TV,"Src", node_address);   0			op_pk_nfd_set(pk_ack_TV,"Dest",ack_next_hop);   *			op_pk_nfd_set(pk_ack_TV,"Grade",grade);   			   ?			//if the sender has no request for the state of the receiver   0			op_pk_nfd_set(pk_ack_TV,"Current Seed",-1.0);   /			op_pk_nfd_set(pk_ack_TV,"Create Time",-1.0);   /			op_pk_nfd_set(pk_ack_TV,"Waking Time",-1.0);   						   			   P			if(psFlag_TV==Request){//the sender has request for the state of the receiver   6				op_pk_nfd_set(pk_ack_TV,"Current Seed",randState);   9				op_pk_nfd_set(pk_ack_TV,"Create Time",op_sim_time());   8				op_pk_nfd_set(pk_ack_TV,"Waking Time",RWaking_time);   				if(debug)   ,					printf("Embedded prediction state.\n");   			}   			   			   			CW=0;//set CW to zero   9			op_subq_pk_insert (ack_queue,pk_ack_TV,OPC_QPOS_TAIL);   			time=SIFS;   L			send_ACK_event=op_intrpt_schedule_self(op_sim_time()+time,SEND_ACK_CODE);   %			//op_pk_send(pk_ack_TV,SEND_STRM);   			   $			//First cancel previous set timer   %			if(op_ev_valid(goto_SLEEP_event)){   #				op_ev_cancel(goto_SLEEP_event);   			}   %			//go to sleep after durBEACON time   S			op_intrpt_schedule_self(op_sim_time() + SIFS+durBEACON,SLEEP_FROM_RECEIVE_CODE);   			   *		}else{//wait_DATA_event has been invalid   			op_pk_destroy(pk_TV);   			   			if(debug)   			printf("Error:\n\   					The Receiver, Node:%d, Grade:%d, time:%f.\n	wait_DATA_event has been invalid, the receiver is in Sleep.\nBut Receiving a DATA: That is impossible.\n",\   '					node_address,grade,op_sim_time());   			//op_sim_end("Error!","wait_DATA_event has been invalid, the receiver is in Sleep.","But Receiving a DATA: That is impossible.","");   		}   J	}else{//the data is not the desired one for the receiver, not a collision   	   		if(debug)   		printf("The Receiver, Node:%d, Grade:%d, time:%f.\n	Warning: The received DATA is not the Desired one.\nSet CW and go to sleep after the left time.\n",\   &				node_address,grade,op_sim_time());   		   		op_pk_destroy(pk_TV);   		CW=0;   .		//op_ima_obj_attr_get(process_id, "CW",&CW);   		   	}   *}else{//not a DATA packet, not a collision   
	if(debug)   	printf("Node:%d, Grade:%d, time:%f.\nThe received pk is not DATA. The pk type is: %d.\nDestroy this pk.\n",node_address,grade,op_sim_time(),pk_type);   		   	op_pk_destroy(pk_TV);   	CW=0;   -	//op_ima_obj_attr_get(process_id, "CW",&CW);   }   
                     
   џџџџ   
          pr_state        ю  v          
   CarrierSense1   
       
      	if(debug)   zprintf("Node:%d, time:%f. For Carrier Sense1 from idle2. \n Entered statwire Interruption.\n",node_address,op_sim_time());       ?if(op_ev_valid(wait_DATA_event)){//The receiver is waiting data   !	//a collision may happen, set CW   +	op_ima_obj_attr_get(process_id, "CW",&CW);   }       /*   #if(op_ev_valid(send_BEACON_event)){   !	op_ev_cancel(send_BEACON_event);   	//Then go to sleep right now   F	op_intrpt_schedule_self(op_sim_time() + 0.0,SLEEP_FROM_RECEIVE_CODE);   
	if(debug)   V		printf("Channel is busy, cancel \"send_BEACON_event\", go to sleep immediately.\n");   }   */   
                     
   џџџџ   
          pr_state        ю            
   
RecmpSeed1   
       
      =VRWaking_time=op_sim_time();//Virtual Waking time of receiver   DrandState=RandNum(randState,node_address);//compute current interval       wakeinterval=randState/1000.0;   cvirtual_to_receive_event=op_intrpt_schedule_self(op_sim_time() + wakeinterval,RECOMPUTE_SEED_CODE);       	if(debug)   Щ	printf("Node:%d, Grade:%d, time:%f,in RecmpSeed1 from sleeping.\n randState is %d. Next virtual waking to receive time= %f.\n",	node_address,grade,op_sim_time(),randState, op_sim_time()+wakeinterval);   
                     
   џџџџ   
          pr_state        ю             
   
RecmpSeed2   
       
      =VRWaking_time=op_sim_time();//Virtual Waking time of receiver   DrandState=RandNum(randState,node_address);//compute current interval       wakeinterval=randState/1000.0;   cvirtual_to_receive_event=op_intrpt_schedule_self(op_sim_time() + wakeinterval,RECOMPUTE_SEED_CODE);       	if(debug)   Фprintf("Node:%d, Grade:%d, time:%f,in RecmpSeed2 from idle1.\n randState is %d. Next virtual waking to receive time= %f.\n",node_address,grade,op_sim_time(),randState, op_sim_time()+wakeinterval);   
                     
   џџџџ   
          pr_state        ў             
   	RcvBeacon   
       
   b   if(pk_TV!=NULL)   {   	op_pk_destroy(pk_TV);   }       pk_TV = op_pk_get(RCV_STRM);       $pk_size=op_pk_total_size_get(pk_TV);   time=(pk_size+10)/data_rate;   //time statistic   !all_rx_time = all_rx_time + time;       	if(debug)   	printf("At The Sender, Node:%d, Grade:%d, time:%f.\nReceived a packet, size: %d.\nReceive Duration is: %f.\n",	node_address,grade,op_sim_time(),pk_size,time);       %op_pk_nfd_get(pk_TV,"Type",&pk_type);       "//the beacon or the beacon for ack   2if(pk_type == beacon_pk){//receive a beacon packet   (	op_pk_nfd_get(pk_TV,"Grade",&grade_TV);   	   &	op_pk_nfd_get(pk_TV,"Dest",&dest_TV);   	   (	//1. broadcasted from a node in grade-1   m	if(dest_TV == -1 && (grade_TV+1) == grade && !op_ev_valid(send_DATA_event) && !op_ev_valid(wait_ACK_event)){   		//prepare to send DATA   	   ,		op_pk_nfd_get(pk_TV,"Src",&data_next_hop);   		   #		op_pk_nfd_get(pk_TV,"CW",&CW_TV);   3		time = op_dist_uniform(CW_TV*1000.0)/1000.0+DIFS;   		   O		send_DATA_event=op_intrpt_schedule_self(op_sim_time() + time,SEND_DATA_CODE);   		   		if(debug)   			printf("At the sender, Node:%d, Grade:%d, time:%f.\nThe received beacon is a broadcast. Need to send data after %f seconds.\nWaiting to send data!\n",\   ,				node_address,grade,op_sim_time(),time);	   		   	}else   -	//2. a beacon for ack from a node in grade-1   S	if(dest_TV == node_address && grade_TV+1 == grade && op_ev_valid(wait_ACK_event)){   		op_ev_cancel(wait_ACK_event);   			   3		op_pk_nfd_get(pk_TV,"Current Seed",&cur_seed_TV);   4		op_pk_nfd_get(pk_TV,"Create Time",&creat_time_TV);   6		op_pk_nfd_get(pk_TV,"Waking Time",&RWaking_time_TV);   		   		if(debug)   [			printf("At the Sender, Node:%d, Grade:%d, time:%f.\nThe received beacon is for ACK.\n",\   &				node_address,grade,op_sim_time());       Y		if(cur_seed_TV>=0 && creat_time_TV>=0 && RWaking_time_TV>=0){//update predicition table   X			PredictionState * ps_TV=(PredictionState *)op_prg_mem_alloc(sizeof(PredictionState));   				   			ps_TV->ps_id=data_next_hop;   			ps_TV->ps_rs=cur_seed_TV;   ,			ps_TV->ps_td=op_sim_time()-creat_time_TV;   9			wakeinterval=cur_seed_TV/1000.0; //change unit: second   C			ps_TV->ps_next_wt=RWaking_time_TV+wakeinterval;//-op_sim_time();   &			ps_TV->ps_lastupdate=op_sim_time();   			   D			op_prg_list_insert(prediction_state_list,ps_TV,OPC_LISTPOS_TAIL);   			   			if(debug)   				printf("The prediction state of the receiver is embedded in this beacon.\nThe next waking time for this sender is %f.\n",ps_TV->ps_next_wt);   		}   		   ;		//Data has been sent correctly, remove it from temp_queue   >		op_pk_destroy(op_subq_pk_remove(data_queue, OPC_QPOS_HEAD));   			retx--;   3		//recieved ACK correctly, go to sleep immediately   >		op_intrpt_schedule_self(op_sim_time(),SLEEP_FROM_SEND_CODE);   		if(debug)   (			printf("Go to sleep immediately.\n");   		   $	//3. not the desired beacon packet	   	}else{   		op_pk_destroy(pk_TV);   		   		if(debug)   x			printf("AT The Sender, Node:%d, Grade:%d, time:%f.\nThe received beacon is not the desired one.\nJust ignore it.\n",\   '					node_address,grade,op_sim_time());   	}   !}else{//other packet (e.g., DATA)   	op_pk_destroy(pk_TV);   	   ?	//op_intrpt_schedule_self(op_sim_time(),SLEEP_FROM_SEND_CODE);   	   
	if(debug)   		printf("At the sender, Node:%d, Grade:%d, time:%f.\nThe received not a beacon.\nKeeps awake!\n",node_address,grade,op_sim_time());   }       /*   if(pk_TV!=NULL)   {   	op_pk_destroy(pk_TV);   }   */   
                     
   џџџџ   
          pr_state        v             
   	send DATA   
       
   #   //send DATA   if(pk_TV!=NULL)   {   	op_pk_destroy(pk_TV);   }   //obtain DATA from data_queue   Apk_TV = op_pk_copy(op_subq_pk_access(data_queue, OPC_QPOS_HEAD));   gop_pk_creation_time_set (pk_TV,op_pk_creation_time_get (op_subq_pk_access(data_queue, OPC_QPOS_HEAD)));       1op_pk_nfd_set(pk_TV,"Previous Hop",node_address);   .op_pk_nfd_set(pk_TV,"Next Hop",data_next_hop);       Yif(find_R_in_ps(data_next_hop)==NULL){//the sender have no record of the receiver's state   (	op_pk_nfd_set(pk_TV,"PS Flag",Request);   
	if(debug)   }	printf("1--Node:%d, Grade:%d, time:%f.\nNeed to request Prediction State. Set PS Flag.\n",node_address,grade,op_sim_time());   }else{   *	op_pk_nfd_set(pk_TV,"PS Flag",noRequest);   
	if(debug)   v	printf("1--Node:%d, Grade:%d, time:%f.\nDon't need to request Prediction State.\n",node_address,grade,op_sim_time());   }       op_pk_send(pk_TV,SEND_STRM);   retx++;       //time statistic   $all_tx_time = all_tx_time + durDATA;       1//set timer for waiting ACK from lower grade node   "time = durDATA + SIFS + durBEACON;   Twait_ACK_event = op_intrpt_schedule_self(op_sim_time() + time,SLEEP_FROM_SEND_CODE);       	if(debug)   printf("2--Node:%d, Grade:%d, time:%f.\nHave sent DATA, waiting a beacon for ACK.\nIf no ACK, after %f seconds, go to sleep (time:%f).\n",\   <		node_address,grade,op_sim_time(),time,op_sim_time()+time);   
                     
   џџџџ   
          pr_state        ў  v          
   
sendBeacon   
       
      //send BEACON   if(pk_TV!=NULL)   {   	op_pk_destroy(pk_TV);   }       *pk_TV = op_pk_create_fmt("MAC_BEACON_PK");   (op_pk_nfd_set(pk_TV, "Type", beacon_pk);   )op_pk_nfd_set(pk_TV,"Src", node_address);   *op_pk_nfd_set(pk_TV,"Dest",-1);//broadcast   0//op_pk_nfd_set(pk_TV,"Current Seed",randState);   3//op_pk_nfd_set(pk_TV,"Create Time",op_sim_time());   3//op_pk_nfd_set(pk_TV,"RWaking Time",RWaking_time);   #op_pk_nfd_set(pk_TV,"Grade",grade);   op_pk_nfd_set(pk_TV,"CW",CW);       op_pk_send(pk_TV, SEND_STRM);       //time statistic   &all_tx_time = all_tx_time + durBEACON;       time=durBEACON+CW+DIFS+durDATA;   ,//set timer for waiting DATA from the sender   Swait_DATA_event=op_intrpt_schedule_self(op_sim_time() + time,WAIT_DATA_EVENT_CODE);       	if(debug)   Ѕprintf("Node:%d, Grade:%d, time:%f,in sendBeacon state. Have Sent Beacon.\nSet wait_DATA_event.\nAfter %f seconds, if there is no data, go to NO_DATA (time:%f).\n",\   =			node_address,grade,op_sim_time(),time,op_sim_time()+time);   
                     
   џџџџ   
          pr_state        v  ю          
   send ACK   
       
      )if(op_subq_empty(ack_queue) == OPC_FALSE)   {   
	if(debug)   J		printf("Node:%d, Grade:%d, time:%f,in sendACK state. Have Sent ACK.\n",\   %			node_address,grade,op_sim_time());   5	pk_TV = op_subq_pk_remove(ack_queue, OPC_QPOS_HEAD);   	op_pk_send(pk_TV,SEND_STRM);   	//time statistic   %	all_tx_time = all_tx_time + durDATA;   }   else   {   G	op_sim_end("Err: grade queue is empty, simulation is over!","","","");   }   
                     
   џџџџ   
          pr_state          %   l         э  -     5  u      ф          
   tr_97   
       
   START_GRADE   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      m         љ  '      Њ   н  A  p          
   tr_98   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      n          І     4        ,  И  C            
   tr_37   
       
   default   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition      o          §     Q    S  Z          
   tr_102   
       
   FROM_LOWER && transceiver_state   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      p        H  ќ     E  Z  D            
   tr_52   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      q        2       F  o  F   Ў          
   tr_100   
       
   SEND_GM   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      r        W       S   Ў  T  h          
   tr_101   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      s          г        n    6            
   tr_115   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      u        м       a    n            
   tr_117   
       
   START_SCHEDULE && Q_empty   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      x          N     \  y  э             
   tr_120   
       
   START_SCHEDULE && (!Q_empty)   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      y        ;   Я        ў  k              
   tr_121   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      z   	   
  :  7        ќ  s  q          
   tr_122   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition      |        ;  F     s  x              
   tr_124   
       
   WAKING_TO_SEND   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      }        x       z      x  n          
   tr_125   
       
   SLEEP_FROM_SEND   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition      ~   
     v  ќ     v  `  v            
   tr_126   
       
   SLEEP_FROM_RECEIVE   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition            	  *  Ц     l      ђ          
   tr_127   
       
   WAKING_TO_RECEIVE   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition         
     Ж  d       n  з  o          
   tr_133   
       
   CHECK_CHANNEL   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition            
  Г  }     й  {    z          
   tr_134   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition         
   
  Ї             Ѕ  Є                
   tr_135   
       
   default   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition              З  d         ж            
   tr_136   
       
   RECOMPUTE_SEED   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition              А       з                
   tr_137   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition                 Ќ     ~      И                   
   tr_138   
       
   default   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition              И   {     a     з             
   tr_139   
       
   RECOMPUTE_SEED   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition              И        
     f             
   tr_140   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition                  r     _                  
   tr_141   
       
   FROM_LOWER && transceiver_state   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition              >             c             
   tr_142   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition              G   Z     n     o   2          
   tr_143   
       
   	SEND_DATA   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition                 Z        4     }          
   tr_144   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition                 И     ~   Ћ     Ф     Ћ     Ѕ          
   tr_145   
       
   default   
       џџџџ          
    џџџџ   
       
    џџџџ   
                    pr_transition         
     9  c     b  n    o          
   tr_147   
       
   SEND_BEACON   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition            
  E  }       ~  r  |          
   tr_148   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition         
     p  Й     o    q  х          
   tr_149   
       
   SEND_ACK   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition            
  ~  Џ       ж  }            
   tr_150   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition         
     ;  И     i      ф          
   tr_151   
       
   NO_DATA   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition            
  5  Ќ     	  ж  a            
   tr_152   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition         
     д  Ш         н  с          
   tr_153   
       
   FROM_LOWER && transceiver_state   
       џџџџ          
    џџџџ   
          џџџџ                       pr_transition            
  Й  Џ     х  к              
   tr_154   
       џџџџ          џџџџ          
    џџџџ   
          џџџџ                       pr_transition                                       
2010-05-18       Fusion of Routing and Mac        