function addMod(){
    $('.make-mod').click(function(){
        user_id = $(this).attr('id')

        $.ajax({
            type: "POST",
            url: '/users/makeMod',
            data: {user: user_id, role: 1},
            success:{

            }
        })
    });

    $('.demote-mod').click(function(){
        user_id = $(this).attr('id')

        $.ajax({
            type: "POST",
            url: '/users/makeMod',
            data: {user: user_id, role: 2},
            success:{

            }
        })
    });
}
