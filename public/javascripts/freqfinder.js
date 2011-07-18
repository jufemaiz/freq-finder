/* DO NOT MODIFY. This file was compiled Mon, 18 Jul 2011 15:53:26 GMT from
 * /Users/joel/Sites/git/freqfinder/app/coffeescripts/freqfinder.coffee
 */

(function() {
  $(document).ready(function() {
    var canvas, map, myOptions;
    myOptions = {
      zoom: 4,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      center: new google.maps.LatLng(-24.3, 133.9)
    };
    if (document.URL.match(/\/(stations|transmitters)\/\d+/)) {
      canvas = $("#mapCanvas");
      canvas.css({
        "display": "block"
      });
      map = new google.maps.Map($("#map")[0], myOptions);
      $.getJSON("", function(data) {
        var bounds, location, marker, markerClusterer, markers, station, transmitter, _fn, _i, _len, _ref;
        if (data.transmitter !== void 0) {
          transmitter = data.transmitter;
          location = new google.maps.LatLng(transmitter.lat, transmitter.lng);
          marker = new google.maps.Marker({
            map: map,
            position: location,
            title: transmitter.station.title + " @ " + transmitter.frequency
          });
          map.setCenter(location);
          map.setZoom(12);
        } else if (data.station !== void 0) {
          station = data.station;
          bounds = new google.maps.LatLngBounds();
          markers = [];
          _ref = station.transmitters;
          _fn = function(transmitter) {
            var _title;
            location = new google.maps.LatLng(transmitter.lat, transmitter.lng);
            bounds.extend(location);
            _title = station.title + " @ " + transmitter.frequency.toString();
            marker = new google.maps.Marker({
              position: location,
              title: _title
            });
            google.maps.event.addListener(marker, 'click', function() {
              document.location = "/transmitters/" + transmitter.id;
              return false;
            });
            markers.push(marker);
            return false;
          };
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            transmitter = _ref[_i];
            _fn(transmitter);
          }
          markerClusterer = new MarkerClusterer(map, markers);
          map.fitBounds(bounds);
          if (map.getZoom() > 12) {
            map.setZoom(12);
          }
        }
        return false;
      });
    }
    false;
    if ($('div.search').length > 0) {
      $('form').submit(function(eventObject) {
        var browserSupportFlag;
        console.log(eventObject);
        if (navigator.geolocation) {
          browserSupportFlag = true;
          navigator.geolocation.getCurrentPosition(function(position) {
            $('<input>').attr({
              type: 'hidden',
              id: 'latlng',
              name: 'latlng',
              value: position.coords.latitude + "," + position.coords.longitude
            }).appendTo('form');
            return true;
          }, function() {
            handleNoGeolocation(browserSupportFlag);
            return false;
          });
          false;
        } else {
          browserSupportFlag = false;
          handleNoGeolocation(browserSupportFlag);
        }
        return false;
      });
      return false;
    }
  });
}).call(this);
