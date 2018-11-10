Traditionally, human beings have relied on fossil fuels to satisfy their energy demands.
Fossil fuels produce carbon emissions to the atmosphere that are endangering our environ-
ment. In an effort to tackle some of these problems, a revolution has been taking place:
the energy transition. In this transformation, to reduce the amount of carbon emissions to
the atmosphere, energy systems are transitioning to renewable energy sources (RES). In this
process, as the generation of RES is highly intermittent and unpredictable, energy storage
has become very important. As nearly 80% of the energy consumption in EU households
is destined to water and space heating, heat storage has become paramount to improve the
efficiency of RES generation. In particular, by storing electricity as heat energy when there is
an excess of RES, and then deploying this heat when there is a shortage of RES, the efficiency
of RES systems can be improved.
Heat Tanks is a company that has multiple heat storage tanks and wants to optimize the
trade of electricity and heat in order to maximize their profits. They hire you as their lead
optimization engineer in order to carry out this task.
After reading the documentation of their systems, you realize that each of these tanks
can be modeled by one state T (t) representing the internal temperature in the tank at time
instant t, two controls Q̇ in (t) and Q̇ out (t) representing the input and output heat to the tank,
and one external disturbance T amb (t) representing the ambient temperature:

![Image5](https://github.com/kofori00/Optimizing-Energy-Trade-/blob/master/Capture4.JPG
)

The model can be discritized using 


![Image2](https://github.com/kofori00/Optimizing-Energy-Trade-/blob/master/Capture.JPG
)

where Tk represents the internal temperature in the tank at time step tk. The resulting
model has to be of the form of:

![Image2](https://github.com/kofori00/Optimizing-Energy-Trade-/blob/master/Capture1.JPG
)

We initially formulate the following quadratic optimization problem, without condering the cost of buying a unit of energy input:

![Image3](https://github.com/kofori00/Optimizing-Energy-Trade-/blob/master/Capture2.JPG
)

After this initial optimization we are ready to optimize the energy trade of one of the tanks. To optimize
the hourly energy trade over some horizon N, you need to minimize the cost of buying
the input energy _Q
in over that horizon while satisfying the requested heat demand.
In this optimization setup, you need to also add a constraint that ensures that the
system dynamics are validated throughout the horizon. This optimization problem can
be defined as:

![Image4](https://github.com/kofori00/Optimizing-Energy-Trade-/blob/master/Capture3.JPG
)

where \lamba_in
k is the price of buying one unit of input heat at time step k, _Q
in
max the maximum
input power, Tmin the minimum internal temperature to ensure the heat demand, and
where T1, Tamb, _Q
out
k , and in
k are typically given in advance.


See the added pdf for full solution description. 





