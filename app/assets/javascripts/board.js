function lockBoard(){
    $('.lock').click(function(){
        board_id = $(this).attr('id')

        $.ajax({
            type: "POST",
            url: '/board/lock',
            data: {board: board_id},
            success:{

            }
        })
    });
}

function deleteBoard(){
    $('.delete').click(function(){
        board_id = $(this).attr('id')
        alert(board_id)

        $.ajax({
            type: "POST",
            url: '/board/delete',
            data: {board: board_id},
            success:{

            }
        })
    });
}
