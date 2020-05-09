# Vehicle Queueing Model of the SH1 Greenlane Interchange 43 Northbound

The Greenlane roundabout is often considered one of the busiest interchanges in Auckland. 
It is not uncommon to hear people complaining about being stuck in a traffic jam around that area.
One of the major causes behind the automobile conjestion are the ramp signals which control the flow of traffic merging onto 
the motorways.

The traffic flow on the ramp leading to the southern motorway northbound was used as an example to apply the queueing theory and 
analyse the system.
Screenshots were taken for 5 minutes from 07:55am to 08:00am on Friday 18th May 2018 when the ramp signal was on.
![alt text](https://github.com/briceshun/MM1-Queueing-Model/blob/master/Pictures/Screenshots.PNG?raw=true)

### Outcomes
Model Definition = Markov/Markov/1 : FIFO/∞/Infinite

The ramp's mean inter-arrival and service time was 4.35 seconds and 4.55 seconds respectively.<br>
Based on the data collected and analysis, we can conclude that the ramp's limited capacity does not allow a smooth traffic flow 
to the motorway and creates a bottleneck situation. This may extend the queue to Greenlane East.

Simulation showed that the optimal solution would be to add an additional lane to the ramp. 
This will decrease the waiting time on the ramp and produce a steady state system with a maximum of 3 vehicles waiting at all times.

## Application of Queueing Theory
The Queuing Theory is a mathematical study of queues which may be used to create predictive models of queue lengths and 
waiting times in an attempt to streamline these processes. 
Conjestion arises when the vehicles arrive faster than the ramp signal can let then merge with the motorway. 

<b>Queueing Theory Terminology:</b>
* <b>Input Source</b>: the vehicles arriving from various roads onto the ramp. 
* <b>Calling Population</b>: the vehicles calling population is <i>Infinite Calling Population</i>.
* <b>Queuing System</b>: the process of queueing up on the ramp and waiting to be able to merge with the motorway.
* <b>Queuing Configuration & Discipline</b>: how the vehicles proceed across the Ramp and behave in their lanes.
* <b>Service Mechanism</b>: the way the vehicles are allowed to merge (how they are served).
* <b>Mean Arrival Rate (μ)</b>: the mean arrival frequency per second.
* <b>Mean Service Rate (λ)</b>: the mean merging frequency per second.
* <b>Service Utilisation Factor (ρ)</b>: mean arrivals (capacity demand) per mean merging (available capacity).

In our case, the mean arrival rate of vehicles on the Ramp exceeds its service time, which leads to an exponentially increasing queue size.

![alt text](https://github.com/briceshun/MM1-Queueing-Model/blob/master/Pictures/System.PNG?raw=true)

## M/M/1 Queueing Model
The Kendall notation (A/B/N) will be used to define the model. <br>
A is the <i>arrival distribution</i>, <i>B</i> is the Service Distribution</i>, and </i>N</i> is the number of servers.

### Model
<b>Model definition</b>: Markov/Markov/1

The <i>inter-arrival time </i> and </i>service time</i> follow a memoryless <i>Markovian</i> (exponential) distribution
The system is independent of the last arrival or service wait-time; 
This implies that the expected arrival rate λ<sub>n</sub>=λ=0.23 and expected service time s<sub>n</sub>=s=4.55 seconds for all observations. 

This is a special case of the Markov Process; the state alternates between arrival and departure. 
For any quantity of vehicles in the system, the next arrival will arrive within 1/λ=4.35 seconds; 
and the next merging will be within an average of 1/μ=4.55 seconds.

### Assumptions
* Calling population infinite
* Service and Arrival are exponentially distributed. Arrival follows <i>Poisson Process</i>.
* The system follows a <i>Single Queue Configuration</i>. 
* Single <i>First-In-First-Out</i> queue of infinite length configuration.
* No balking, reneging, or retrial.
* Single server located at end of queue.
* All vehicles in the 2 lanes considered as 1 queue.

### Service Utilisation
The M/M/1 queue has capacity demand exceeding available capacity (λ > μ); this leads to ρ=1.05. <br>
It is therefore not in a steady state and will explode since more vehicles are arriving than merging.

## Results & Implications
Based on the data collected and analysis, we can conclude that the ramp's limited capacity does not allow a smooth traffic flow 
to the motorway and creates a bottleneck situation. 
Drivers as they are forced to wait a relatively long time before being able to access the motorway. 
This may eventually result in long queues extending past the ramp and onto Greenlane East, affecting the latter's traffic flow. 
This will create massive traffic jams.

## Suggested Solution
A feasible solution would be to increase the number of lanes on the ramp to increase the number of vehicles served. 
This will increase the expected service rate and consequently reduce the service time. 
This will lead to λ<μ and ρ<1 thus meeting the <i>Steady State Condition</i> 
where the system state is independent of the initial state as well as the elapsed time.

| Option   | Lanes | Mean Arrival Rate (λ) | Mean Service Rate (μ)  | Service Utilisation Rate (ρ) |
| -------- | ----- | --------------------- | ---------------------- | ---------------------------- |
| Current  | 2     | 0.23                  | 0.11 × 2 = 0.22        | 0.23 ⁄ 0.22 = 1.05           |
| Option 1 | 3     | 0.23                  | 0.11 × 3 = 0.33        | 0.23 ⁄ 0.33 = 0.70           |
| Option 2 | 4     | 0.23                  | 0.11 × 4 = 0.44        | 0.23 ⁄ 0.44 = 0.52           |

As it can be seen from Table 4, increasing the number of lanes significantly decreases the service utilisation rate. 
An additional lane would suffice to produce a steady state system. 
Although more lanes would improve the rate even more, it is not cost efficient to build all these lanes; 
too many lanes might just be a step backwards as the rate at which the vehicles will access the motorway will be the same as without a signalled ramp which defeats its purpose. 
Hence, 1 additional lane (Option 1) is the most cost-efficient solution to improve the flow of vehicles at the ramp to eliminate 
ever-growing queues and waiting times.

![alt text](https://github.com/briceshun/MM1-Queueing-Model/blob/master/Pictures/Simulation.png?raw=true)

Simulation shows significant improvement in traffic flow on ramp. 
The proposed solution’s queue clearly does not explode and it has reached a steady state system has become independent of initial state.
Queue size stabilised at 3 vehicles.
