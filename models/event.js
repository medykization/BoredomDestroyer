class Event {
    constructor(user_id, event_name, category_id, description, location_city, location_address, begin_time, end_time, rating) {
        this.user_id = user_id
        this.event_name = event_name
        this.category_id = category_id
        this.description = description
        this.location_city = location_city
        this.location_address = location_address
        this.begin_time = begin_time
        this.end_time = end_time
        this.rating = rating
    }
}

module.exports = Event   

//select e.id , e.user_id, e.event_name, e.category_id, e.description, e.location_city, e.location_address, e.begin_time, e.end_time, e.rating, ec.category_name, sum(ev.vote) from event e join event_category ec on e.category_id = ec.id join event_votes ev on e.id = ev.event_id WHERE e.location_city = 'Łódź' GROUP BY e.id, ec.category_name
//select e.id , e.user_id, e.event_name, e.category_id, e.description, e.location_city, e.location_address, e.begin_time, e.end_time, e.rating, ec.category_name,COALESCE(sum(ev.vote),0) from event e join event_category ec on e.category_id = ec.id join event_votes ev on e.id = ev.event_id WHERE e.location_city = 'Łódź' GROUP BY e.id, ec.category_name
//select e.id , e.user_id, e.event_name, e.category_id, e.description, e.location_city, e.location_address, e.begin_time, e.end_time, ec.category_name, (select COALESCE(sum(vote),0) from event_votes where event_id = e.id) as rating from event e join event_category ec on e.category_id = ec.id WHERE e.location_city = 'Łódź' GROUP BY e.id, ec.category_name
//select e.id , e.user_id, e.event_name, e.category_id, e.description, e.location_city, e.location_address, e.begin_time, e.end_time, ec.category_name, (select COALESCE(sum(vote),0) from event_votes where event_id = e.id) as rating, COALESCE((select vote from event_votes where user_id = $1 and event_id = e.id),0) as vote  from event e join event_category ec on e.category_id = ec.id WHERE e.location_city = $2 GROUP BY e.id, ec.category_name