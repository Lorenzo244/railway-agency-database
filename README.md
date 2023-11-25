# ITA Trains project
We were asked to implement a database for a new railway company, ITA Trains.
ITA Trains is a company that has been active for just over a year and needs software that contains information relating to trips managed by the company itself.
The latter asked us to create a database that collects, summarizes and connects:
1. Data regarding reservations and users;
2. Travel information;
3. Employee information;
4. Customer opinions.

## Clients
Two types of customers can use the service offered by ITA Trains: "passenger" users and "business" users.
Passengers receive a personal ID after entering their name, surname, date of birth, email and telephone number.
Companies also receive their ID, once they have specified the type of goods they intend to transport and their VAT number (useful for knowing more information if necessary without burdening the BDD)

## Reservations
The passenger makes a reservation for a specific trip; after entering your personal data, you can select some specifications:
Number of seats reserved: up to 4 seats can be reserved per booking (4 travellers).
Luggage: up to a maximum of two per traveler (not included).
Class: ITA Trains passengers can choose whether to travel in Economy, Business or Premium carriages. What differentiates the classes are the different services offered on board and at the station:
Economy: seat in economy carriage, basic traveler kit (bottle of water, handkerchiefs, pencil and notepad);
Business: seat in business carriage, basic traveler's kit, snack and hot drink of your choice, 1 piece of luggage included;
Premium: Premium carriage seat, basic traveler kit, snack and hot drink of your choice, 2 bags included, access to the ITA Trains lounge.
A company that decides to rely on ITA Trains has the possibility, after having declared the type of product it intends to transport, to select the route for the transfer of its goods.

## Loyalty program
After registering, "passenger" customers of the railway company become part of our loyalty program: after each booking the registered customer automatically receives 5 loyalty points; by accumulating them they have the opportunity to take advantage of discounts and win prizes.


## Insurance
All ITA Trains customers can choose at the time of booking whether or not to insure their trip.
In trips involving the transport of people, the insurance partially reimburses the tickets in the event that the trip is canceled or in the event of a long delay; as regards the transport of goods, the insurance fully reimburses the value of the goods in the event that something were to happen to them.

## Reviews
Once the trip is over, for each booking you can leave a review on the route travelled, and express your opinion on the experience with a rating from 1 to 5 stars.

## Trips
ITA Trains manages more than 2500 journeys a year and each route has an average travel time of once every 2 days: this increases in the case of more used routes (e.g. Milan-Naples), and decreases in the case of less frequented routes or with longer travel times (e.g. Agrigento-Agrigento).
If the number of passengers booked does not exceed 30 units, the trip will be canceled and customers will be notified and subsequently refunded.

## Stops
ITA Trains covers 71 Italian cities and 6 European cities.
During stops the journey is briefly interrupted to let passengers off/on. The duration of each stop does not exceed 15 minutes to avoid delays in the timetable. Each stop can be part of multiple routes (as in the case of Milan).

## Routes 
The railway company offers its customers 15 routes: they can choose between 12 national routes, with an average of 7 stops each, and 3 international routes, with 2 or 3 stops.
Trips can cover the entire route or even just part of it: both passengers and companies that rely on ITA Trains for their travel can freely choose at the time of booking which station to leave from and where to get off.

## Trains
Each trip is associated with one of the 14 trains that the railway company owns; they are divided into freight trains and passenger trains according to the nature of the journey:
Passenger trains: they have 6 to 8 carriages divided into economy, business and premium carriages; each train has a specific capacity, both in terms of luggage (around 70 per carriage) and in terms of total passengers.
Freight trains: they have an average of 7 wagons, and each of the trains is used to transport a specific product.

## Employees
A total of 80 people work for ITA Trains, aged between 20 and 65.
The railway company makes a distinction between two groups of employees, depending on the job they perform: crew and clerks.

## Crew
The crew is made up of employees who work on board the train (therefore train drivers, hostesses, train conductors...): each member of staff can choose a preferred route: the company will try to respect their preference when possible.
Furthermore, the system must take into account overtime hours, which can never exceed 20 hours per month.
The employees, on the other hand, are those who work in the station or in one of the two ITA Trains offices (Rome or Milan) and are divided into clerks and maintenance workers: the system is interested in the type of employment contract.



