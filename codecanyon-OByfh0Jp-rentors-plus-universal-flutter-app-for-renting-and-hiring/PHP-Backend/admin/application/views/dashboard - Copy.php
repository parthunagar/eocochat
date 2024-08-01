 <div class="main-panel">
  <div class="content-wrapper">
    <div class="row">
      <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6 grid-margin stretch-card">
        <div class="card card-statistics">
          <div class="card-body">
            <div class="clearfix">
              <div class="float-left">
                <i class="mdi mdi-account-location text-info icon-lg"></i>
              </div>
              <div class="float-right">
                <p class="card-text text-right">Users</p>
                <div class="fluid-container">
                  <h3 class="card-title font-weight-bold text-right mb-0"><?php echo $user; ?></h3>
                </div>
              </div>
            </div>
            <p class="text-muted mt-3">
              <i class="mdi mdi-alert-octagon mr-1" aria-hidden="true"></i> Total Users
            </p>
          </div>
        </div>
      </div>
      <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6 grid-margin stretch-card">
        <div class="card card-statistics">
          <div class="card-body">
            <div class="clearfix">
              <div class="float-left">
                <i class="mdi mdi-receipt text-warning icon-lg"></i>
              </div>
              <div class="float-right">
                <p class="card-text text-right">Category</p>
                <div class="fluid-container">
                  <h3 class="card-title font-weight-bold text-right mb-0"><?php echo $function; ?></h3>
                </div>
              </div>
            </div>
            <p class="text-muted mt-3">
              <i class="mdi mdi-bookmark-outline mr-1" aria-hidden="true"></i> Total Category
            </p>
          </div>
        </div>
      </div>
      <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6 grid-margin stretch-card">
        <div class="card card-statistics">
          <div class="card-body">
            <div class="clearfix">
              <div class="float-left">
                <i class="mdi mdi-poll-box text-teal icon-lg"></i>
              </div>
              <div class="float-right">
                <p class="card-text text-right">Sub Category</p>
                <div class="fluid-container">
                  <h3 class="card-title font-weight-bold text-right mb-0"><?php echo $service_list; ?></h3>
                </div>
              </div>
            </div>
            <p class="text-muted mt-3">
              <i class="mdi mdi-calendar mr-1" aria-hidden="true"></i> Total Sub Category
            </p>
          </div>
        </div>
      </div>
      <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6 grid-margin stretch-card">
        <div class="card card-statistics">
          <div class="card-body">
            <div class="clearfix">
              <div class="float-left">
                <i class="mdi mdi-cube text-danger icon-lg"></i>
              </div>
              <div class="float-right">
                <p class="card-text text-right">Products</p>
                <div class="fluid-container">
                  <h3 class="card-title font-weight-bold text-right mb-0"><?php echo $product; ?></h3>
                </div>
              </div>
            </div>
            <p class="text-muted mt-3">
              <i class="mdi mdi-reload mr-1" aria-hidden="true"></i> Total Products
            </p>
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-6 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">Users</h4>
            <canvas id="barChart" style="height:230px"></canvas>
          </div>
        </div>
      </div>
      <div class="col-lg-6 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">Users (Active / Deactivated)</h4>
            <canvas id="pieChart" style="height:250px"></canvas>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-12 grid-margin">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title mb-4">Recent Added Products</h5>
            <div class="table-responsive">
              <table class="table center-aligned-table">
                <thead>
                  <tr>
                    <th>S. No.</th>
                    <th>Product Name</th>
                    <th>User Name</th>
                    <th>Email</th>
                    <th>Details</th>
                  </tr>
                </thead>
                <tbody>
                <?php $i=0; foreach ($products as $products) { $i++;
                  ?>
                  <tr>
                     <td><?php echo $i; ?></td>
                     <td><?php echo $products->name; ?></td>
                     <td><?php echo $products->userName; ?></td>
                     <td><?php echo $products->email; ?></td>
                     <td><?php echo $products->details; ?></td>
                  </tr>
                <?php } ?>      
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>


    <div class="row">
      <div class="col-12 grid-margin">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title mb-4">Recent Added Post Request</h5>
            <div class="table-responsive">
              <table class="table center-aligned-table">
                <thead>
                  <tr>
                    <th>S. No.</th>
                     <th>User Name</th>
                     <th>Email</th>
                    <th>Name</th>
                    <th>mobile</th>
                    <th>Category</th> 
                    <th>Sub Category</th>
                    <th>Status</th>
                  </tr>
                </thead>
               <tbody>
                <?php $i=0; foreach ($postrequests as $postrequests) { $i++;
                  ?>
                  <tr>
                     <td><?php echo $i; ?></td>
                     <td><?php echo $postrequests->userName; ?></td>
                     <td><?php echo $postrequests->email; ?></td>
                     <td><?php echo $postrequests->name; ?></td>
                    <td><?php echo $postrequests->mobile; ?></td> 
                     <td><?php echo $postrequests->categoryName; ?></td>
                    <td><?php echo $postrequests->subCategoryName; ?></td> 
                   <td><?php if($postrequests->status==1) { ?>
                     <label class="badge badge-teal">Active</label>
                     <?php } elseif($postrequests->status==0) { ?>
                     <label class="badge badge-danger">Deactive</label>
                  
                     <?php } ?></td> 
                  </tr>
                <?php } ?>      
                </tbody> 
              </table>
            </div>
          </div>
        </div>
      </div>
    </div> 

<!-- content-wrapper ends -->

 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    $(function() {
    'use strict';
    <?php
    $month='';
    $count='';
    $totaldata=count($monthly_user);
    foreach($monthly_user as  $data ) {
      
       $m= $data['month'];
       $c= $data['count'];
       $month.="'".$m."'".',';
       $count.="'".$c."'".',';   
    }
    $mi= rtrim($month,',');
    $co= rtrim($count,',');
?>
    var data = {
    labels: [<?php echo $mi; ?>],
    datasets: [{
      label: '# of Users',
      data: [<?php echo $co; ?>],
      backgroundColor: [
        'rgba(255, 99, 132, 0.2)',
        'rgba(54, 162, 235, 0.2)',
        'rgba(255, 206, 86, 0.2)',
        'rgba(75, 192, 192, 0.2)',
        'rgba(153, 102, 255, 0.2)',
        'rgba(255, 159, 64, 0.2)'
      ],
      borderColor: [
        'rgba(255,99,132,1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(75, 192, 192, 1)',
        'rgba(153, 102, 255, 1)',
        'rgba(255, 159, 64, 1)'
      ],
      borderWidth: 1
    }]
  };
 
  var options = {
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero: true
        }
      }]
    },
    legend: {
      display: false
    },
    elements: {
      point: {
        radius: 0
      }
    }

  };
  var doughnutPieData = {
    datasets: [{
      data: [<?php echo $deactive_user; ?>, <?php echo $active_user;?>],
      backgroundColor: [
        'rgba(255, 99, 132, 0.5)',
        'rgba(54, 162, 235, 0.5)',
        'rgba(255, 206, 86, 0.5)',
        'rgba(75, 192, 192, 0.5)',
        'rgba(153, 102, 255, 0.5)',
        'rgba(255, 159, 64, 0.5)'
      ],
      borderColor: [
        'rgba(255,99,132,1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(75, 192, 192, 1)',
        'rgba(153, 102, 255, 1)',
        'rgba(255, 159, 64, 1)'
      ],
    }],

    // These labels appear in the legend and in the tooltips when hovering different arcs
    labels: [
      'Deactivated Users',
      'Active Users',
    ]
  };
  var doughnutPieOptions = {
    responsive: true,
    animation: {
      animateScale: true,
      animateRotate: true
    }
  };

  var multiAreaOptions = {
    plugins: {
      filler: {
        propagate: true
      }
    },
    elements: {
      point: {
        radius: 0
      }
    },
    scales: {
      xAxes: [{
        gridLines: {
          display: false
        }
      }],
      yAxes: [{
        gridLines: {
          display: false
        }
      }]
    }
  }

  var scatterChartData = {
    datasets: [{
        label: 'First Dataset',
        data: [{
            x: -10,
            y: 0
          },
          {
            x: 0,
            y: 3
          },
          {
            x: -25,
            y: 5
          },
          {
            x: 40,
            y: 5
          }
        ],
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)'
        ],
        borderColor: [
          'rgba(255,99,132,1)'
        ],
        borderWidth: 1
      },
      {
        label: 'Second Dataset',
        data: [{
            x: 10,
            y: 5
          },
          {
            x: 20,
            y: -30
          },
          {
            x: -25,
            y: 15
          },
          {
            x: -10,
            y: 5
          }
        ],
        backgroundColor: [
          'rgba(54, 162, 235, 0.2)',
        ],
        borderColor: [
          'rgba(54, 162, 235, 1)',
        ],
        borderWidth: 1
      }
    ]
  }

  var scatterChartOptions = {
    scales: {
      xAxes: [{
        type: 'linear',
        position: 'bottom'
      }]
    }
  }
  // Get context with jQuery - using jQuery's .get() method.
  if ($("#barChart").length) {
    var barChartCanvas = $("#barChart").get(0).getContext("2d");
    // This will get the first returned node in the jQuery collection.
    var barChart = new Chart(barChartCanvas, {
      type: 'bar',
      data: data,
      options: options
    });
  }

  if ($("#lineChart").length) {
    var lineChartCanvas = $("#lineChart").get(0).getContext("2d");
    var lineChart = new Chart(lineChartCanvas, {
      type: 'line',
      data: data,
      options: options
    });
  }

  if ($("#linechart-multi").length) {
    var multiLineCanvas = $("#linechart-multi").get(0).getContext("2d");
    var lineChart = new Chart(multiLineCanvas, {
      type: 'line',
      data: multiLineData,
      options: options
    });
  }

  if ($("#areachart-multi").length) {
    var multiAreaCanvas = $("#areachart-multi").get(0).getContext("2d");
    var multiAreaChart = new Chart(multiAreaCanvas, {
      type: 'line',
      data: multiAreaData,
      options: multiAreaOptions
    });
  }

  if ($("#doughnutChart").length) {
    var doughnutChartCanvas = $("#doughnutChart").get(0).getContext("2d");
    var doughnutChart = new Chart(doughnutChartCanvas, {
      type: 'doughnut',
      data: doughnutPieData,
      options: doughnutPieOptions
    });
  }

  if ($("#pieChart").length) {
    var pieChartCanvas = $("#pieChart").get(0).getContext("2d");
    var pieChart = new Chart(pieChartCanvas, {
      type: 'pie',
      data: doughnutPieData,
      options: doughnutPieOptions
    });
  }

  if ($("#areaChart").length) {
    var areaChartCanvas = $("#areaChart").get(0).getContext("2d");
    var areaChart = new Chart(areaChartCanvas, {
      type: 'line',
      data: areaData,
      options: areaOptions
    });
  }

  if ($("#scatterChart").length) {
    var scatterChartCanvas = $("#scatterChart").get(0).getContext("2d");
    var scatterChart = new Chart(scatterChartCanvas, {
      type: 'scatter',
      data: scatterChartData,
      options: scatterChartOptions
    });
  }

  if ($("#browserTrafficChart").length) {
    var doughnutChartCanvas = $("#browserTrafficChart").get(0).getContext("2d");
    var doughnutChart = new Chart(doughnutChartCanvas, {
      type: 'doughnut',
      data: browserTrafficData,
      options: doughnutPieOptions
    });
  }
});


 (function($) {
  'use strict';
  $(function() {


  });
})(jQuery);
</script>