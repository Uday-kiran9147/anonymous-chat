const express = require('express');
const http = require('http');
const { type } = require('os');
const {Server} = require('socket.io');

const app = express();
const httpServer = http.createServer(app);
const io =new Server(httpServer);


app.route('/').get((req,res)=>{
    res.json("Hey there!, welcome to our channel")
})

io.on('connection',(socket)=>{
    socket.join('anonymous_group');
    console.log('Backend connected!')
    socket.on('sendMsg',(message)=>{
        // socket.emit('sendMsgServer',{...message,type:"otherMsg"})
        io.to('anonymous_group').emit('sendMsgServer',{...message,type:"otherMsg"})
    })
})

httpServer.listen(3000,()=>{
    console.log("Server is running on port 3000")
})