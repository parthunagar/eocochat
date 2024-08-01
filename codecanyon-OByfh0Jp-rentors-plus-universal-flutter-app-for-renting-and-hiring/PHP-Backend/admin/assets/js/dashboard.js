(function($) {
  'use strict';
  $(function() {
    if ($('#dashoard-area-chart').length) {
      var lineChartCanvas = $("#dashoard-area-chart").get(0).getContext("2d");
      var ajaxResult=[];
      var myResponse = $.ajax({
        url: 'http://phpstack-132936-444295.cloudwaysapps.com/Admin/all_revenue',
        type: 'GET',
        success: function(res) {
             myResponse = res;
             ajaxResult.push(res);
            // then you can manipulate your text as you wish            
        }
    });
      console.log(ajaxResult); 
     
      var data = {
        labels: ["2014", "2015", "2016", "2017", "2018"],
        datasets: [{
            label: 'Profit',
            data: [0, 0, 0, 0, 12],
            backgroundColor: 'rgba(25, 145 ,235, 0.7)',
            borderColor: [
              'rgba(25, 145 ,235, 1)'
            ],
            borderWidth: 3,
            fill: true
          },
          /*{
            label: 'Target',
            data: [1, 6, 1, 6, 1, 2, 8, 9],
            backgroundColor: 'rgba(255, 99, 132, 0.7)',
            borderColor: [
              'rgba(255, 99, 132, 1)'
            ],
            borderWidth: 3,
            fill: true
          }*/
        ]
      };
      var options = {
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            },
            gridLines: {
              display: true
            }
          }],
          xAxes: [{
            ticks: {
              beginAtZero: true
            },
            gridLines: {
              display: false
            }
          }]
        },
        legend: {
          display: false
        },
        elements: {
          point: {
            radius: 3
          }
        }
      };
      var lineChart = new Chart(lineChartCanvas, {
        type: 'line',
        data: data,
        options: options
      });
    }
  });
})(jQuery);