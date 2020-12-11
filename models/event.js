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
