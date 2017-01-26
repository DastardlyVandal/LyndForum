function vote(){
    $('.vote-up').click(function(){
        post_id = $(this).attr('id');
        $.ajax({
            type: "POST",
            url: '/board/:/streams/:/post/:/votes/create',
            data: {vote: 1, post: post_id},
            success:{

            }
        })

    });


    $('.vote-down').click(function(){
        post_id = $(this).attr('id');
        $.ajax({
            type: "POST",
            url: '/board/:/streams/:/post/:/votes/create',
            data: {vote: -1, post: post_id},
            success:{

            }
        })
    });

}
