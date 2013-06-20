works = $('#row-works')
if works.length > 0
    worksOffset = works.offset().top + 50
    time = 40

    showHover = (el, time) ->
      setTimeout -> 
        $(el).addClass('hover')
        setTimeout ->
          $(el).removeClass('hover')
        , time + 30
      , time

    $(window).bind 'scroll.works', ->
      if $(this).scrollTop() + $(this).height() > worksOffset
        setTimeout ->
          works.find('a').each (i, el) ->
            showHover(el, time * (i + 1))
          $(this).unbind 'scroll.works'
        , 300

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
               postsNavigation.find('a').removeClass 'current';
               postsNavigation.find('a:eq(' + currentPost + ')').addClass 'current'

    timer = setInterval navigate, 10000

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
