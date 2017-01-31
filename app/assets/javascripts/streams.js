function sticky(){
    $('.sticky').click(function(){
        stream_id = $(this).attr('id')

        $.ajax({
            type: "POST",
            url: '/board/:/streams/sticky',
            data: {stream: stream_id},
            success:{

            }
        })
    });
}

function lock(){
    $('.lock').click(function(){
        stream_id = $(this).attr('id')

        $.ajax({
            type: "POST",
            url: '/board/:/streams/lock',
            data: {stream: stream_id},
            success:{

            }
        })
    });
}

function deleteThread(){
    $('.delete-thread').click(function(){
        stream_id = $(this).attr('id')

        if (confirm('Remove this thread?')){
            $.ajax({
                type: "POST",
                url: '/board/:/streams/delete',
                data: {stream: stream_id},
                success:{

                }
            })
        }
    });
}
