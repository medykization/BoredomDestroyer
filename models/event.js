class Event {
    constructor(user_id, event_name, category_id, description, location, begin_time, end_time, rating) {
        this.user_id = user_id
        this.event_name = event_name
        this.category_id = category_id
        this.description = description
        this.location = location
        this.begin_time = begin_time
        this.end_time = end_time
        this.rating = rating
    }
}

module.exports = Event   
