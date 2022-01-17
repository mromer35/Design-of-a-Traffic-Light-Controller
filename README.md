# Design-of-a-Traffic-Light-Controller 

The traffic light controllers specifications are tailored for an intersection between a farm road (very low traffic) and a highway (heavy usage). Assuming the farm road is not expected to receive moderate to high traffic usage then the highway green light will be the default output  until the traffic light senses a waiting vehicle on the farm road. Once the sensor senses a waiting vehicle a set timer will begin in which the highway lights will switch from green to yellow and then to red. For convincience and testing purposes the cycle from green light to red light will occur within 5 clock cycles. Two clock cycles for green, one clock cycle for yellow and two clock cycles for red. Even if a vehicle remains on the farm road after the 5 cycle interval, the highway light will turn green and begin a 5 cycle interval. At the end of the interval the farm road light will turn green and begin its 5 cycle interval again.
