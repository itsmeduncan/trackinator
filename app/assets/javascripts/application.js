// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
	$('.chart-container').each(function() {
		var $that = $(this);
		var data = eval($that.attr('data'));
		var name = $that.attr('name');
		
		if($('.chart', $that).length == 0) {
			return true
		}
		
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
