posts = $('.post')
if posts.length > 0
    timer = ''
    latestPosts = $('#latest-posts')
    postsNavigation = $('#latest-posts-navigation')
    currentPost = 0
    navigate = ->
               currentPost += 1
               if currentPost == posts.length
                   currentPost = 0
               latestPosts.css 'margin-left', -1 * currentPost * 565
               postsNavigation.find('a').removeClass 'current'
               postsNavigation.find('a:eq(' + currentPost + ')').addClass 'current'

    timer = setInterval navigate, 10000

    html = ''
    if posts.length > 1
        for i in [0...posts.length]
            html += '<a href="#"' + (if i == 0 then ' class="current"' else '') + ' data-index="' + i + '">&bull;</a>'

    postsNavigation.html html

    $('.post').hover ->
        clearInterval timer
    , ->
        timer = setInterval navigate, 10000
    postsNavigation.on 'click', 'a', (e) ->
        e.preventDefault()
        clearInterval timer
        currentPost = $(this).index() - 1
        navigate()
        timer = setInterval navigate, 10000

cover = $('#cover')
sections = cover.find('section')
nav = $('#cover-navigation')
coverTimer = ''
currentIndex = 0
coverInterval = 10000

carrosselCover = (init) ->
    width = $(window).width()

    if width < 1170
        width = 1170

    cover.width sections.length * width
    sections.width width
    if init == true
        html = ''
        cover.slideDown 400
        if sections.length > 1
            for i in [0...sections.length]
                html += '<a href="#"' + (if i == 0 then ' class="current"' else '') + ' data-index="' + i + '">&bull;</a>'
        nav.html html
        nav.find('a').click (e) ->
            clearInterval coverTimer
            e.preventDefault()
            paginateCover $(this).data('index')
            coverTimer = setInterval -> 
                            paginateCover(currentIndex + 1)
                         , coverInterval

paginateCover = (index) ->
    if index > (sections.length - 1)
        index = 0
    nav.find('.current').removeClass 'current'
    nav.find('[data-index="' + index + '"]').addClass 'current'
    cover.css 'margin-left', -(index * $(window).width())
    currentIndex = index

sections.find('container').hover ->
    clearInterval coverTimer
, ->
    coverTimer = setInterval -> 
                    paginateCover(currentIndex + 1)
                 , coverInterval

coverTimer = setInterval -> 
                paginateCover(currentIndex + 1)
             , coverInterval

carrosselCover true

$(window).resize ->
    carrosselCover false
