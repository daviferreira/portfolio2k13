/*jslint browser:true */
/*global window, Zepto, Swipe*/

(function (window, document, $) {
    'use strict';

    $('#navicon').click(function (e) {
        e.preventDefault();
        $('#menu').toggleClass('visible');
    });

    if ($('.pages-index').length === 0) {
        return;
    }

    FastClick.attach(document.body);

    var carrosselNav,
        navProjects = $('#cover-navigation'),
        navPosts = $('#latest-posts-navigation'),
        cover = document.getElementById('cover');

    if (!cover) {
        return;
    }

    window.projectsCarrossel = new Swipe(cover, {
        disableScroll: true,
        auto: 10000,
        transitionEnd: function (index, el) {
            navProjects.find('.current').removeClass('current');
            navProjects.find('[data-index="' + index + '"]').addClass('current');
        }
    });

    window.postsCarrossel = new Swipe(document.getElementById('latest-posts'), {
        auto: 10000,
        disableScroll: true,
        transitionEnd: function (index, el) {
            navPosts.find('.current').removeClass('current');
            navPosts.find('[data-index="' + index + '"]').addClass('current');
        }
    });

    carrosselNav = function (selector, carrossel) {
        var html = '',
            i;

        for (i = 0;  i < window[carrossel].getNumSlides(); i += 1) {
            html += '<a href="#"' + (i === 0 ? ' class="current"' : '') + ' data-index="' + i + '">&bull;</a>';
        }

        return $(selector).html(html).find('a').click(function (e) {
            e.preventDefault();
            var index = $(this).data('index');
            window[carrossel].slide(index);
            $(this).parent().find('.current').removeClass('current');
            $(this).parent().find('[data-index="' + index + '"]').addClass('current');
        });
    };

    carrosselNav('#cover-navigation', 'projectsCarrossel');
    carrosselNav('#latest-posts-navigation', 'postsCarrossel');

}(window, document, Zepto));
