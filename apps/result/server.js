const express = require("express");
const cookieParser = require("cookie-parser");
const methodOverride = require("method-override");
const path = require("path");
const bodyParser = require("body-parser");
const async = require("async");
const http = require("http");
const { Server } = require("socket.io");

const app = express();
const server = http.createServer(app);
const port = process.env.PORT || 5001;
const io = new Server(server, {
  path: "/results/socket/",
});

// Socket.io
io.on("connection", (socket) => {
  socket.emit("message", { text: "Welcome!" });
  socket.on("subscribe", (data) => {
    socket.join(data.channel);
  });
});

// PostgreSQL Client
const { Client } = require("pg");
const client = new Client({
  host: "db",
  port: 5432,
  user: "postgres",
  password: "postgres",
});

async.retry(
  { times: 1000, interval: 1000 },
  function (callback) {
    client.connect(function (err, client, done) {
      if (err) {
        console.error("Waiting for db");
        console.log(err);
      }
      callback(err, client);
    });
  },
  function (err, client) {
    if (err) {
      return console.error("Giving up");
    }
    console.log("Connected to db");
    getVotes(client);
  }
);

function getVotes(client) {
  client.query(
    "SELECT vote, COUNT(id) AS count FROM votes GROUP BY vote",
    [],
    function (err, result) {
      if (err) {
        console.error("Error performing query: " + err);
      } else {
        var votes = collectVotesFromResult(result);
        io.emit("scores", JSON.stringify(votes));
      }

      setTimeout(function () {
        getVotes(client);
      }, 1000);
    }
  );
}

function collectVotesFromResult(result) {
  var votes = { a: 0, b: 0 };

  result.rows.forEach(function (row) {
    votes[row.vote] = parseInt(row.count);
  });

  return votes;
}

// Express.js
app.use(cookieParser());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(methodOverride("X-HTTP-Method-Override"));

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  res.header("Access-Control-Allow-Methods", "PUT, GET, POST, DELETE, OPTIONS");
  next();
});

app.use("/results", express.static(__dirname + "/views"));

app.get(["/", "/results"], function (req, res) {
  res.sendFile(path.resolve(__dirname + "/views/index.html"));
});

server.listen(port, function () {
  var port = server.address().port;
  console.log("App running on port " + port);
});
