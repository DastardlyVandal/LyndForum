function addRule(){
    $('.addRule').click(function(){
        $('.ruleList').append($('.new_rule_form').html())
    });
}
