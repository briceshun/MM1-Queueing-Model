/* ======================================================================================== */
/*                       1 HR (60 MIN) SIMULATION OF PROPOSED SOLUTION                      */
/* ======================================================================================== */
PROC IML;
start main;
	/* Set seed */
	call streaminit(123456789);
	
	/* Parameters */
	* Arrival & Service;
	lambda = 0.23; 
	mu1 = 0.11;
	* No. of seconds in 60 minutes;
	T = 60*60; 


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*                            2 Lane Simulation (Current Ramp)                              */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	lanes = 2; 
	
	/* Create matrix to store time, arrivals, departures, queue size */
	ramp = j(T+1,4,0);
	
	/* 3600s simulation */
	do i = 1 to T+1;		
		* Simulated arrivals and departures per second;
		arrivals = rand("Poisson",lambda);
		departures = rand("Poisson",(mu1*lanes));
		
		* Time;
		ramp[i,1]=i-1;
		/* Arrivals and Departures */
		ramp[i,2]=arrivals;
		ramp[i,3]=departures;
		
		* Queue Size;
		if i = 1 then   	ramp[1,4]=max(ramp[i,2]-ramp[i,3],0);
		else			ramp[i,4]=max((ramp[i-1,4]+(ramp[i,2]-ramp[i,3])),0);

		if ramp[i,4]=0 then 	ramp[i,3]=0;		
	end;


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*                         3 Lane Simulation (Proposed Solution)                            */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
	lanes = 3;
	
	/* Create matrix to store time, arrivals, departures, queue size */
	ramp1 = j(T+1,4,0);
	
	/* 3600s simulation */
	do i = 1 to T+1;		
		* Simulated arrivals and departures per second;
		arrivals = rand("Poisson",lambda);
		departures = rand("Poisson",(mu1*lanes));

		* Time;
		ramp1[i,1]=i-1;
		/* Arrivals and Departures */
		ramp1[i,2]=arrivals;
		ramp1[i,3]=departures;
		
		* Queue Size;
		if i = 1 then		ramp1[1,4]=max(ramp1[i,2]-ramp1[i,3],0);
		else			ramp1[i,4]=max((ramp1[i-1,4]+(ramp1[i,2]-ramp1[i,3])),0);

		if ramp1[i,4]=0 then 	ramp1[i,3]=0;		
	end;
	
	/* Save results */
	vars  = {"Time","Arrivals","Departures","Queue_Size"};
	vars1 = {"Time","Arrivals1","Departures1","Queue_Size1"};

	/* 2 Lane Ramp */
	create work.ramp from ramp[colname=vars];
		append from ramp;
	close work.ramp;

	/* 3 Lane Ramp */
	create work.ramp1 from ramp1[colname=vars1];
		append from ramp1;
	close work.ramp1;

finish main;
RUN;

	
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*                         Visualisation of Traffic Flow on Ramp                            */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* Merge Datasets */
DATA work.compare; merge work.ramp work.ramp1; RUN;

/* Visualise */
title1 "Comparison of Current and Proposed Ramp";
title2 "2 Lanes vs 3 Lanes";
PROC SGPLOT data=work.compare;
	series x=Time y=Queue_Size  / name="ramp"  
				      legendlabel="2 Lane Ramp";
	series x=Time y=Queue_Size1 / name="ramp1" 
				      legendlabel="3 Lane Ramp";
	
	xaxis 	label="Time (Minutes)" values=(0 to 3600 by 300)
		valuesdisplay=("0" "5" "10" "15" "20" "25" "30" "35" "40" "45" "50" "55" "60") 
		grid;
	yaxis 	label="Number of Vehicles" values=(0 to 90 by 5) grid;
	
	keylegend "ramp" "ramp1" / location=inside 
				   position=top;
RUN;

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*                           Statistics of Traffic Flow on Ramp                             */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* 2 Lane Ramp - Current Ramp */
title1 "Histogram of Queue Size for Current Ramp (2 Lanes)";
PROC UNIVARIATE data = work.ramp;
	histogram Queue_Size /	midpoints = 0 to 90 by 5
				normal
				kernel;
RUN;

/* 3 Lane Ramp - Proposed Solution */
title1 "Histogram of Queue Size for Proposed Ramp (3 Lanes)";
PROC UNIVARIATE data = work.ramp1;
	histogram Queue_Size1 /	midpoints = 0 to 12 by 1
				normal
				exponential;
RUN;
