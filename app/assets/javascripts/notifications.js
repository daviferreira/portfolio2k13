/*jslint browser:true */
/*global window*/
/*global Zepto */

(function (window, document, $) {
    'use strict';

    var notification;

    notification = $('.notification');

    if (notification.length > 0) {
      notification.show();
      setTimeout(function() {
        return notification.hide();
      }, 5000);
    }

}(window, document, Zepto));
