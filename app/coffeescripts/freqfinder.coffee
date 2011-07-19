# Load the Visualization API and the columnchart package.
google.load("visualization", "1", {packages: ["imagechart"]});

$(document).ready ->
	myOptions = {
		zoom: 4,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		center: new google.maps.LatLng(-24.3, 133.9)
	}
	icons = { transmitter : new google.maps.MarkerImage('/images/icons/transmitter.png'), location : new google.maps.MarkerImage('/images/icons/location.png') }
	if document.URL.match(/\/(stations\/\d+|transmitters)/)
		canvas = $("#mapCanvas")
		canvas.css({"display":"block"})
		map = new google.maps.Map($("#map")[0], myOptions)
		
		if $('span.latlng').length > 0
			console.log $('span.latlng')

		$.getJSON "", (data) ->
			if data.transmitter != undefined
				transmitter = data.transmitter
				location = new google.maps.LatLng(transmitter.lat,transmitter.lng)
				marker = new google.maps.Marker({ map:map, position:location, title: "#{transmitter.station.title} @ #{transmitter.frequency} #{transmitter.band}", icon : icons.transmitter })
				if decodeURIComponent(document.URL).match(/latlng=(-?\d+\.\d+),(-?\d+\.\d+)/)
					bounds = new google.maps.LatLngBounds()
					bounds.extend(location)
					path = []
					path.push(location)

					matches = decodeURIComponent(document.URL).match(/latlng=(-?\d+\.\d+),(-?\d+\.\d+)/)
					location = new google.maps.LatLng(matches[1],matches[2])
					marker = new google.maps.Marker({ map:map, position:location, title: "Your location.", icon : icons.location })
					bounds.extend(location)
					path.push(location)

					map.fitBounds(bounds)
					map.setZoom(12) if map.getZoom() > 12
					
					# TODO: Now we just need to also do the elevation mapping!
					elevator = new google.maps.ElevationService()
					# Create a new chart in the elevation_chart DIV.
					chart = new google.visualization.ImageChart($('#elevation')[0])
					pathRequest = { 'path': path, 'samples': 256 }
					elevator.getElevationAlongPath pathRequest, (results,status) ->
						if (status == google.maps.ElevationStatus.OK)
					    	elevations = results

							# Extract the data from which to populate the chart.
							# Because the samples are equidistant, the 'Sample' column here does double duty as distance along the X axis.
							data = new google.visualization.DataTable()
							data.addColumn('number', '')
							
							for i in [0...results.length]
								do (i) ->
									e = results[i].elevation
									e += transmitter.antenna_height if i == 0
									data.addRow([e])
							
							# Draw the chart using the data within its DIV.
							$('#elevation').css({'display':'block'})
							   
							options = {chdl:null, chxs:"0,333333,10.5,0,l,67676700",chxt:"y", chs:"470x200",cht:"lc",chco:"3366CC",chls:"2,4,0",chma:"30,10,10,10,0,0",chm:"B,C3D9FF,0,0,0",chtt:"Elevation (m)",chts:"333333,11.5"};
							chart.draw(data,options);
							
							true
					
				else
					map.setCenter(location)
					map.setZoom(12)
			else if data.station != undefined
				station = data.station
				bounds = new google.maps.LatLngBounds()
				markers = []
				for transmitter in station.transmitters
					do (transmitter) ->
						location = new google.maps.LatLng(transmitter.lat,transmitter.lng)
						bounds.extend(location)
						marker = new google.maps.Marker({ position:location, title: "#{station.title} @ #{transmitter.frequency} #{transmitter.band}", icon : icons.transmitter })
						google.maps.event.addListener marker, 'click', () ->
							latlng = ""
							if decodeURIComponent(document.URL).match(/latlng=(-?\d+\.\d+-?\d+\.\d+)/)
								latlng += "?latlng=#{decodeURIComponent(document.URL).match(/latlng=(-?\d+\.\d+-?\d+\.\d+)/)[1]}"
							document.location = "/transmitters/#{transmitter.id}#{latlng}"
							false
						markers.push marker
						false
				markerClusterer = new MarkerClusterer(map,markers)
				map.fitBounds(bounds)
				map.setZoom(12) if map.getZoom() > 12
			else if data.length > 0
				bounds = new google.maps.LatLngBounds()
				markers = []
				for o in data
					do (o) ->
						transmitter = o.transmitter
						location = new google.maps.LatLng(transmitter.lat,transmitter.lng)
						bounds.extend(location)
						marker = new google.maps.Marker({ position:location, title: "#{transmitter.station.title} @ #{transmitter.frequency} #{transmitter.band}", icon : icons.transmitter })
						google.maps.event.addListener marker, 'click', () ->
							latlng = ""
							if decodeURIComponent(document.URL).match(/latlng=(-?\d+\.\d+-?\d+\.\d+)/)
								latlng += "?latlng=#{decodeURIComponent(document.URL).match(/latlng=(-?\d+\.\d+-?\d+\.\d+)/)[1]}"
							document.location = "/transmitters/#{transmitter.id}#{latlng}"
							false
						markers.push marker
						false
				markerClusterer = new MarkerClusterer(map,markers)
				map.fitBounds(bounds)
				map.setZoom(12) if map.getZoom() > 12
			false
	false
	
	if $('div.search').length > 0
		$('form.geolocation').submit (eventObject) ->
			# Try W3C Geolocation (Preferred)
			if navigator.geolocation
				browserSupportFlag = true
				navigator.geolocation.getCurrentPosition(
					(position) ->
						window.location.replace("/transmitters/?latlng="+position.coords.latitude+","+position.coords.longitude)
						true
					, () ->
						alert("No geo support - try the search options.	")
						$('form.geolocation').remove()
						false
				)
				false
			# Browser doesn't support Geolocation
			else
				browserSupportFlag = false
				handleNoGeolocation(browserSupportFlag)
			false
		false
		
		