function vote(){
    $('.vote-up').click(function(){
        post_id = $(this).parent().parent().parent().attr('id');
        stream_id = $(this).parent().parent().parent().parent().attr('id')
        board_id = $(this).parent().parent().parent().parent().parent().attr('id')
        $.ajax({
            type: "POST",
            url: '/board/' + board_id + '/streams/' + stream_id + '/post/' + post_id + '/votes/create',
            data: {vote: 1},
            success:{

            }
        })

    });


    $('.vote-down').click(function(){
        post_id = $(this).parent().parent().parent().attr('id');
        stream_id = $(this).parent().parent().parent().parent().attr('id')
        board_id = $(this).parent().parent().parent().parent().parent().attr('id')
        $.ajax({
            type: "POST",
            url: '/board/' + board_id + '/streams/' + stream_id + '/post/' + post_id + '/votes/create',
            data: {vote: -1},
            success:{

            }
        })
    });

}
