module StreamsHelper
    def display_votes(posts)
        if user_signed_in?
            # If the current user make this post
            if current_user.posts.find_by_id(posts.id).present?
                # Don't let the users vote on their own posts
                vote_bar = '<span class="glyphicon glyphicon-thumbs-up disabled"></span>
                <span class="glyphicon glyphicon-thumbs-down disabled"></span>'
            else
                if @votes.where(post_id: posts.id, user_id: current_user.id).present?
                    # If the user has already voted
                    if @votes.where(post_id: posts.id, user_id: current_user.id).pluck(:vote) == [1]
                        # Display that they've voted up, and allow the user to vote down
                        vote_bar = '<span class="glyphicon glyphicon-thumbs-up voted"></span>
                        <span class="glyphicon glyphicon-thumbs-down vote-down" id="'+posts.id.to_s+'"></span>'
                    else
                        # Display that they've voted down, and allow the user to vote up
                        vote_bar = '<span class="glyphicon glyphicon-thumbs-up vote-up" id="'+posts.id.to_s+'"></span>
                        <span class="glyphicon glyphicon-thumbs-down voted"></span>'
                    end
                else
                    # User hasn't voted, so both buttons are enabled
                    vote_bar ='<span class="glyphicon glyphicon-thumbs-up vote-up"  id="'+posts.id.to_s+'"></span>
                    <span class="glyphicon glyphicon-thumbs-down vote-down"  id="'+posts.id.to_s+'"></span>'
                end
            end
        else
            # The user must sign in first to vote
            vote_bar ='<a href="/users/sign_in"><span class="glyphicon glyphicon-thumbs-up"></span></a>
            <a href="/users/sign_in"><span class="glyphicon glyphicon-thumbs-down"></span></a>'
        end

        return vote_bar.html_safe
    end
end
