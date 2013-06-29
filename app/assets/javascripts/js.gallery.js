/*jslint browser:true */
/*global window*/
/*global Zepto */

var JSGallery = JSGallery || {};

(function (window, document, $) {
    'use strict';

    JSGallery = {
        init: function () {
            this.doc = $(document);
            this.root = $('.js-gallery');
            this.overlay = $('#js-gallery-overlay');
            this.images = [];
            this.bindActions();
        },

        bindActions: function () {
            this.bindClick();
            this.bindResize();
        },

        bindClick: function () {
            var self = this;
            this.root.find('a').click(function (e) {
                e.preventDefault();
                self.currentPhoto = $(this).attr('href');
                self.showOverlay();
            });
        },

        showOverlay: function () {
            if (this.overlay.length === 0) {
                this.overlay = this.createOverlay();
            }
            this.overlay.css('height', this.doc.height() + 'px').show();
            this.showImage();
        },

        createOverlay: function () {
            var overlay = $('<div id="js-gallery-overlay" class="js-gallery-overlay" />'),
                self = this;
            overlay.click(function (e) {
                e.preventDefault();
                self.close();
            });
            return overlay.prependTo('body');
        },

        close: function () {
            this.overlay.hide();
            $('.js-gallery-image').hide();
        },

        showImage: function () {
            var img,
                h = $(window).height() - 80,
                w;
            if (this.images.indexOf(this.currentPhoto) === -1) {
                this.images.push(this.currentPhoto);
                img = new Image();
                img.src = this.currentPhoto;
                img.onload = function () {
                    if (h > this.height) {
                        h = this.height;
                    }
                    w = Math.ceil(this.width / this.height * h);
                    $('<img src="' + this.src + '" class="js-gallery-image" />')
                        .appendTo('body')
                        .css({
                            'display': 'none',
                            'margin-left': -(w/2),
                            'margin-top': -(h/2),
                            'width': w,
                            'height': h
                        })
                        .show();
                };
            } else {
                img = $('img[src*="' + this.currentPhoto + '"]');
                if (h > img.height()) {
                    h = img.height();
                }
                w = Math.ceil(img.width() / img.height() * h);
                img.css({
                    'display': 'none',
                    'margin-left': -(w/2),
                    'margin-top': -(h/2),
                    'width': w,
                    'height': h
                }).show();
            }
        },

        bindResize: function () {
            var self = this;
            $(window).on('resize.js_gallery', function () {
                self.overlay.css({
                    'width': self.doc.width() + 'px',
                    'height': self.doc.height() + 'px'
                });
            });
        }

    };

    JSGallery.init();
}(window, document, Zepto));
