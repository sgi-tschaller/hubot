# hubot
Plain vanilla hubot running on alpine

Initial Dockerfile based on the one found at
https://github.com/noqcks/alpine-hubot

# To run
docker run -it --rm --name sgi-hubot \
    -e HUBOT_HIPCHAT_HOST="hipchat.sgi.bio" \
    -e HUBOT_HIPCHAT_JID="put stuff here" \
    -e HUBOT_HIPCHAT_PASSWORD="put stuff here" \
    -e HUBOT_HIPCHAT_XMPP_DOMAIN="conf.btf.hipchat.com" \
    -e HUBOT_HIPCHAT_ROOMS="1_devops_swe@conf.btf.hipchat.com" \
    -e HUBOT_HIPCHAT_JOIN_PUBLIC_ROOMS=false \
    -e HUBOT_LOG_LEVEL=debug \
    -e HUBOT_AUTH_ROLES="admin=1,422,302" \
    -e HUBOT_STANDUP_PREPEND="@here" \
    -e HUBOT_STANDUP_WEEKDAYS="1-5" \
    sgi-hubot

#TODO:
Pull hubot creds from SSM prior to starting.
