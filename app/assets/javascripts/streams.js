function sticky(){
    $('.sticky').click(function(){
        stream_id = $('.post-stream').attr('id')

        $.ajax({
            type: "POST",
            url: '/board/:/streams/sticky',
            data: {stream: stream_id},
            success:{

            }
        })
    });
}
