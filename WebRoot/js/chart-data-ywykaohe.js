var randomScalingFactor = function(){ return Math.round(Math.random()*1000)};

var randomScalingFactorFill = function(){ return Math.random()*80};
var randomScalingFactorBarchart = function(){ return Math.round(Math.random()*100000)};

	var lineChartData = {
			labels : ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"],
			datasets : [
				{
					label: "去年同期",
					fillColor : "rgba(180,180,180,0.3)",
					strokeColor : "rgba(180,180,180,1)",
					pointColor : "rgba(180,180,180,1)",
					pointStrokeColor : "#fff",
					pointHighlightFill : "#fff",
					pointHighlightStroke : "rgba(180,180,180,1)",
					data : [100000,100000,100000,100000,100000,100000]
				},
				{
					label: "目前数据",
					fillColor : "rgba(48, 164, 255, 0.3)",
					strokeColor : "rgba(48, 164, 255, 1)",
					pointColor : "rgba(48, 164, 255, 1)",
					pointStrokeColor : "#fff",
					pointHighlightFill : "#fff",
					pointHighlightStroke : "rgba(48, 164, 255, 1)",
					data : [randomScalingFactorFill(),randomScalingFactorFill(),randomScalingFactorFill(),randomScalingFactorFill(),randomScalingFactorFill(),randomScalingFactorFill(),randomScalingFactorFill(),randomScalingFactorFill(),randomScalingFactorFill(),randomScalingFactorFill(),randomScalingFactorFill(),randomScalingFactorFill()]
				}
			]

		}
		
	var barChartData_1 = {
			labels : ["1月","2月","3月","4月","5月","6月"],
			datasets : [
				{
					fillColor : "rgba(48, 164, 255, 0.2)",
					strokeColor : "rgba(48, 164, 255, 0.8)",
					highlightFill : "rgba(48, 164, 255, 0.75)",
					highlightStroke : "rgba(48, 164, 255, 1)",
					data : [randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart()]
				}
			]
	
		}
	
	var barChartData_resource = {
			labels : ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"],
			datasets : [
				{
					fillColor : "rgba(200,200,200,0.5)",
					strokeColor : "rgba(200,200,200,0.8)",
					highlightFill: "rgba(200,200,200,0.75)",
					highlightStroke: "rgba(200,200,200,1)",
					data : [randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart()]
				},
				{
					fillColor : "rgba(48, 164, 255, 0.2)",
					strokeColor : "rgba(48, 164, 255, 0.8)",
					highlightFill : "rgba(48, 164, 255, 0.75)",
					highlightStroke : "rgba(48, 164, 255, 1)",
					data : [randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart()]
				}
			]
	
		}
		
	var barChartData = {
			labels : ["1月","2月","3月","4月","5月","6月"],
			datasets : [
				{
					fillColor : "rgba(180,180,180,0.5)",
					strokeColor : "rgba(180,180,180,1)",
					highlightFill : "rgba(180,180,180, 0.75)",
					highlightStroke : "rgba(180,180,180, 1)",
					data : [100000,100000,100000,100000,100000,100000]
				},
				{
					fillColor : "rgba(48, 164, 255, 0.2)",
					strokeColor : "rgba(48, 164, 255, 0.8)",
					highlightFill : "rgba(48, 164, 255, 0.75)",
					highlightStroke : "rgba(48, 164, 255, 1)",
					data : [randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart(),randomScalingFactorBarchart()]
				}
			]
	
		}
	var pieData = [
				{
					value: 60,
					color:"#30a5ff",
					highlight: "#62b9fb",
					label: "互联网/网站"
				},
				{
					value: 4,
					color: "#ffb53e",
					highlight: "#fac878",
					label: "IT"
				},
				{
					value: 8,
					color: "#1ebfae",
					highlight: "#3cdfce",
					label: "其他"
				},
				{
					value: 28,
					color: "#f9243f",
					highlight: "#f6495f",
					label: "房地产"
				}
			];
			
	var doughnutData = [
					{
						value: 300,
						color:"#30a5ff",
						highlight: "#62b9fb",
						label: "Blue"
					},
					{
						value: 50,
						color: "#ffb53e",
						highlight: "#fac878",
						label: "Orange"
					},
					{
						value: 100,
						color: "#1ebfae",
						highlight: "#3cdfce",
						label: "Teal"
					},
					{
						value: 120,
						color: "#f9243f",
						highlight: "#f6495f",
						label: "Red"
					}
	
				];

window.onload = function(){
	var chart1 = document.getElementById("line-chart").getContext("2d");
	window.myLine = new Chart(chart1).Line(lineChartData, {
		responsive: true
	});
	var chart2 = document.getElementById("bar-chart").getContext("2d");
	window.myBar = new Chart(chart2).Bar(barChartData, {
		responsive : true
	});
	var chart3 = document.getElementById("doughnut-chart").getContext("2d");
	window.myDoughnut = new Chart(chart3).Doughnut(doughnutData, {responsive : true
	});
	var chart4 = document.getElementById("pie-chart").getContext("2d");
	window.myPie = new Chart(chart4).Pie(pieData, {responsive : true
	});
	
};