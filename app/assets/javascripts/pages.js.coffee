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

###
title = $('#page-title')
titleOffset = title.offset().top + 88
content = $('#l-content')
isFixed = false

$(window).bind 'scroll.title', ->
  if $(this).scrollTop() > titleOffset
    if isFixed == false
      title.addClass 'fixed'
      slides.addClass 'pos-fixed'
      isFixed = true
  else
    if isFixed == true
      title.removeClass 'fixed'
      slides.removeClass 'pos-fixed'
      isFixed = false
###
