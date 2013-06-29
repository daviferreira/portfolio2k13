/*jslint browser:true */
/*global window*/
/*global jQuery */

(function (window, document, $) {
    'use strict';

    var notification;

    notification = $('.notification');

    if (notification.length > 0) {
      notification.slideDown(300);
      setTimeout(function() {
        return notification.slideUp(300);
      }, 5000);
    }

}(window, document, jQuery));
