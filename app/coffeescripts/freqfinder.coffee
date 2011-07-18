$(document).ready ->
	myOptions = {
		zoom: 4,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		center: new google.maps.LatLng(-24.3, 133.9)
	}
	if document.URL.match(/\/(stations|transmitters)\/\d+/)
		canvas = $("#mapCanvas")
		canvas.css({"display":"block"})
		map = new google.maps.Map($("#map")[0], myOptions)

		$.getJSON "", (data) ->
			if data.transmitter != undefined
				transmitter = data.transmitter
				location = new google.maps.LatLng(transmitter.lat,transmitter.lng)
				marker = new google.maps.Marker({ map:map, position:location, title: transmitter.station.title + " @ " + transmitter.frequency })
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
						_title = station.title + " @ " + transmitter.frequency.toString()
						marker = new google.maps.Marker({ position:location, title: _title })
						google.maps.event.addListener marker, 'click', () ->
							document.location = "/transmitters/" + transmitter.id
							false
						markers.push marker
						false
				markerClusterer = new MarkerClusterer(map,markers)
				map.fitBounds(bounds)
				map.setZoom(12) if map.getZoom() > 12
			false
	false
	
	if $('div.search').length > 0
		$('form').submit (eventObject) ->
			console.log eventObject
			# Try W3C Geolocation (Preferred)
			if navigator.geolocation
				browserSupportFlag = true
				navigator.geolocation.getCurrentPosition(
					(position) ->
						$('<input>').attr({
						    type: 'hidden',
						    id: 'latlng',
						    name: 'latlng',
							value: position.coords.latitude+","+position.coords.longitude
						}).appendTo('form');
						true
					, () ->
						handleNoGeolocation(browserSupportFlag)
						false
				)
				false
			# Browser doesn't support Geolocation
			else
				browserSupportFlag = false
				handleNoGeolocation(browserSupportFlag)
			false
		false
		
		