// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

function showAdmin(){
    $('.admin-button').click(function(){
        if ( $('.admin-tools').hasClass('admining') ){
            $('.admin-tools').removeClass('admining');
            $('.admin-tools').addClass('hidden');
        } else {
            $('.admin-tools').removeClass('hidden');
            $('.admin-tools').addClass('admining');
        }
    });
}

function hideTopNav(){
    $(window).scroll(function() {
        if ($(window).width() <= 768) {
            if ($(this).scrollTop()>0)
             {
                $('.navbar-fixed-top').fadeOut();
             }
            else
             {
              $('.navbar-fixed-top').fadeIn();
             }
         }
         });
}

function deletePost(){
    $('.delete-post').click(function(){
        post_id = $(this).attr('id');

        $.ajax({
            type: "POST",
            url: '/board/:/streams/:/post/delete',
            data: {post: post_id},
            success:{

            }
        })

    });
}

function ignoreReport(){
    $('.ignore-report').click(function(){
        post_id = $(this).attr('id');

        $.ajax({
            type: "POST",
            url: '/board/:/streams/:/post/ignore',
            data: {post: post_id},
            success:{

            }
        })

    });
}
