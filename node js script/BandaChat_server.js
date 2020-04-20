/* socket\room_chat\app.js */

const express = require('express');
const app = express();
const http = require('http').Server(app);
const io = require('socket.io')(http);

var bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));

//app.set('view engine', 'ejs');
//app.set('views', './views');

//app.use(express.static(path.join(__dirname, '/public')));
//app.use('/ejs에서접근할경로', express.static(path.join(__dirname, ' /실제위치한디렉토리경로')));  

//app.use(express.static(__dirname + '/public'));

let room = ['room0'];
let a = 0;


app.get('/', (req, res) => {
    console.log("unn")
});


io.on('connection', (socket) => {
  socket.on('disconnect', () => {
    console.log('user disconnected');
  });
    
  socket.on('makeRoom',(userid, otherid) =>{
      
      var ids = userid+"_"+otherid;
      console.log(ids);
      var count = 0;
      
      for(var i=0 ; i<room.length ; i++){
          if(room[i] === ids){
              count++;
          }
      }
      
      console.log(count);
      
      if(count == 0){
        room.push(ids);
      }
      
      console.log(room);
      console.log(room.indexOf(ids));
      
      if(room.indexOf(ids) > 0){
          console.log(room[room.indexOf(ids)]);
      }else{
          console.log("입력받은 아이디의 room을 만들지 못했습니다.");
      }
      
      socket.emit('passRoomNum',room[room.indexOf(ids)] ,room.indexOf(ids))
      
  });

  socket.on('leaveRoom', (num, name) => {
    socket.leave(room[num], () => {
      console.log(name + ' leave a ' + room[num]);
      io.to(room[num]).emit('leaveRoom', num, name);
    });
  });


  socket.on('joinRoom', (num, name) => {
    socket.join(room[num], () => {
      console.log(name + ' join a ' + room[num]);
      io.to(room[num]).emit('joinRoom', num, name);
    });
  });


  socket.on('chat message', (num, name, msg) => {
    a = num;
    io.to(room[a]).emit('chat message', name, msg);
  });
    
    
  socket.on('ontext', (num,name,texty) =>{
     io.to(room[num]).emit('ontext',name,texty); 
  });  
  
    
  socket.on('offtext', (num,name,textn) =>{
      io.to(room[num]).emit('offtext',name,textn);
  });
    

  socket.on('change_litag', (sid, gid, msg) =>{
      console.log('change_litag');
      for(var i=0; i<room.length; i++){
        io.to(room[i]).emit('change_litag',sid, gid,msg);
      }
  });
    
    
    
});


http.listen(3000, () => {
  console.log('Connect at 3000');
});


//app.listen(3001, () => {
//  console.log('Connect at 3001');
//});
//
//app.post('/gochat', function(req, res){
// 
//    var data = req.body.data;
// 
//    console.log('POST Parameter = ' + data);
// 
//    var result = data + ' Succese';
// 
//    console.log(result);
// 
//    res.send({result:result});
// 
//});
