$(document).ready(function() {
	$('.navigation ul li').each(function() {
		var that = this;
		var link = $(this).find('a');
		var target = $(link).attr('data-target');
		
		link.click(function() {
			$("#" + target).toggleClass('hidden');
		});
	});
	
	$('.chart-container').each(function() {
		var $that = $(this);
		var data = eval($that.attr('data'));
		var name = $that.attr('name');

		new Highcharts.Chart({
			chart: {
				renderTo: $('.chart', $that)[0],
				defaultSeriesType: 'spline',
			},
			title: {
				text: null
			},
			xAxis: {
				type: 'datetime'
			},
			yAxis: {
				title: null
			},
			series: [{
				name: name, 
				data: data
			}]
		});	
	});
});
