const express = require('express')
const path = require('path');


const app = express()
const PORT = 6767


app.use(express.static(path.join(__dirname)))
app.listen(PORT, () => {
    console.log("listening at http://localhost:6767")
})