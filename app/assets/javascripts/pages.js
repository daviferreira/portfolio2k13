/*jslint browser:true */
/*global window*/
/*global jQuery */

(function (window, document, $) {
    'use strict';

    var carrosselCover, cover, coverInterval, coverTimer,
        currentIndex, currentPost, html, i, latestPosts,
        nav, navigate, paginateCover, posts, postsNavigation,
        sections, timer;

    posts = $('.post');

    if (posts.length > 0) {
        timer = '';
        latestPosts = $('#latest-posts');
        postsNavigation = $('#latest-posts-navigation');
        currentPost = 0;
        navigate = function() {
            currentPost += 1;
            if (currentPost === posts.length) {
                currentPost = 0;
            }
            latestPosts.css('margin-left', -1 * currentPost * 565);
            postsNavigation.find('a').removeClass('current');
            return postsNavigation.find('a:eq(' + currentPost + ')').addClass('current');
        };
        timer = setInterval(navigate, 10000);
        html = '';
        if (posts.length > 1) {
            for (i = 0; i < posts.length; i += 1) {
                html += '<a href="#"' + (i === 0 ? ' class="current"' : '') + ' data-index="' + i + '">&bull;</a>';
            }
        }
        postsNavigation.html(html);
        $('.post').hover(function() {
            return clearInterval(timer);
        }, function() {
            return (timer = setInterval(navigate, 10000));
        });
        postsNavigation.on('click', 'a', function(e) {
            e.preventDefault();
            clearInterval(timer);
            currentPost = $(this).index() - 1;
            navigate();
            return (timer = setInterval(navigate, 10000));
        });
    }

    cover = $('#cover');

    sections = cover.find('section');

    nav = $('#cover-navigation');

    coverTimer = '';

    currentIndex = 0;

    coverInterval = 10000;

    carrosselCover = function(init) {
        var width;
        width = $(window).width();
        if (width < 1170) {
            width = 1170;
        }
        cover.width(sections.length * width);
        sections.width(width);
        if (init === true) {
            html = '';
            cover.slideDown(400);
            if (sections.length > 1) {
                for (i = 0;  i < sections.length; i += 1) {
                    html += '<a href="#"' + (i === 0 ? ' class="current"' : '') + ' data-index="' + i + '">&bull;</a>';
                }
            }
            nav.html(html);
            return nav.find('a').click(function(e) {
                clearInterval(coverTimer);
                e.preventDefault();
                paginateCover($(this).data('index'));
                return (coverTimer = setInterval(function() {
                    return (paginateCover(currentIndex + 1));
                }, coverInterval));
            });
        }
    };

    paginateCover = function(index) {
        if (index > (sections.length - 1)) {
            index = 0;
        }
        nav.find('.current').removeClass('current');
        nav.find('[data-index="' + index + '"]').addClass('current');
        cover.css('margin-left', -(index * $(window).width()));
        return (currentIndex = index);
    };

    sections.find('container').hover(function() {
        return clearInterval(coverTimer);
    }, function() {
        return (coverTimer = setInterval(function() {
            return (paginateCover(currentIndex + 1));
        }, coverInterval));
    });

    coverTimer = setInterval(function() {
        return (paginateCover(currentIndex + 1));
    }, coverInterval);

    carrosselCover(true);

    $(window).resize(function() {
        return carrosselCover(false);
    });

}(window, document, jQuery));
