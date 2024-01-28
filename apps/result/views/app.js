let app = angular.module("catsvsdogs", []);
let socket = io.connect({
  transports: ["polling"],
  path: "/results/socket/",
});

let bg1 = document.getElementById("background-stats-1");
let bg2 = document.getElementById("background-stats-2");
let bg3 = document.getElementById("background-stats-3");

app.controller("statsCtrl", function ($scope) {
  $scope.aPercent = 33.3;
  $scope.bPercent = 33.3;
  $scope.cPercent = 33.3;

  let updateScores = function () {
    socket.on("scores", function (json) {
      data = JSON.parse(json);
      let a = parseInt(data.a || 0);
      let b = parseInt(data.b || 0);
      let c = parseInt(data.c || 0);

      let percentages = getPercentages(a, b, c);

      bg1.style.width = percentages._a + "%";
      bg2.style.width = percentages._b + "%";
      bg3.style.width = percentages._c + "%";

      $scope.$apply(function () {
        $scope.aPercent = percentages.a;
        $scope.bPercent = percentages.b;
        $scope.cPercent = percentages.c;
        $scope.total = a + b + c;
      });
    });
  };

  let init = function () {
    document.body.style.opacity = 1;
    updateScores();
  };

  socket.on("message", (data) => {
    init();
  });
});

function getPercentages(a, b, c) {
  let result = {};

  if (a + b + c > 0) {
    result.a = ((a / (a + b + c)) * 100).toFixed(1);
    result.b = ((b / (a + b + c)) * 100).toFixed(1);
    result.c = ((c / (a + b + c)) * 100).toFixed(1);

    let buffer = 1;
    let counter = 0;
    counter += a > 0 ? 1 : 0;
    counter += b > 0 ? 1 : 0;
    counter += c > 0 ? 1 : 0;

    result._a = a > 0 ? result.a - buffer / counter : 0;
    result._b = b > 0 ? result.b - buffer / counter : 0;
    result._c = c > 0 ? result.c - buffer / counter : 0;
  } else {
    result.a = result.b = result.c = 33.3;
    result._a = result._b = result._c = 33;
  }

  return result;
}
