/*jslint browser:true */
/*global window*/
/*global Zepto */

(function (window, document, $) {
    'use strict';

    if ($('.projects-index').length === 0) {
        return;
    }

    var currentYear = parseInt($('ul[data-year]').first().data('year'), 10),
        title = $('#year-title'),
        timerScroll,
        year,
        changeYear = function changeYear() {
            var scrollTop = $(this).scrollTop() - 133,
                hasYear = false;
            $('ul[data-year]').each(function () {
                year = parseInt($(this).data('year'), 10);
                if ($(this).offset().top > scrollTop && hasYear !== true) {
                    hasYear = true;
                    if (year !== currentYear) {
                        title.html(year);
                        currentYear = year;
                    }
                }
            });
        };

    $(window).scroll(function () {
        clearTimeout(timerScroll);
        timerScroll = setTimeout(changeYear, 100);
    });

    $('.projects-list').find('ul').each(function () {
        var height = 0;
        $(this).find('li').each(function () {
            if ($(this).height() > height) {
                height = $(this).height();
            }
        }).height(height);
    });

}(window, document, Zepto));
