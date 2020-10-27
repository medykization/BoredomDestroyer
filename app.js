const express = require('express')
const app = express()
const port = process.env.PORT || 3000


app.listen(port, () => console.log("Server is running"))

app.post('/login', (req, res) => {
    const user = [{login: pawel, password: 1234}]
    res.json(user)
})

app.get('/user', (req, res) => {
    const user = [{login: pawel, password: 1234}]
    res.json(user)
})

app.get('/', (req, res) => {
    console.log('hello world')
})