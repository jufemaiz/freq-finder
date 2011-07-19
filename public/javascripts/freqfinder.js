/* DO NOT MODIFY. This file was compiled Tue, 19 Jul 2011 02:21:28 GMT from
 * /Users/joel/Sites/git/freqfinder/app/coffeescripts/freqfinder.coffee
 */

(function() {
  google.load("visualization", "1", {
    packages: ["imagechart"]
  });
  $(document).ready(function() {
    var canvas, icons, map, myOptions;
    myOptions = {
      zoom: 4,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      center: new google.maps.LatLng(-24.3, 133.9)
    };
    icons = {
      transmitter: new google.maps.MarkerImage('/images/icons/transmitter.png'),
      location: new google.maps.MarkerImage('/images/icons/location.png')
    };
    if (document.URL.match(/\/(stations\/\d+|transmitters)/)) {
      canvas = $("#mapCanvas");
      canvas.css({
        "display": "block"
      });
      map = new google.maps.Map($("#map")[0], myOptions);
      if ($('span.latlng').length > 0) {
        console.log($('span.latlng'));
      }
      $.getJSON("", function(data) {
        var bounds, chart, elevator, location, marker, markerClusterer, markers, matches, o, path, pathRequest, station, transmitter, _fn, _fn2, _i, _j, _len, _len2, _ref;
        if (data.transmitter !== void 0) {
          transmitter = data.transmitter;
          location = new google.maps.LatLng(transmitter.lat, transmitter.lng);
          marker = new google.maps.Marker({
            map: map,
            position: location,
            title: "" + transmitter.station.title + " @ " + transmitter.frequency + " " + transmitter.band,
            icon: icons.transmitter
          });
          if (decodeURIComponent(document.URL).match(/latlng=(-?\d+\.\d+),(-?\d+\.\d+)/)) {
            bounds = new google.maps.LatLngBounds();
            bounds.extend(location);
            path = [];
            path.push(location);
            matches = decodeURIComponent(document.URL).match(/latlng=(-?\d+\.\d+),(-?\d+\.\d+)/);
            location = new google.maps.LatLng(matches[1], matches[2]);
            marker = new google.maps.Marker({
              map: map,
              position: location,
              title: "Your location.",
              icon: icons.location
            });
            bounds.extend(location);
            path.push(location);
            map.fitBounds(bounds);
            if (map.getZoom() > 12) {
              map.setZoom(12);
            }
            elevator = new google.maps.ElevationService();
            chart = new google.visualization.ImageChart($('#elevation')[0]);
            pathRequest = {
              'path': path,
              'samples': 256
            };
            elevator.getElevationAlongPath(pathRequest, function(results, status) {
              var elevations, i, options, _fn, _ref;
              if (status === google.maps.ElevationStatus.OK) {
                elevations = results;
              }
              data = new google.visualization.DataTable();
              data.addColumn('number', '');
              _fn = function(i) {
                var e;
                e = results[i].elevation;
                if (i === 0) {
                  e += transmitter.antenna_height;
                }
                return data.addRow([e]);
              };
              for (i = 0, _ref = results.length; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
                _fn(i);
              }
              $('#elevation').css({
                'display': 'block'
              });
              options = {
                chdl: null,
                chxs: "0,333333,10.5,0,l,67676700",
                chxt: "y",
                chs: "470x200",
                cht: "lc",
                chco: "3366CC",
                chls: "2,4,0",
                chma: "30,10,10,10,0,0",
                chm: "B,C3D9FF,0,0,0",
                chtt: "Elevation (m)",
                chts: "333333,11.5"
              };
              chart.draw(data, options);
              return true;
            });
          } else {
            map.setCenter(location);
            map.setZoom(12);
          }
        } else if (data.station !== void 0) {
          station = data.station;
          bounds = new google.maps.LatLngBounds();
          markers = [];
          _ref = station.transmitters;
          _fn = function(transmitter) {
            location = new google.maps.LatLng(transmitter.lat, transmitter.lng);
            bounds.extend(location);
            marker = new google.maps.Marker({
              position: location,
              title: "" + station.title + " @ " + transmitter.frequency + " " + transmitter.band,
              icon: icons.transmitter
            });
            google.maps.event.addListener(marker, 'click', function() {
              var latlng;
              latlng = "";
              if (decodeURIComponent(document.URL).match(/latlng=(-?\d+\.\d+-?\d+\.\d+)/)) {
                latlng += "?latlng=" + (decodeURIComponent(document.URL).match(/latlng=(-?\d+\.\d+-?\d+\.\d+)/)[1]);
              }
              document.location = "/transmitters/" + transmitter.id + latlng;
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
        } else if (data.length > 0) {
          bounds = new google.maps.LatLngBounds();
          markers = [];
          _fn2 = function(o) {
            transmitter = o.transmitter;
            location = new google.maps.LatLng(transmitter.lat, transmitter.lng);
            bounds.extend(location);
            marker = new google.maps.Marker({
              position: location,
              title: "" + transmitter.station.title + " @ " + transmitter.frequency + " " + transmitter.band,
              icon: icons.transmitter
            });
            google.maps.event.addListener(marker, 'click', function() {
              var latlng;
              latlng = "";
              if (decodeURIComponent(document.URL).match(/latlng=(-?\d+\.\d+-?\d+\.\d+)/)) {
                latlng += "?latlng=" + (decodeURIComponent(document.URL).match(/latlng=(-?\d+\.\d+-?\d+\.\d+)/)[1]);
              }
              document.location = "/transmitters/" + transmitter.id + latlng;
              return false;
            });
            markers.push(marker);
            return false;
          };
          for (_j = 0, _len2 = data.length; _j < _len2; _j++) {
            o = data[_j];
            _fn2(o);
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
      $('form.geolocation').submit(function(eventObject) {
        var browserSupportFlag;
        if (navigator.geolocation) {
          browserSupportFlag = true;
          navigator.geolocation.getCurrentPosition(function(position) {
            window.location.replace("/transmitters/?latlng=" + position.coords.latitude + "," + position.coords.longitude);
            return true;
          }, function() {
            alert("No geo support - try the search options.	");
            $('form.geolocation').remove();
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
